From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH v2 2/2] ASoC: es8316: fix inverted L/R of headphone mixer volume
Date: Tue, 27 Aug 2019 00:39:00 +0900
Message-ID: <20190826153900.25969-2-katsuhiro@katsuster.net>
References: <20190826153900.25969-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826153900.25969-1-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>
List-Id: alsa-devel@alsa-project.org

This patch fixes inverted Left-Right channel of headphone mixer
volume by wrong shift_left, shift_right values.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index f97d9c5210f0..e0da24611800 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -94,7 +94,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 	SOC_DOUBLE_TLV("Headphone Playback Volume", ES8316_CPHP_ICAL_VOL,
 		       4, 0, 3, 1, hpout_vol_tlv),
 	SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
-		       0, 4, 11, 0, hpmixer_gain_tlv),
+		       4, 0, 11, 0, hpmixer_gain_tlv),
 
 	SOC_ENUM("Playback Polarity", dacpol),
 	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL,
-- 
2.23.0.rc1
