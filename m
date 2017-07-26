From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: add MONOVOL Playback Volume
	control" to the asoc tree
Date: Wed, 26 Jul 2017 15:17:45 +0100
Message-ID: <E1daN8D-0003lz-TB@debutante>
References: <1500894712-32034-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E760267519
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:17:58 +0200 (CEST)
In-Reply-To: <1500894712-32034-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: add MONOVOL Playback Volume control

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

>From b833786b69c14fe98846c38d36d8f6e5e92ccdd8 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 24 Jul 2017 19:11:52 +0800
Subject: [PATCH] ASoC: rt5665: add MONOVOL Playback Volume control

MONOVOL Playback Volume is a playback volume control on "MONOVOL MIX".

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 7e64b25f8585..54ace3b98ec3 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1402,6 +1402,9 @@ static const struct snd_kcontrol_new rt5665_snd_controls[] = {
 		RT5665_L_VOL_SFT, 15, 1, snd_soc_get_volsw,
 		rt5665_mono_vol_put, mono_vol_tlv),
 
+	SOC_SINGLE_TLV("MONOVOL Playback Volume", RT5665_MONO_OUT,
+		RT5665_L_VOL_SFT, 39, 1, out_vol_tlv),
+
 	/* Output Volume */
 	SOC_DOUBLE_TLV("OUT Playback Volume", RT5665_LOUT, RT5665_L_VOL_SFT,
 		RT5665_R_VOL_SFT, 39, 1, out_vol_tlv),
-- 
2.13.2
