From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/6] ALSA: fireworks: drop reusing incoming
	packet parameter for ougoing packet parameter
Date: Mon, 25 Apr 2016 21:45:59 +0900
Message-ID: <1461588363-21157-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1461588363-21157-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B43E265068
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 14:46:06 +0200 (CEST)
In-Reply-To: <1461588363-21157-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Fireworks board module of Echo Audio, TSB43Cx43A (IceLynx Micro, iCEM)
is used to process payload of isochronous packets. There's an public
document of this chip[1]. This document is for firmware programmers to
transfer/receive AMDTP with IEC60958 data format, however in clause 2.5,
2.6 and 2.7, we can see system design to utilize the sequence of value in
SYT field of CIP header. In clause 2.3, we can see the specification of
Audio Master Clock (MCLK) from iCEM.

Well, this clock is actually not used for sampling clock. This can be
confirmed when corresponding driver transfer random value as the sequence
of SYT field. Even if in this case, the unit generates proper sound.

Additionally, in unique command set for this board module, the format
of CIP is changed; for IEC 61883-6 mode which we use, and for Windows
Operating System. In the latter mode, the whole 32 bit field in second CIP
header from Windows driver is used to represent counter of packets (NO-DATA
code is still used for packets without data blocks). If the master clock
was physically used by DSP on the board module, the Windows driver must
have transferred correct sequence of SYT field.

Furthermore, as long as seeing capacities of AudioFire2, AudioFire4,
AudioFire8, AudioFirePre8 and AudioFire12, these models don't support
SYT-Match clock source.

Summary, we have no need to relate incoming/outgoing packets. This commit
drops reusing SYT sequence of incoming packets for outgoing packets.

[1] Using TSB43Cx43A: S/PDIF over 1394 (2003, Texus Instruments
Incorporated)
http://www.ti.com/analog/docs/litabsmultiplefilelist.tsp?literatureNumber=slla148&docCategoryId=1&familyId=361

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.h        |  1 -
 sound/firewire/fireworks/fireworks_stream.c | 84 ++++++-----------------------
 2 files changed, 17 insertions(+), 68 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 471c772..03ed352 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -84,7 +84,6 @@ struct snd_efw {
 	unsigned int pcm_capture_channels[SND_EFW_MULTIPLIER_MODES];
 	unsigned int pcm_playback_channels[SND_EFW_MULTIPLIER_MODES];
 
-	struct amdtp_stream *master;
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
 	struct cmp_connection out_conn;
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 425db8d..ee47924 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -121,23 +121,6 @@ destroy_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 }
 
 static int
-get_sync_mode(struct snd_efw *efw, enum cip_flags *sync_mode)
-{
-	enum snd_efw_clock_source clock_source;
-	int err;
-
-	err = snd_efw_command_get_clock_source(efw, &clock_source);
-	if (err < 0)
-		return err;
-
-	if (clock_source == SND_EFW_CLOCK_SOURCE_SYTMATCH)
-		return -ENOSYS;
-
-	*sync_mode = CIP_SYNC_TO_DEVICE;
-	return 0;
-}
-
-static int
 check_connection_used_by_others(struct snd_efw *efw, struct amdtp_stream *s)
 {
 	struct cmp_connection *conn;
@@ -208,9 +191,6 @@ end:
 
 int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 {
-	struct amdtp_stream *master, *slave;
-	unsigned int slave_substreams;
-	enum cip_flags sync_mode;
 	unsigned int curr_rate;
 	int err = 0;
 
@@ -218,32 +198,19 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	if (efw->playback_substreams == 0 && efw->capture_substreams  == 0)
 		goto end;
 
-	err = get_sync_mode(efw, &sync_mode);
-	if (err < 0)
-		goto end;
-	if (sync_mode == CIP_SYNC_TO_DEVICE) {
-		master = &efw->tx_stream;
-		slave  = &efw->rx_stream;
-		slave_substreams  = efw->playback_substreams;
-	} else {
-		master = &efw->rx_stream;
-		slave  = &efw->tx_stream;
-		slave_substreams = efw->capture_substreams;
-	}
-
 	/*
 	 * Considering JACK/FFADO streaming:
 	 * TODO: This can be removed hwdep functionality becomes popular.
 	 */
-	err = check_connection_used_by_others(efw, master);
+	err = check_connection_used_by_others(efw, &efw->rx_stream);
 	if (err < 0)
 		goto end;
 
 	/* packet queueing error */
-	if (amdtp_streaming_error(slave))
-		stop_stream(efw, slave);
-	if (amdtp_streaming_error(master))
-		stop_stream(efw, master);
+	if (amdtp_streaming_error(&efw->tx_stream))
+		stop_stream(efw, &efw->tx_stream);
+	if (amdtp_streaming_error(&efw->rx_stream))
+		stop_stream(efw, &efw->rx_stream);
 
 	/* stop streams if rate is different */
 	err = snd_efw_command_get_sampling_rate(efw, &curr_rate);
@@ -252,20 +219,17 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	if (rate == 0)
 		rate = curr_rate;
 	if (rate != curr_rate) {
-		stop_stream(efw, slave);
-		stop_stream(efw, master);
+		stop_stream(efw, &efw->tx_stream);
+		stop_stream(efw, &efw->rx_stream);
 	}
 
 	/* master should be always running */
-	if (!amdtp_stream_running(master)) {
-		amdtp_stream_set_sync(sync_mode, master, slave);
-		efw->master = master;
-
+	if (!amdtp_stream_running(&efw->rx_stream)) {
 		err = snd_efw_command_set_sampling_rate(efw, rate);
 		if (err < 0)
 			goto end;
 
-		err = start_stream(efw, master, rate);
+		err = start_stream(efw, &efw->rx_stream, rate);
 		if (err < 0) {
 			dev_err(&efw->unit->device,
 				"fail to start AMDTP master stream:%d\n", err);
@@ -274,12 +238,13 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw, unsigned int rate)
 	}
 
 	/* start slave if needed */
-	if (slave_substreams > 0 && !amdtp_stream_running(slave)) {
-		err = start_stream(efw, slave, rate);
+	if (efw->capture_substreams > 0 &&
+	    !amdtp_stream_running(&efw->tx_stream)) {
+		err = start_stream(efw, &efw->tx_stream, rate);
 		if (err < 0) {
 			dev_err(&efw->unit->device,
 				"fail to start AMDTP slave stream:%d\n", err);
-			stop_stream(efw, master);
+			stop_stream(efw, &efw->rx_stream);
 		}
 	}
 end:
@@ -288,26 +253,11 @@ end:
 
 void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 {
-	struct amdtp_stream *master, *slave;
-	unsigned int master_substreams, slave_substreams;
-
-	if (efw->master == &efw->rx_stream) {
-		slave  = &efw->tx_stream;
-		master = &efw->rx_stream;
-		slave_substreams  = efw->capture_substreams;
-		master_substreams = efw->playback_substreams;
-	} else {
-		slave  = &efw->rx_stream;
-		master = &efw->tx_stream;
-		slave_substreams  = efw->playback_substreams;
-		master_substreams = efw->capture_substreams;
-	}
-
-	if (slave_substreams == 0) {
-		stop_stream(efw, slave);
+	if (efw->capture_substreams == 0) {
+		stop_stream(efw, &efw->tx_stream);
 
-		if (master_substreams == 0)
-			stop_stream(efw, master);
+		if (efw->playback_substreams == 0)
+			stop_stream(efw, &efw->rx_stream);
 	}
 }
 
-- 
2.7.4
