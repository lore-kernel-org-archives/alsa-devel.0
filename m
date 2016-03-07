From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: add missing mute control for
	HPVOL" to the asoc tree
Date: Mon, 07 Mar 2016 14:43:04 +0700
Message-ID: <E1acpom-00076D-9t@finisterre>
References: <1457323931-31819-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F43F26517C
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:43:08 +0100 (CET)
In-Reply-To: <1457323931-31819-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: add missing mute control for HPVOL

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

>From d7fcd13663fe43ad938fec1acd46ff196dddf914 Mon Sep 17 00:00:00 2001
From: John Lin <john.lin@realtek.com>
Date: Mon, 7 Mar 2016 12:12:11 +0800
Subject: [PATCH] ASoC: rt5616: add missing mute control for HPVOL

Add missing kcontrol for HPVOL mute control.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5616.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 3704d0716c04..f527b5b2817b 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -309,6 +309,8 @@ static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 	/* Headphone Output Volume */
 	SOC_DOUBLE("HP Playback Switch", RT5616_HP_VOL,
 		   RT5616_L_MUTE_SFT, RT5616_R_MUTE_SFT, 1, 1),
+	SOC_DOUBLE("HPVOL Playback Switch", RT5616_HP_VOL,
+		   RT5616_VOL_L_SFT, RT5616_VOL_R_SFT, 1, 1),
 	SOC_DOUBLE_TLV("HP Playback Volume", RT5616_HP_VOL,
 		       RT5616_L_VOL_SFT, RT5616_R_VOL_SFT, 39, 1, out_vol_tlv),
 	/* OUTPUT Control */
-- 
2.7.0
