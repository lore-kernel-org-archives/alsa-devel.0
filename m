From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: remove usage of obsoleted
	TLV-related macro" to the asoc tree
Date: Wed, 28 Sep 2016 11:27:25 -0700
Message-ID: <E1bpJZl-0003oR-0J@finisterre>
References: <1475022561-5968-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CE68266991
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 20:27:39 +0200 (CEST)
In-Reply-To: <1475022561-5968-3-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: remove usage of obsoleted TLV-related macro

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

>From 51a576400ea46fec0df1672b373de91b00aa4a30 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Wed, 28 Sep 2016 09:29:20 +0900
Subject: [PATCH] ASoC: rt5616: remove usage of obsoleted TLV-related macro

TLV_DB_RANGE_HEAD macro was obsoleted by commit bf1d1c9b6179 ("ALSA: tlv:
add DECLARE_TLV_DB_RANGE()").

This commit removes usage of the macro, with the obsoleting macro renamed
to SNDRV_CTL_TLVD_DECLARE_DB_RANGE().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5616.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 98ae326c62fa..e6433254c720 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -294,8 +294,7 @@ static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
-static unsigned int bst_tlv[] = {
-	TLV_DB_RANGE_HEAD(7),
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(bst_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(2400, 0, 0),
@@ -303,7 +302,7 @@ static unsigned int bst_tlv[] = {
 	6, 6, TLV_DB_SCALE_ITEM(4400, 0, 0),
 	7, 7, TLV_DB_SCALE_ITEM(5000, 0, 0),
 	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
-};
+);
 
 static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 	/* Headphone Output Volume */
-- 
2.9.3
