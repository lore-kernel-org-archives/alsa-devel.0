From: linux@audioscience.com
Subject: [PATCH 03/21] Low latency mode stream has fixed
	channel count.
Date: Thu, 22 Dec 2011 13:38:33 +1300
Message-ID: <1324514331-22570-4-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 7498C103BE4
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:02 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:23 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Unlike other streams which support 1..max channels,

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index e9de799..a97a252 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -135,6 +135,8 @@ struct snd_card_asihpi {
 	u16 update_interval_frames;
 	u16 in_max_chans;
 	u16 out_max_chans;
+	u16 in_min_chans;
+	u16 out_min_chans;
 };
 
 /* Per stream data */
@@ -968,8 +970,6 @@ static void snd_card_asihpi_playback_format(struct snd_card_asihpi *asihpi,
 }
 
 static struct snd_pcm_hardware snd_card_asihpi_playback = {
-	.channels_min = 1,
-	.channels_max = 2,
 	.buffer_bytes_max = BUFFER_BYTES_MAX,
 	.period_bytes_min = PERIOD_BYTES_MIN,
 	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
@@ -1013,6 +1013,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
 	snd_card_asihpi_playback.channels_max = card->out_max_chans;
+	snd_card_asihpi_playback.channels_min = card->out_min_chans;
 	/*?snd_card_asihpi_playback.period_bytes_min =
 	card->out_max_chans * 4096; */
 
@@ -1150,8 +1151,6 @@ static void snd_card_asihpi_capture_format(struct snd_card_asihpi *asihpi,
 
 
 static struct snd_pcm_hardware snd_card_asihpi_capture = {
-	.channels_min = 1,
-	.channels_max = 2,
 	.buffer_bytes_max = BUFFER_BYTES_MAX,
 	.period_bytes_min = PERIOD_BYTES_MIN,
 	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
@@ -1193,6 +1192,7 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
 	snd_card_asihpi_capture.channels_max = card->in_max_chans;
+	snd_card_asihpi_capture.channels_min = card->in_min_chans;
 	snd_card_asihpi_capture_format(card, dpcm->h_stream,
 				       &snd_card_asihpi_capture);
 	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_capture);
@@ -2883,6 +2883,15 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 		asihpi->out_max_chans = 2;
 	}
 
+	if (asihpi->out_max_chans > 2) { /* assume LL mode */
+		asihpi->out_min_chans = asihpi->out_max_chans;
+		asihpi->in_min_chans = asihpi->in_max_chans;
+		asihpi->support_grouping = 0;
+	} else {
+		asihpi->out_min_chans = 1;
+		asihpi->in_min_chans = 1;
+	}
+
 	snd_printk(KERN_INFO "has dma:%d, grouping:%d, mrx:%d\n",
 			asihpi->can_dma,
 			asihpi->support_grouping,
-- 
1.7.0.4
