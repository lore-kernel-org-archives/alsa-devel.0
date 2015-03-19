From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: [PATCH 2/2] ASoC:pcm512x: Add 'Analogue' prefix to
	analogue volume controls
Date: Thu, 19 Mar 2015 12:08:30 +0000
Message-ID: <1426766910-27250-2-git-send-email-hm@hmbedded.co.uk>
References: <1426766910-27250-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout02.plus.net (avasout02.plus.net [212.159.14.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D78026046B
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 13:09:09 +0100 (CET)
In-Reply-To: <1426766910-27250-1-git-send-email-hm@hmbedded.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, gordon@iqaudio.com, Howard Mitchell <hm@hmbedded.co.uk>
List-Id: alsa-devel@alsa-project.org

This is to ensure that 'alsactl restore' does not apply default
initialisation as the chip reset defaults are preferred.

Signed-off-by: Howard Mitchell <hm@hmbedded.co.uk>
---
 sound/soc/codecs/pcm512x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 4b5f1fe..5301c4a 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -391,9 +391,9 @@ static const struct soc_enum pcm512x_veds =
 static const struct snd_kcontrol_new pcm512x_controls[] = {
 SOC_DOUBLE_R_TLV("Digital Playback Volume", PCM512x_DIGITAL_VOLUME_2,
 		 PCM512x_DIGITAL_VOLUME_3, 0, 255, 1, digital_tlv),
-SOC_DOUBLE_TLV("Playback Volume", PCM512x_ANALOG_GAIN_CTRL,
+SOC_DOUBLE_TLV("Analogue Playback Volume", PCM512x_ANALOG_GAIN_CTRL,
 	       PCM512x_LAGN_SHIFT, PCM512x_RAGN_SHIFT, 1, 1, analog_tlv),
-SOC_DOUBLE_TLV("Playback Boost Volume", PCM512x_ANALOG_GAIN_BOOST,
+SOC_DOUBLE_TLV("Analogue Playback Boost Volume", PCM512x_ANALOG_GAIN_BOOST,
 	       PCM512x_AGBL_SHIFT, PCM512x_AGBR_SHIFT, 1, 0, boost_tlv),
 SOC_DOUBLE("Digital Playback Switch", PCM512x_MUTE, PCM512x_RQML_SHIFT,
 	   PCM512x_RQMR_SHIFT, 1, 1),
-- 
1.7.9.5
