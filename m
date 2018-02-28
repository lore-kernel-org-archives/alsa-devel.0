From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: x86: Fix potential crash at error
	path
Date: Wed, 28 Feb 2018 08:52:54 +0100
Message-ID: <20180228075254.15649-2-tiwai@suse.de>
References: <20180228075254.15649-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 12FF72671EE
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 08:52:57 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1D78AAD4D
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 07:52:57 +0000 (UTC)
In-Reply-To: <20180228075254.15649-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

When LPE audio driver gets some error at probing, it may lead to a
crash because of canceling the pending work in hdmi_lpe_audio_free(),
since some of ports might be still not initialized.

For assuring the proper free of each port, initialize all ports at the
beginning of the probe.

Fixes: b4eb0d522fcb ("ALSA: x86: Split snd_intelhad into card and PCM specific structures")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index cec62f9b7085..4ed9d0c41843 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1751,6 +1751,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 {
 	struct snd_card *card;
 	struct snd_intelhad_card *card_ctx;
+	struct snd_intelhad *ctx;
 	struct snd_pcm *pcm;
 	struct intel_hdmi_lpe_audio_pdata *pdata;
 	int irq;
@@ -1795,6 +1796,21 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, card_ctx);
 
+	card_ctx->num_pipes = pdata->num_pipes;
+	card_ctx->num_ports = single_port ? 1 : pdata->num_ports;
+
+	for_each_port(card_ctx, port) {
+		ctx = &card_ctx->pcm_ctx[port];
+		ctx->card_ctx = card_ctx;
+		ctx->dev = card_ctx->dev;
+		ctx->port = single_port ? -1 : port;
+		ctx->pipe = -1;
+
+		spin_lock_init(&ctx->had_spinlock);
+		mutex_init(&ctx->mutex);
+		INIT_WORK(&ctx->hdmi_audio_wq, had_audio_wq);
+	}
+
 	dev_dbg(&pdev->dev, "%s: mmio_start = 0x%x, mmio_end = 0x%x\n",
 		__func__, (unsigned int)res_mmio->start,
 		(unsigned int)res_mmio->end);
@@ -1827,18 +1843,9 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	card_ctx->num_ports = single_port ? 1 : pdata->num_ports;
 
 	for_each_port(card_ctx, port) {
-		struct snd_intelhad *ctx = &card_ctx->pcm_ctx[port];
 		int i;
 
-		ctx->card_ctx = card_ctx;
-		ctx->dev = card_ctx->dev;
-		ctx->port = single_port ? -1 : port;
-		ctx->pipe = -1;
-
-		spin_lock_init(&ctx->had_spinlock);
-		mutex_init(&ctx->mutex);
-		INIT_WORK(&ctx->hdmi_audio_wq, had_audio_wq);
-
+		ctx = &card_ctx->pcm_ctx[port];
 		ret = snd_pcm_new(card, INTEL_HAD, port, MAX_PB_STREAMS,
 				  MAX_CAP_STREAMS, &pcm);
 		if (ret)
-- 
2.16.2
