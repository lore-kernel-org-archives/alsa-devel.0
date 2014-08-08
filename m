From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm512x: Correct Digital Playback
	control names
Date: Fri,  8 Aug 2014 16:05:52 +0100
Message-ID: <1407510352-26125-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 192E3265056
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 17:06:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The source type should come before the direction specifier according to
ControlNames.txt.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm512x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 163ec3855fd4..0c8aefab404c 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -259,13 +259,13 @@ static const struct soc_enum pcm512x_veds =
 			pcm512x_ramp_step_text);
 
 static const struct snd_kcontrol_new pcm512x_controls[] = {
-SOC_DOUBLE_R_TLV("Playback Digital Volume", PCM512x_DIGITAL_VOLUME_2,
+SOC_DOUBLE_R_TLV("Digital Playback Volume", PCM512x_DIGITAL_VOLUME_2,
 		 PCM512x_DIGITAL_VOLUME_3, 0, 255, 1, digital_tlv),
 SOC_DOUBLE_TLV("Playback Volume", PCM512x_ANALOG_GAIN_CTRL,
 	       PCM512x_LAGN_SHIFT, PCM512x_RAGN_SHIFT, 1, 1, analog_tlv),
 SOC_DOUBLE_TLV("Playback Boost Volume", PCM512x_ANALOG_GAIN_BOOST,
 	       PCM512x_AGBL_SHIFT, PCM512x_AGBR_SHIFT, 1, 0, boost_tlv),
-SOC_DOUBLE("Playback Digital Switch", PCM512x_MUTE, PCM512x_RQML_SHIFT,
+SOC_DOUBLE("Digital Playback Switch", PCM512x_MUTE, PCM512x_RQML_SHIFT,
 	   PCM512x_RQMR_SHIFT, 1, 1),
 
 SOC_SINGLE("Deemphasis Switch", PCM512x_DSP, PCM512x_DEMP_SHIFT, 1, 1),
-- 
2.0.1
