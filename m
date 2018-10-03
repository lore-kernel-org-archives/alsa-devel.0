From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 2/7] aaf: Load configuration
	parameters
Date: Wed,  3 Oct 2018 16:45:42 -0700
Message-ID: <20181003234547.16839-3-andre.guedes@intel.com>
References: <20181003234547.16839-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DF64267844
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 01:46:52 +0200 (CEST)
In-Reply-To: <20181003234547.16839-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch implements the infrastructure to load the plugin
configuration from ALSA configuration file. The configuration
is loaded in open() callback.

All configuration parameters are described in details in doc/aaf.txt
file.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/aaf.txt   |  52 +++++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 7890e10..32db15e 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -20,11 +20,138 @@
 
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
+#include <linux/if.h>
+#include <linux/if_ether.h>
+#include <string.h>
+#include <stdint.h>
+
+#define NSEC_PER_USEC 1000
 
 typedef struct {
 	snd_pcm_ioplug_t io;
+
+	char ifname[IFNAMSIZ];
+	unsigned char addr[ETH_ALEN];
+	int prio;
+	uint64_t streamid;
+	int mtt;
+	int t_uncertainty;
+	snd_pcm_uframes_t frames_per_pdu;
 } snd_pcm_aaf_t;
 
+static int aaf_load_config(snd_pcm_aaf_t *aaf, snd_config_t *conf)
+{
+	snd_config_iterator_t cur, next;
+
+	snd_config_for_each(cur, next, conf) {
+		snd_config_t *entry = snd_config_iterator_entry(cur);
+		const char *id;
+
+		if (snd_config_get_id(entry, &id) < 0)
+			goto err;
+
+		if (strcmp(id, "comment") == 0 ||
+		    strcmp(id, "type") == 0 ||
+		    strcmp(id, "hint") == 0)
+			continue;
+
+		if (strcmp(id, "ifname") == 0) {
+			const char *ifname;
+
+			if (snd_config_get_string(entry, &ifname) < 0)
+				goto err;
+
+			snprintf(aaf->ifname, sizeof(aaf->ifname), "%s",
+				 ifname);
+		} else if (strcmp(id, "addr") == 0) {
+			const char *addr;
+			int n;
+
+			if (snd_config_get_string(entry, &addr) < 0)
+				goto err;
+
+			n = sscanf(addr, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+				   &aaf->addr[0], &aaf->addr[1],
+				   &aaf->addr[2], &aaf->addr[3],
+				   &aaf->addr[4], &aaf->addr[5]);
+			if (n != 6)
+				goto err;
+		} else if (strcmp(id, "prio") == 0) {
+			long prio;
+
+			if (snd_config_get_integer(entry, &prio) < 0)
+				goto err;
+
+			if (prio < 0)
+				goto err;
+
+			aaf->prio = prio;
+		} else if (strcmp(id, "streamid") == 0) {
+			const char *streamid;
+			unsigned char addr[6];
+			unsigned short unique_id;
+			int n;
+
+			if (snd_config_get_string(entry, &streamid) < 0)
+				goto err;
+
+			n = sscanf(streamid,
+				   "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx:%hx",
+				   &addr[0], &addr[1], &addr[2], &addr[3],
+				   &addr[4], &addr[5], &unique_id);
+			if (n != 7)
+				goto err;
+
+			aaf->streamid = (uint64_t) addr[0] << 56 |
+					(uint64_t) addr[1] << 48 |
+					(uint64_t) addr[2] << 40 |
+					(uint64_t) addr[3] << 32 |
+					(uint64_t) addr[4] << 24 |
+					(uint64_t) addr[5] << 16 |
+					unique_id;
+		} else if (strcmp(id, "mtt") == 0) {
+			long mtt;
+
+			if (snd_config_get_integer(entry, &mtt) < 0)
+				goto err;
+
+			if (mtt < 0)
+				goto err;
+
+			aaf->mtt = mtt * NSEC_PER_USEC;
+		} else if (strcmp(id, "time_uncertainty") == 0) {
+			long t_uncertainty;
+
+			if (snd_config_get_integer(entry, &t_uncertainty) < 0)
+				goto err;
+
+			if (t_uncertainty < 0)
+				goto err;
+
+			aaf->t_uncertainty = t_uncertainty * NSEC_PER_USEC;
+		} else if (strcmp(id, "frames_per_pdu") == 0) {
+			long frames_per_pdu;
+
+			if (snd_config_get_integer(entry, &frames_per_pdu) < 0)
+				goto err;
+
+			if (frames_per_pdu < 0)
+				goto err;
+
+			aaf->frames_per_pdu = frames_per_pdu;
+		} else {
+			SNDERR("Invalid configuration: %s", id);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	SNDERR("Error loading device configuration");
+	return -EINVAL;
+}
+
 static int aaf_close(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_aaf_t *aaf = io->private_data;
@@ -70,6 +197,10 @@ SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
 		return -ENOMEM;
 	}
 
+	res = aaf_load_config(aaf, conf);
+	if (res < 0)
+		goto err;
+
 	aaf->io.version = SND_PCM_IOPLUG_VERSION;
 	aaf->io.name = "AVTP Audio Format (AAF) Plugin";
 	aaf->io.callback = &aaf_callback;
diff --git a/doc/aaf.txt b/doc/aaf.txt
index b260a26..d817249 100644
--- a/doc/aaf.txt
+++ b/doc/aaf.txt
@@ -16,3 +16,55 @@ The AAF plugin uses libavtp to handle AVTP packetization. Libavtp source code
 can be found in https://github.com/AVnu/libavtp as well as instructions to
 build and install it. If libavtp isn't detected by configure, the plugin isn't
 built.
+
+Plugin Configuration and Usage
+------------------------------
+
+The plugin parameters are passed via ALSA configuration file. They are defined
+as follows:
+
+	* ifname: Network interface used to transmit/receive AVTP packets.
+
+	* addr: Stream destination MAC address.
+
+	* prio: Priority used by the plugin to transmit AVTP traffic. This
+	  option is relevant only when operating in playback mode.
+
+	* streamid: Stream ID associated with the AAF stream transmitted or
+	  received by the plugin.
+
+	* mtt: Maximum Transit Time (in microseconds) as defined in AVTP spec
+	  section 4.3.3. This option is relevant only when operating in
+	  playback mode.
+
+	* time_uncertainty: Maximum Time Uncertainty (in microseconds) as
+	  defined by AVTP spec section 4.3.3. This option is relevant only when
+	  operating in playback mode.
+
+	* frames_per_pdu: Number of audio frames transmitted in one AVTPDU.
+
+The plugin provides the PCM type "aaf". Configure an AAF PCM virtual device
+according to the AAF stream you want to transmit or receive. A hypothetical
+configuration file is shown below:
+
+	pcm.aaf {
+		type aaf
+		ifname eth0
+		addr AA:AA:AA:AA:AA:AA
+		prio 3
+		streamid BB:BB:BB:BB:BB:BB:0001
+		mtt 2000
+		time_uncertainty 125
+		frames_per_pdu 6
+	}
+
+Put the above to ~/.asoundrc (or /etc/asound.conf), and use the AAF PCM virtual
+device with your ALSA apps. For example, to stream the content from a wav file
+through the network, run:
+
+	$ aplay -Daaf foo.wav
+
+To receive the AAF stream generated by the previous command, run the following
+command in another host:
+
+	$ arecord -Daaf
-- 
2.14.4
