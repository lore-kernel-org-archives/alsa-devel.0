From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8991: remove unused variable" to the
	asoc tree
Date: Tue, 27 Sep 2016 09:24:54 -0700
Message-ID: <E1bovBe-0004BY-Eb@finisterre>
References: <1474932329-10640-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C1B79266F74
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:25:12 +0200 (CEST)
In-Reply-To: <1474932329-10640-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8991: remove unused variable

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c7e9426a02699b9f0873e3c2bb383bcb1dd9ab19 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 27 Sep 2016 08:25:28 +0900
Subject: [PATCH] ASoC: wm8991: remove unused variable

This driver has some unused variables. They should be removed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8991.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 483b9535d366..9d4b6076e9a8 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -111,14 +111,12 @@ static bool wm8991_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(in_pga_tlv, -1650, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(out_mix_tlv, -2100, 300, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_pga_tlv,
 	0x00, 0x2f, SNDRV_CTL_TLVD_DB_SCALE_ITEM(SNDRV_CTL_TLVD_DB_GAIN_MUTE, 0, 1),
 	0x30, 0x7f, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-7300, 100, 0),
 );
-static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_dac_tlv,
 	0x00, 0xbf, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-71625, 375, 1),
 	0xc0, 0xff, SNDRV_CTL_TLVD_DB_SCALE_ITEM(0, 0, 0),
-- 
2.9.3
