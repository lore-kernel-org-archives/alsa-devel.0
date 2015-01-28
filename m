From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH v2 3/7] ASoC: pcm512x: Change register default
	to match actual content after reset
Date: Wed, 28 Jan 2015 15:16:08 +0100
Message-ID: <1422454572-7847-4-git-send-email-peda@lysator.liu.se>
References: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 25BF1261B11
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 15:17:05 +0100 (CET)
In-Reply-To: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/pcm512x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 874723c36d65..4c65eb9ab59b 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -78,7 +78,7 @@ static const struct reg_default pcm512x_reg_defaults[] = {
 	{ PCM512x_DIGITAL_VOLUME_2,  0x30 },
 	{ PCM512x_DIGITAL_VOLUME_3,  0x30 },
 	{ PCM512x_DIGITAL_MUTE_1,    0x22 },
-	{ PCM512x_DIGITAL_MUTE_2,    0x00 },
+	{ PCM512x_DIGITAL_MUTE_2,    0x02 },
 	{ PCM512x_DIGITAL_MUTE_3,    0x07 },
 	{ PCM512x_OUTPUT_AMPLITUDE,  0x00 },
 	{ PCM512x_ANALOG_GAIN_CTRL,  0x00 },
-- 
1.7.10.4
