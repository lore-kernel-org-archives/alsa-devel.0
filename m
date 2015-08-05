From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8990: Don't use range container for
	TLV with one entry" to the asoc tree
Date: Wed, 05 Aug 2015 13:30:56 +0100
Message-ID: <E1ZMxqS-0005oU-Ha@finisterre>
References: <1438528810-23498-37-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5192265DF8
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:07 +0200 (CEST)
In-Reply-To: <1438528810-23498-37-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8990: Don't use range container for TLV with one entry

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

>From dfd0edda1fb3cd7a7cdde56467d718b1e49e32d5 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:20:04 +0200
Subject: [PATCH] ASoC: wm8990: Don't use range container for TLV with one
 entry

For TLVs with only a single entry it is not necessary to use a range
container. Use DECLARE_TLV_DB_SCALE() directly instead of a combination of
TLV_DB_RANGE_HEAD() and TLV_DB_SCALE_ITEM().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8990.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 1993fd2..2befdde 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -418,10 +418,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 }
 
 /* INMIX dB values */
-static const unsigned int in_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_SCALE_ITEM(-1200, 600, 0),
-};
+static const DECLARE_TLV_DB_SCALE(in_mix_tlv, -1200, 600, 0);
 
 /* Left In PGA Connections */
 static const struct snd_kcontrol_new wm8990_dapm_lin12_pga_controls[] = {
-- 
2.1.4
