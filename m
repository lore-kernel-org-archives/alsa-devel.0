From: Peter Seiderer <ps.report@gmx.net>
Subject: [RFC v1] tlv320aic32x4: delay i2c access by 1 ms after hardware reset
Date: Sun, 10 Feb 2019 16:45:19 +0100
Message-ID: <20190210154519.2506-1-ps.report@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, b-ak <anur.bhargav@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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
---
Note: This came up after the electronic departement took a deeper look at
the i2c-bus/vcc/reset pins with a logic analyzer and the documentation
because of a vcc/reset timing problem (now fixed on custom board).
Not 100% sure if the 1 ms is needed (as restricted to ADC/DAC coefficent
and codec block power up).
---
 sound/soc/codecs/tlv320aic32x4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e1bfba62fc08..b3beb0ca87c3 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -972,6 +972,8 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 		gpio_set_value(aic32x4->rstn_gpio, 1);
 	}
 
+	mdelay(1);
+
 	snd_soc_component_write(component, AIC32X4_RESET, 0x01);
 
 	if (aic32x4->setup)
-- 
2.20.1
