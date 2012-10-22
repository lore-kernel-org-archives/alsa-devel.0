From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ALSA: hda - remove unused variable in azx_position_ok()
Date: Mon, 22 Oct 2012 16:30:10 +0800
Message-ID: <CAPgLHd9ydHRoc_Zd43=Fedfn61S3NxBcAoqoOq=cFutjRuPpoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable stream is initialized but never used
otherwise, so remove the unused variable.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/pci/hda/hda_intel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 72b085a..0ceed85 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2193,13 +2193,11 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 {
 	u32 wallclk;
 	unsigned int pos;
-	int stream;
 
 	wallclk = azx_readl(chip, WALLCLK) - azx_dev->start_wallclk;
 	if (wallclk < (azx_dev->period_wallclk * 2) / 3)
 		return -1;	/* bogus (too early) interrupt */
 
-	stream = azx_dev->substream->stream;
 	pos = azx_get_position(chip, azx_dev, true);
 
 	if (WARN_ONCE(!azx_dev->period_bytes,
