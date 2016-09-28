From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: remove usage of obsoleted
	TLV-related macro" to the asoc tree
Date: Wed, 28 Sep 2016 11:27:23 -0700
Message-ID: <E1bpJZj-0003nY-NG@finisterre>
References: <1475022561-5968-4-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CF79267030
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 20:27:39 +0200 (CEST)
In-Reply-To: <1475022561-5968-4-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: remove usage of obsoleted TLV-related macro

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

>From b269cebf72d3591cd889a25f81ead43166a45fb9 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Wed, 28 Sep 2016 09:29:21 +0900
Subject: [PATCH] ASoC: wm8960: remove usage of obsoleted TLV-related macro

TLV_DB_RANGE_HEAD macro was obsoleted by commit bf1d1c9b6179 ("ALSA: tlv:
add DECLARE_TLV_DB_RANGE()").

This commit removes usage of the macro, with the obsoleting macro renamed
to SNDRV_CTL_TLVD_DECLARE_DB_RANGE().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d7f444f87460..3d8c75617d8d 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -226,11 +226,10 @@ static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -2100, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(lineinboost_tlv, -1500, 300, 1);
-static const unsigned int micboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(micboost_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 1300, 0),
 	2, 3, TLV_DB_SCALE_ITEM(2000, 900, 0),
-};
+);
 
 static const struct snd_kcontrol_new wm8960_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
-- 
2.9.3
