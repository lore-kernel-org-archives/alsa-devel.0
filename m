From: Bas Vermeulen <Bas.Vermeulen@novero.com>
Subject: [ASoC] 88pm860x - Incorporate the marvell errata
 regarding Audio Power-up Delay.
Date: Mon, 19 Sep 2011 13:38:11 +0200
Message-ID: <4E7729A3.4070102@novero.com>
References: <4E735811.2060002@novero.com> <20110917133206.GB3798@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080107070107020807050104"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.novero.com (mx.novero.com [212.23.138.198])
	by alsa0.perex.cz (Postfix) with ESMTP id BC3C5249CA
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 14:00:34 +0200 (CEST)
In-Reply-To: <20110917133206.GB3798@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Bas Vermeulen (CentricTSolve/Bochum)" <ext-Bas.Vermeulen@novero.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--------------080107070107020807050104
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/17/2011 03:32 PM, Mark Brown wrote:
>> Note that in order to be able to use playback and capture independently
>> on the I2S interface (within reason, it is not possible to use a
>> different rate for instance), I had to add a SUPPLY control to the dapm
>> widgets that turns on the I2S clock when needed.
> Can you send a patch for this please?
This patch implements the audio power-up delay errata for the 88PM8607, 
meaning the codec will actually be reset.

Regards,

Bas Vermeulen

--------------080107070107020807050104
Content-Type: text/x-patch;
	name="0002-ASoC-88pm860x-codec-reset-the-codec-correctly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-ASoC-88pm860x-codec-reset-the-codec-correctly.patch"

>From 55d78799fc7e492f582bc7feb4cb3251e8ef895d Mon Sep 17 00:00:00 2001
From: Bas Vermeulen <bas.vermeulen@novero.com>
Date: Mon, 19 Sep 2011 13:09:10 +0200
Subject: [PATCH 2/2] [ASoC] 88pm860x-codec - reset the codec correctly

Reset the codec according to the Audio power-up delay errata for the 88PM8607.

Signed-off-by: Bas Vermeulen <bas.vermeulen@novero.com>
---
 sound/soc/codecs/88pm860x-codec.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 0198dbb..df7b4a0 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1179,6 +1179,9 @@ static int pm860x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable Audio PLL & Audio section */
+			data = AUDIO_PLL | AUDIO_SECTION_ON;
+			pm860x_reg_write(codec->control_data, REG_MISC2, data);
+			udelay(300);
 			data = AUDIO_PLL | AUDIO_SECTION_RESET
 				| AUDIO_SECTION_ON;
 			pm860x_reg_write(codec->control_data, REG_MISC2, data);
-- 
1.7.0.4


--------------080107070107020807050104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080107070107020807050104--
