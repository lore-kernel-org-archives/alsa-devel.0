From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV shift
	values for ADC, PCM, and Analog kcontrols
Date: Wed, 19 Mar 2014 10:40:02 -0500
Message-ID: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heelrod (unknown [141.131.2.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7324B2650DD
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 16:40:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: thomas.petazzoni@free-electrons.com, Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

The shift values for the ADC,PCM, and Analog kcontrols were wrong causing wrong values for the SOC_DOUBLE_R_SX_TLV macros
Fixed the TLV for aout_tlv to show -102dB correctly

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l51.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 3eab460..65fc37c 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -106,9 +106,8 @@ static int cs42l51_set_chan_mix(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(adc_pcm_tlv, -5150, 50, 0);
 static const DECLARE_TLV_DB_SCALE(tone_tlv, -1050, 150, 0);
-/* This is a lie. after -102 db, it stays at -102 */
-/* maybe a range would be better */
-static const DECLARE_TLV_DB_SCALE(aout_tlv, -11550, 50, 0);
+
+static const DECLARE_TLV_DB_SCALE(aout_tlv, -10200, 50, 0);
 
 static const DECLARE_TLV_DB_SCALE(boost_tlv, 1600, 1600, 0);
 static const char *chan_mix[] = {
@@ -123,7 +122,7 @@ static const struct soc_enum cs42l51_chan_mix =
 static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 	SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
 			CS42L51_PCMA_VOL, CS42L51_PCMB_VOL,
-			6, 0x19, 0x7F, adc_pcm_tlv),
+			0, 0x19, 0x7F, adc_pcm_tlv),
 	SOC_DOUBLE_R("PCM Playback Switch",
 			CS42L51_PCMA_VOL, CS42L51_PCMB_VOL, 7, 1, 1),
 	SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
@@ -131,7 +130,7 @@ static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 			0, 0x34, 0xE4, aout_tlv),
 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
 			CS42L51_ADCA_VOL, CS42L51_ADCB_VOL,
-			6, 0x19, 0x7F, adc_pcm_tlv),
+			0, 0x19, 0x7F, adc_pcm_tlv),
 	SOC_DOUBLE_R("ADC Mixer Switch",
 			CS42L51_ADCA_VOL, CS42L51_ADCB_VOL, 7, 1, 1),
 	SOC_SINGLE("Playback Deemphasis Switch", CS42L51_DAC_CTL, 3, 1, 0),
-- 
1.7.9.5
