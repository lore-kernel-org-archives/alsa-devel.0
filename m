From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ASOC: wm8991: fix wrong usage of
	DECLARE_TLV_DB_LINEAR()
Date: Tue, 27 Sep 2016 08:25:27 +0900
Message-ID: <1474932329-10640-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1474932329-10640-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 63420266928
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 01:25:34 +0200 (CEST)
In-Reply-To: <1474932329-10640-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

As long as reading datasheet of WM8991, this driver includes wrong usage
of DECLARE_TLV_DB_LINEAR().

In "Table 6 Input PGA Volume Range", volume is represented in 5 bits by
1.5 dB/step between -16.5/30.0 dB. Thus, 'in_pga_tlv' should be dB step
representation.

In "Table 34 LOMIX and ROMIX Volume Range", volume is represented in three
bits by -3 dB/step from 0 to -21 dB. Thus, 'out_mix_tlv' should be dB step
represenation.

In "Table 36 LOPGA, ROPGA, LOUT, ROUT and SPKVOL Volume Range", volume is
represented in 7 bits by 1 dB/step from -73 to 6 dB, including mute. Thus,
'out_pga_tlv' should be dB step representation.

In "Table 26 Digital Volume Range", volume is represented in 8 bits by
3/8 dB/step from -71.625 to 0 dB. Thus, 'out_dac_tlv' should be dB step
representation.

In "Table 16 ADC Digital Volume Range", volume is represented in 8 bits by
3/8 dB/step from -71.625 to 17.625 dB. Thus, 'in_adc_tlv' should be dB step
representation.

In "Table 23 Digital Sidetone Volume", volume is represented in 5 bits by
3 dB/step from -36 to 0 dB. Thus, 'out_sidetone_tlv' should be dB step
representation.

In "Table 12 Left Input Mixer Volume Control", volume is represented in
3 bits by 3 dB/step from -12 to 6 dB

Totally, current implementation includes misuse of TLV-related macro.

This commit replaces usage of DECLARE_TLV_DB_LINEAR() with proper macros,
to give proper information to applications in user land.

Fixes: 203db220718c ("ASoC: WM8991: Add initial WM8991 driver")
Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/wm8991.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index c9ee0ac..483b953 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -112,13 +112,25 @@ static bool wm8991_volatile(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
-static const DECLARE_TLV_DB_LINEAR(in_pga_tlv, -1650, 3000);
-static const DECLARE_TLV_DB_LINEAR(out_mix_tlv, 0, -2100);
-static const DECLARE_TLV_DB_LINEAR(out_pga_tlv, -7300, 600);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(in_pga_tlv, -1650, 150, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(out_mix_tlv, -2100, 300, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_pga_tlv,
+	0x00, 0x2f, SNDRV_CTL_TLVD_DB_SCALE_ITEM(SNDRV_CTL_TLVD_DB_GAIN_MUTE, 0, 1),
+	0x30, 0x7f, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-7300, 100, 0),
+);
 static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600, 0);
-static const DECLARE_TLV_DB_LINEAR(out_dac_tlv, -7163, 0);
-static const DECLARE_TLV_DB_LINEAR(in_adc_tlv, -7163, 1763);
-static const DECLARE_TLV_DB_LINEAR(out_sidetone_tlv, -3600, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_dac_tlv,
+	0x00, 0xbf, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-71625, 375, 1),
+	0xc0, 0xff, SNDRV_CTL_TLVD_DB_SCALE_ITEM(0, 0, 0),
+);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(in_adc_tlv,
+	0x00, 0xef, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-71625, 375, 1),
+	0xf0, 0xff, SNDRV_CTL_TLVD_DB_SCALE_ITEM(17625, 0, 0),
+);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_sidetone_tlv,
+	0x00, 0x0c, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-3600, 300, 0),
+	0x0d, 0x0f, SNDRV_CTL_TLVD_DB_SCALE_ITEM(0, 0, 0),
+);
 
 static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
@@ -398,7 +410,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 }
 
 /* INMIX dB values */
-static const DECLARE_TLV_DB_LINEAR(in_mix_tlv, -1200, 600);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(in_mix_tlv, -1200, 300, 1);
 
 /* Left In PGA Connections */
 static const struct snd_kcontrol_new wm8991_dapm_lin12_pga_controls[] = {
-- 
2.7.4
