From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/21] ALSA: hda - Move prepared flag into
	struct hdac_stream
Date: Fri, 24 Apr 2015 14:38:50 +0200
Message-ID: <1429879133-32293-19-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A222605F3
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DAE6CADB4
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
In-Reply-To: <1429879133-32293-1-git-send-email-tiwai@suse.de>
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

This flag seems used commonly, so deserves to be located there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h        | 1 +
 sound/pci/hda/hda_controller.c | 8 ++++----
 sound/pci/hda/hda_controller.h | 1 -
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 15bc039de78d..dbeb195eb4e8 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -390,6 +390,7 @@ struct hdac_stream {
 
 	bool opened:1;
 	bool running:1;
+	bool prepared:1;
 	bool no_period_wakeup:1;
 	bool locked:1;
 
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 9bc8eaf0e5ac..14ffb6bd986c 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -145,7 +145,7 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 	snd_hda_codec_cleanup(apcm->codec, hinfo, substream);
 
 	err = chip->ops->substream_free_pages(chip, substream);
-	azx_dev->prepared = 0;
+	azx_stream(azx_dev)->prepared = 0;
 	dsp_unlock(azx_dev);
 	return err;
 }
@@ -214,7 +214,7 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 
  unlock:
 	if (!err)
-		azx_dev->prepared = 1;
+		azx_stream(azx_dev)->prepared = 1;
 	dsp_unlock(azx_dev);
 	return err;
 }
@@ -240,7 +240,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	else
 		sync_reg = AZX_REG_SSYNC;
 
-	if (dsp_is_locked(azx_dev) || !azx_dev->prepared)
+	if (dsp_is_locked(azx_dev) || !hstr->prepared)
 		return -EPIPE;
 
 	switch (cmd) {
@@ -843,7 +843,7 @@ int snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int format,
 		return err;
 	}
 
-	azx_dev->prepared = 0;
+	hstr->prepared = 0;
 	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_load_dsp_prepare);
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 407cba6577b8..173bf7c85b6e 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -62,7 +62,6 @@ struct azx_dev {
 	struct hdac_stream core;
 
 	unsigned int irq_pending:1;
-	unsigned int prepared:1;
 	/*
 	 * For VIA:
 	 *  A flag to ensure DMA position is 0
-- 
2.3.5
