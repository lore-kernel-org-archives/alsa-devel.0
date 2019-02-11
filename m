From: Peter Seiderer <ps.report@gmx.net>
Subject: [RFC v2] tlv320aic32x4: delay i2c access by 1 ms after
	hardware reset
Date: Mon, 11 Feb 2019 22:06:30 +0100
Message-ID: <20190211210630.16592-1-ps.report@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E34442673F8
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 22:06:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, b-ak <anur.bhargav@gmail.com>, Mark Brown <broonie@kernel.org>
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
Changes v1 -> v2:
  - call mdelay only in case the reset gpio was toggled (suggested
    by Mark Brown)

Note: This came up after the electronic departement took a deeper look at
the i2c-bus/vcc/reset pins with a logic analyzer and the documentation
because of a vcc/reset timing problem (now fixed on custom board).
Not 100% sure if the 1 ms is needed (as restricted to ADC/DAC coefficent
and codec block power up).
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
