From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8753: Add control to allow swapping
	HiFi DAC channels" to the asoc tree
Date: Thu, 15 Dec 2016 12:20:59 +0000
Message-ID: <E1cHV1v-0000dI-84@debutante>
References: <1481626579-23642-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55DF92671EE
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:21:06 +0100 (CET)
In-Reply-To: <1481626579-23642-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8753: Add control to allow swapping HiFi DAC channels

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

>From af4b654f9fa87cf66a06f4841074b6738ed58606 Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work@mail.ru>
Date: Tue, 13 Dec 2016 13:56:19 +0300
Subject: [PATCH] ASoC: wm8753: Add control to allow swapping HiFi DAC channels

This patch adds a control to allow swapping HiFi DAC Left/Right channels.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8753.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 9bdf5447f6f6..d05d76e79c70 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -280,6 +280,7 @@ static const DECLARE_TLV_DB_SCALE(voice_mix_tlv, -1200, 300, 0);
 static const DECLARE_TLV_DB_SCALE(pga_tlv, -1725, 75, 0);
 
 static const struct snd_kcontrol_new wm8753_snd_controls[] = {
+SOC_SINGLE("Hi-Fi DAC Left/Right channel Swap", WM8753_HIFI, 5, 1, 0),
 SOC_DOUBLE_R_TLV("PCM Volume", WM8753_LDAC, WM8753_RDAC, 0, 255, 0, dac_tlv),
 
 SOC_DOUBLE_R_TLV("ADC Capture Volume", WM8753_LADC, WM8753_RADC, 0, 255, 0,
@@ -1087,7 +1088,7 @@ static int wm8753_i2s_set_dai_fmt(struct snd_soc_codec *codec,
 {
 	u16 ioctl, hifi;
 
-	hifi = snd_soc_read(codec, WM8753_HIFI) & 0x011f;
+	hifi = snd_soc_read(codec, WM8753_HIFI) & 0x013f;
 	ioctl = snd_soc_read(codec, WM8753_IOCTL) & 0x00ae;
 
 	/* set master/slave audio interface */
-- 
2.11.0
