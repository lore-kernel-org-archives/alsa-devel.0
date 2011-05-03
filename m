From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [PATCH] SOC: UDA134x: Remove POWER_OFF_ON_STANDBY define.
Date: Tue,  3 May 2011 14:46:32 +0200
Message-ID: <1304426792-23540-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: alsa-devel@alsa-project.org

Define POWER_OFF_ON_STANDBY cause trobles when trying to get some
sound from codec because code for bias setup was not compiled
(define wasn't defined). This define was removed in commit:
cc3202f5 but again introduced by commit: f0fba2ad1 which then
completely break codec functionality so remove it again.

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 sound/soc/codecs/uda134x.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 48ffd40..a7b8f30 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -601,9 +601,7 @@ static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.reg_cache_step = 1,
 	.read = uda134x_read_reg_cache,
 	.write = uda134x_write,
-#ifdef POWER_OFF_ON_STANDBY
 	.set_bias_level = uda134x_set_bias_level,
-#endif
 };
 
 static int __devinit uda134x_codec_probe(struct platform_device *pdev)
-- 
1.7.4.1
