From: Andre Guedes <andre.guedes@intel.com>
Subject: [RFC - AAF PCM plugin 4/5] aaf: Prepare for Capture
	mode support
Date: Mon, 20 Aug 2018 18:06:52 -0700
Message-ID: <20180821010653.15838-5-andre.guedes@intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FB092676C7
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 03:07:08 +0200 (CEST)
In-Reply-To: <20180821010653.15838-1-andre.guedes@intel.com>
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
Cc: liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The plugin code assumes only Playback mode is supported. This patch
prepares the code to support both Playback and Capture mode. Capture
mode support is implemented by a follow-up patch.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 156 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 91 insertions(+), 65 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 72f6652..e098247 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -234,6 +234,7 @@ static int aaf_init_socket(snd_pcm_aaf_t *aaf)
 {
 	int fd, res;
 	struct ifreq req;
+	snd_pcm_ioplug_t *io = &aaf->io;
 
 	fd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_TSN));
 	if (fd < 0) {
@@ -255,12 +256,17 @@ static int aaf_init_socket(snd_pcm_aaf_t *aaf)
 	aaf->sk_addr.sll_ifindex = req.ifr_ifindex;
 	memcpy(&aaf->sk_addr.sll_addr, aaf->addr, ETH_ALEN);
 
-	res = setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &aaf->prio,
-			 sizeof(aaf->prio));
-	if (res < 0) {
-		SNDERR("Failed to set socket priority");
-		res = -errno;
-		goto err;
+	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		res = setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &aaf->prio,
+				 sizeof(aaf->prio));
+		if (res < 0) {
+			SNDERR("Failed to set socket priority");
+			res = -errno;
+			goto err;
+		}
+	} else {
+		/* TODO: Implement Capture mode support. */
+		return -ENOTSUP;
 	}
 
 	aaf->sk_fd = fd;
@@ -300,46 +306,50 @@ static int aaf_init_pdu(snd_pcm_aaf_t *aaf)
 	if (!pdu)
 		return -ENOMEM;
 
-	res = avtp_aaf_pdu_init(pdu);
-	if (res < 0)
-		goto err;
+	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		res = avtp_aaf_pdu_init(pdu);
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_TV, 1);
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_TV, 1);
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_ID, aaf->streamid);
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_ID,
+				       aaf->streamid);
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_FORMAT,
-			       alsa_to_avtp_format(io->format));
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_FORMAT,
+				       alsa_to_avtp_format(io->format));
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_NSR,
-			       alsa_to_avtp_rate(io->rate));
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_NSR,
+				       alsa_to_avtp_rate(io->rate));
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_CHAN_PER_FRAME,
-			       io->channels);
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_CHAN_PER_FRAME,
+				       io->channels);
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_BIT_DEPTH,
-			       snd_pcm_format_width(io->format));
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_BIT_DEPTH,
+				       snd_pcm_format_width(io->format));
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_DATA_LEN,
-			       payload_size);
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_STREAM_DATA_LEN,
+				       payload_size);
+		if (res < 0)
+			goto err;
 
-	res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_SP, AVTP_AAF_PCM_SP_NORMAL);
-	if (res < 0)
-		goto err;
+		res = avtp_aaf_pdu_set(pdu, AVTP_AAF_FIELD_SP,
+				       AVTP_AAF_PCM_SP_NORMAL);
+		if (res < 0)
+			goto err;
+	}
 
 	aaf->pdu = pdu;
 	aaf->pdu_size = pdu_size;
@@ -665,7 +675,10 @@ static snd_pcm_sframes_t aaf_pointer(snd_pcm_ioplug_t *io)
 
 static int aaf_poll_descriptors_count(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED)
 {
-	return FD_COUNT_PLAYBACK;
+	if (io->stream == SND_PCM_STREAM_PLAYBACK)
+		return FD_COUNT_PLAYBACK;
+	else
+		return -ENOTSUP;
 }
 
 static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
@@ -673,11 +686,17 @@ static int aaf_poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfd,
 {
 	snd_pcm_aaf_t *aaf = io->private_data;
 
-	if (space != FD_COUNT_PLAYBACK)
-		return -EINVAL;
+	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		if (space != FD_COUNT_PLAYBACK)
+			return -EINVAL;
+
+		pfd[0].fd = aaf->timer_fd;
+		pfd[0].events = POLLIN;
+	} else {
+		/* TODO: Implement Capture mode support. */
+		return -ENOTSUP;
+	}
 
-	pfd[0].fd = aaf->timer_fd;
-	pfd[0].events = POLLIN;
 	return space;
 }
 
@@ -687,15 +706,20 @@ static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd *pfd,
 	int res;
 	snd_pcm_aaf_t *aaf = io->private_data;
 
-	if (nfds != FD_COUNT_PLAYBACK)
-		return -EINVAL;
+	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		if (nfds != FD_COUNT_PLAYBACK)
+			return -EINVAL;
 
-	if (pfd[0].revents & POLLIN) {
-		res = aaf_mclk_timeout_playback(aaf);
-		if (res < 0)
-			return res;
+		if (pfd[0].revents & POLLIN) {
+			res = aaf_mclk_timeout_playback(aaf);
+			if (res < 0)
+				return res;
 
-		*revents = POLLIN;
+			*revents = POLLIN;
+		}
+	} else {
+		/* TODO: Implement Capture mode support. */
+		return -ENOTSUP;
 	}
 
 	return 0;
@@ -727,9 +751,11 @@ static int aaf_start(snd_pcm_ioplug_t *io)
 	if (res < 0)
 		goto err_close_sk;
 
-	res = aaf_mclk_start_playback(aaf);
-	if (res < 0)
-		goto err_close_timer;
+	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		res = aaf_mclk_start_playback(aaf);
+		if (res < 0)
+			goto err_close_timer;
+	}
 
 	return 0;
 
@@ -757,12 +783,18 @@ static snd_pcm_sframes_t aaf_transfer(snd_pcm_ioplug_t *io,
 	int res;
 	snd_pcm_aaf_t *aaf = io->private_data;
 
-	res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
-				      (io->appl_ptr % aaf->buffer_size),
-				      aaf->buffer_size, areas, offset, size,
-				      io->channels, size, io->format);
-	if (res < 0)
-		return res;
+	if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+		res = snd_pcm_areas_copy_wrap(aaf->audiobuf_areas,
+					      (io->appl_ptr % aaf->buffer_size),
+					      aaf->buffer_size, areas, offset,
+					      size, io->channels, size,
+					      io->format);
+		if (res < 0)
+			return res;
+	} else {
+		/* TODO: Implement Capture mode support. */
+		return -ENOTSUP;
+	}
 
 	return size;
 }
@@ -787,12 +819,6 @@ SND_PCM_PLUGIN_DEFINE_FUNC(aaf)
 	snd_pcm_aaf_t *aaf;
 	int res;
 
-	/* For now the plugin only supports Playback mode i.e. AAF Talker
-	 * functionality.
-	 */
-	if (stream != SND_PCM_STREAM_PLAYBACK)
-		return -EINVAL;
-
 	aaf = calloc(1, sizeof(*aaf));
 	if (!aaf) {
 		SNDERR("Failed to allocate memory");
-- 
2.14.4
