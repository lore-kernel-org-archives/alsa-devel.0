From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 3/6] ASoC: da7219: Update REFERENCES reg
 default, in-line with HW
Date: Tue, 22 Dec 2015 18:27:53 +0000
Message-ID: <5233faeef4073f33e2826866eae35e8c9502c35f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 4576A265A15
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 19:27:54 +0100 (CET)
In-Reply-To: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

In current AB silicon, BIAS_EN field is enabled by default in the
REFERENCES register, so the regmap default value should reflect
this.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 253d8e7..3502c13 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1788,7 +1788,7 @@ static struct reg_default da7219_reg_defaults[] = {
 	{ DA7219_DIG_ROUTING_DAC, 0x32 },
 	{ DA7219_DAI_OFFSET_LOWER, 0x00 },
 	{ DA7219_DAI_OFFSET_UPPER, 0x00 },
-	{ DA7219_REFERENCES, 0x00 },
+	{ DA7219_REFERENCES, 0x08 },
 	{ DA7219_MIXIN_L_SELECT, 0x00 },
 	{ DA7219_MIXIN_L_GAIN, 0x03 },
 	{ DA7219_ADC_L_GAIN, 0x6F },
-- 
1.9.3
