From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 7/7] aaf: AVTPDU transmission
	periodicity
Date: Fri,  7 Dec 2018 17:55:50 -0800
Message-ID: <20181208015550.20268-8-andre.guedes@intel.com>
References: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id B7C26267D3B
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 03:02:26 +0100 (CET)
In-Reply-To: <20181208015550.20268-1-andre.guedes@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

When operating in playback mode (i.e. AVTP talker) the plugin is
expected to transmit the AVTPDUs in a periodical manner. The AVTPDU
period is defined by the number of audio frames per AVTPDU and the
sampling rate (see section 7.7 from AVTP spec [1] for further
information).

To enforce the AVTPDU periodicity, this patch leverages the SO_TXTIME
sockopt recently added to socket interface which enables the userspace
to specify when a given packet should be transmitted. The plugin
configures the transmission time from each AVTPDU so the expected
transmission interval is maintained.

The SO_TXTIME feature works in conjunction with the Earliest TxTime
First (ETF) qdisc. The ETF qdisc sorts packets from multiple sockets by
the earliest transmission time and sends them to the network controller.
It also enables offloading packet transmission to hardware in case the
NIC supports it, providing more time accuracy. For further information
about ETF qdisc, see tc-etf(8). The qdisc can be configured many ways,
in doc/aaf.txt we provide an example.

Below follows some implementation highlights:

The packet transmission time is configured through socket control
message interface so we now use sendmsg() to transmit AVTPDUs, instead
of sendto().

sendmsg() API requires a msghdr struct which is initialized during
device setup time. Strictly speaking, that struct is only required when
operating in playback mode but we initialize it always, no matter if
running in playback or capture mode. This makes hw_params() and
hw_free() callbacks implementation way more simpler, specially on
handling error cases.

[1] 1722-2016 - IEEE Standard for a Transport Protocol for Time-Sensitive
    Applications in Bridged Local Area Networks

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++----
 configure.ac  |   2 +-
 doc/aaf.txt   |  25 +++++++++----
 3 files changed, 111 insertions(+), 17 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 284cbfd..cc7dbe3 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -27,6 +27,7 @@
 #include <limits.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
+#include <linux/net_tstamp.h>
 #include <net/if.h>
 #include <string.h>
 #include <stdbool.h>
@@ -71,6 +72,9 @@ typedef struct {
 	int pdu_size;
 	uint8_t pdu_seq;
 
+	struct msghdr *msg;
+	struct cmsghdr *cmsg;
+
 	uint64_t timer_starttime;
 	uint64_t timer_period;
 	uint64_t timer_expirations;
@@ -282,6 +286,8 @@ static int aaf_init_socket(snd_pcm_aaf_t *aaf)
 	memcpy(&aaf->sk_addr.sll_addr, aaf->addr, ETH_ALEN);
 
 	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		struct sock_txtime txtime_cfg;
+
 		res = setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &aaf->prio,
 				 sizeof(aaf->prio));
 		if (res < 0) {
@@ -289,6 +295,16 @@ static int aaf_init_socket(snd_pcm_aaf_t *aaf)
 			res = -errno;
 			goto err;
 		}
+
+		txtime_cfg.clockid = CLOCK_TAI;
+		txtime_cfg.flags = 0;
+		res = setsockopt(fd, SOL_SOCKET, SO_TXTIME, &txtime_cfg,
+				sizeof(txtime_cfg));
+		if (res < 0) {
+			SNDERR("Failed to configure txtime");
+			res = -errno;
+			goto err;
+		}
 	} else {
 		struct packet_mreq mreq = { 0 };
 
@@ -447,6 +463,62 @@ err:
 	return res;
 }
 
+static int aaf_init_msghdr(snd_pcm_aaf_t *aaf)
+{
+	int res;
+	struct iovec *iov;
+	char *control;
+	size_t controllen;
+	struct msghdr *msg;
+	struct cmsghdr *cmsg;
+
+	iov = malloc(sizeof(struct iovec));
+	if (!iov) {
+		SNDERR("Failed to allocate iovec");
+		return -ENOMEM;
+	}
+
+	iov->iov_base = aaf->pdu;
+	iov->iov_len = aaf->pdu_size;
+
+	controllen = CMSG_SPACE(sizeof(__u64));
+	control = malloc(controllen);
+	if (!control) {
+		SNDERR("Failed to allocate control buffer");
+		res = -ENOMEM;
+		goto err_free_iov;
+	}
+
+	msg = malloc(sizeof(struct msghdr));
+	if (!msg) {
+		SNDERR("Failed to allocate msghdr");
+		res = -ENOMEM;
+		goto err_free_control;
+	}
+
+	msg->msg_name = &aaf->sk_addr;
+	msg->msg_namelen = sizeof(aaf->sk_addr);
+	msg->msg_iov = iov;
+	msg->msg_iovlen = 1;
+	msg->msg_control = control;
+	msg->msg_controllen = controllen;
+
+	cmsg = CMSG_FIRSTHDR(msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_TXTIME;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(__u64));
+
+	aaf->msg = msg;
+	aaf->cmsg = cmsg;
+	return 0;
+
+err_free_control:
+	free(control);
+err_free_iov:
+	free(iov);
+	return res;
+}
+
 static void aaf_inc_ptr(snd_pcm_uframes_t *ptr, snd_pcm_uframes_t val,
 			snd_pcm_uframes_t boundary)
 {
@@ -565,13 +637,15 @@ static uint64_t aaf_mclk_gettime(snd_pcm_aaf_t *aaf)
 }
 
 static int aaf_tx_pdu(snd_pcm_aaf_t *aaf, snd_pcm_uframes_t ptr,
-		      uint64_t ptime)
+		      uint64_t ptime, __u64 txtime)
 {
 	int res;
 	ssize_t n;
 	snd_pcm_ioplug_t *io = &aaf->io;
 	struct avtp_stream_pdu *pdu = aaf->pdu;
 
+	*(__u64 *)CMSG_DATA(aaf->cmsg) = txtime;
+
 	res = snd_pcm_areas_copy_wrap(aaf->payload_areas, 0,
 				      aaf->frames_per_pdu,
 				      aaf->audiobuf_areas,
@@ -591,9 +665,7 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf, snd_pcm_uframes_t ptr,
 	if (res < 0)
 		return res;
 
-	n = sendto(aaf->sk_fd, aaf->pdu, aaf->pdu_size, 0,
-		   (struct sockaddr *) &aaf->sk_addr,
-		   sizeof(aaf->sk_addr));
+	n = sendmsg(aaf->sk_fd, aaf->msg, 0);
 	if (n < 0 || n != aaf->pdu_size) {
 		SNDERR("Failed to send AAF PDU");
 		return -EIO;
@@ -605,17 +677,19 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf, snd_pcm_uframes_t ptr,
 static int aaf_tx_pdus(snd_pcm_aaf_t *aaf, int pdu_count)
 {
 	int res;
-	uint64_t ptime;
+	uint64_t ptime, txtime;
 	snd_pcm_uframes_t ptr;
 
-	ptime = aaf_mclk_gettime(aaf) + aaf->mtt + aaf->t_uncertainty;
+	txtime = aaf_mclk_gettime(aaf) + aaf->t_uncertainty;
+	ptime = txtime + aaf->mtt;
 	ptr = aaf->hw_ptr;
 
 	while (pdu_count--) {
-		res = aaf_tx_pdu(aaf, ptr, ptime);
+		res = aaf_tx_pdu(aaf, ptr, ptime, txtime);
 		if (res < 0)
 			return res;
 
+		txtime += aaf->pdu_period;
 		ptime += aaf->pdu_period;
 		ptr += aaf->frames_per_pdu;
 	}
@@ -1075,6 +1149,10 @@ static int aaf_hw_params(snd_pcm_ioplug_t *io,
 	if (res < 0)
 		goto err_free_pdu;
 
+	res = aaf_init_msghdr(aaf);
+	if (res < 0)
+		goto err_free_areas;
+
 	if (io->period_size % aaf->frames_per_pdu) {
 		/* The plugin requires that the period size is multiple of the
 		 * configuration frames_per_pdu. Return error if this
@@ -1082,13 +1160,17 @@ static int aaf_hw_params(snd_pcm_ioplug_t *io,
 		 */
 		SNDERR("Period size must be multiple of frames_per_pdu");
 		res = -EINVAL;
-		goto err_free_areas;
+		goto err_free_msghdr;
 	}
 
 	aaf->pdu_period = (uint64_t)NSEC_PER_SEC * aaf->frames_per_pdu /
 			  io->rate;
 	return 0;
 
+err_free_msghdr:
+	free(aaf->msg->msg_iov);
+	free(aaf->msg->msg_control);
+	free(aaf->msg);
 err_free_areas:
 	free(aaf->payload_areas);
 err_free_pdu:
@@ -1108,6 +1190,9 @@ static int aaf_hw_free(snd_pcm_ioplug_t *io)
 	close(aaf->timer_fd);
 	free(aaf->pdu);
 	free(aaf->payload_areas);
+	free(aaf->msg->msg_iov);
+	free(aaf->msg->msg_control);
+	free(aaf->msg);
 	return 0;
 }
 
diff --git a/configure.ac b/configure.ac
index 1eb9d65..d300ef0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -181,7 +181,7 @@ AC_ARG_ENABLE([aaf],
 
 if test "x$enable_aaf" != "xno"; then
   PKG_CHECK_MODULES(AVTP, avtp >= 0.1, [HAVE_AAF=yes], [HAVE_AAF=no])
-  AC_CHECK_HEADERS([linux/if_ether.h linux/if_packet.h], [], [HAVE_AAF=no])
+  AC_CHECK_HEADERS([linux/if_ether.h linux/if_packet.h linux/net_tstamp.h], [], [HAVE_AAF=no])
 fi
 AM_CONDITIONAL(HAVE_AAF, test x$HAVE_AAF = xyes)
 
diff --git a/doc/aaf.txt b/doc/aaf.txt
index e12a6f6..7bf3671 100644
--- a/doc/aaf.txt
+++ b/doc/aaf.txt
@@ -56,8 +56,8 @@ Synchronize system clock with PTP clock:
 
 The commands above should be run on both AVTP Talker and Listener hosts.
 
-FQTSS Setup
------------
+Traffic Control Setup
+---------------------
 
 The Linux Traffic Control system provides the mqprio and cbs qdiscs which
 enable FQTSS on Linux. Below we provide an example to configure those qdiscs in
@@ -69,18 +69,27 @@ tc-cbs(8) man pages.
 On the host that will run as AVTP Talker (i.e. plugin in playback mode), run
 the following commands:
 
-Configure mpqrio qdisc (replace $HANDLE_ID by an unused handle ID):
+Configure mpqrio qdisc (replace $MQPRIO_HANDLE_ID by an unused handle ID):
 
-	$ tc qdisc add dev $IFNAME parent root handle $HANDLE_ID mqprio \
-			num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
+	$ tc qdisc add dev $IFNAME parent root handle $MQPRIO_HANDLE_ID \
+			mqprio num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
 			queues 1@0 1@1 2@2 hw 0
 
-Configure cbs qdisc:
+Configure cbs qdisc (replace $CBS_HANDLE_ID by an unused handle ID):
 
-	$ tc qdisc replace dev $IFNAME parent $HANDLE_ID:1 cbs idleslope 5760 \
+	$ tc qdisc replace dev $IFNAME parent $MQPRIO_HANDLE_ID:1 \
+			handle $CBS_HANDLE_ID cbs idleslope 5760 \
 			sendslope -994240 hicredit 9 locredit -89 offload 1
 
-No FQTSS configuration is required at the host running as AVTP Listener.
+The plugin implements a transmission mechanism that relies on ETF qdisc so make
+sure it is properly configured in the system. It could be configured many way,
+below follows an example.
+
+	$ tc qdisc add dev $IFNAME parent $CBS_HANDLE_ID:1 etf \
+			clockid CLOCK_TAI delta 500000 offload
+
+No Traffic Control configuration is required at the host running as AVTP
+Listener.
 
 Plugin Dependencies
 -------------------
-- 
2.19.1
