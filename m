From: Mark Brown <broonie@kernel.org>
Subject: Applied "tlv320aic32x4: delay i2c access by 1 ms after hardware reset" to the asoc tree
Date: Tue, 12 Feb 2019 14:21:49 +0000 (GMT)
Message-ID: <20190212142149.99C8C1128114@debutante.sirena.org.uk>
References: <20190211210630.16592-1-ps.report@gmx.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211210630.16592-1-ps.report@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Seiderer <ps.report@gmx.net>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, b-ak <anur.bhargav@gmail.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   tlv320aic32x4: delay i2c access by 1 ms after hardware reset

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 674f9abd094552dc297a2afd0cb72d30aec539a3 Mon Sep 17 00:00:00 2001
From: Peter Seiderer <ps.report@gmx.net>
Date: Mon, 11 Feb 2019 22:06:30 +0100
Subject: [PATCH] tlv320aic32x4: delay i2c access by 1 ms after hardware reset

As stated in 'TLV320AIC3254 Application Reference Guide' ([1]):

  3.2 Device Startup Lockout Times
    After the TLV320AIC3254 initializes through hardware reset at power-up
    or software reset, the internal registers initialize to default values.
    This initialization takes place within 1ms after pulling the RESET
    signal high. During this initialization phase, no register-read or
    register-write operation should be performed on ADC or DAC coefficient
    buffers. Also, no block within the codec should be powered up during
    the initialization phase.

[1] http://www.ti.com/lit/an/slaa408a/slaa408a.pdf

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e1bfba62fc08..96f1526cb258 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -970,6 +970,7 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ndelay(10);
 		gpio_set_value(aic32x4->rstn_gpio, 1);
+		mdelay(1);
 	}
 
 	snd_soc_component_write(component, AIC32X4_RESET, 0x01);
-- 
2.20.1
