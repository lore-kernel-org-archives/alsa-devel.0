From: Bas Vermeulen <Bas.Vermeulen@novero.com>
Subject: [ASoC] 88pm860x - Allow independent use of I2S capture
	and playback
Date: Mon, 19 Sep 2011 13:35:57 +0200
Message-ID: <4E77291D.10107@novero.com>
References: <4E735811.2060002@novero.com> <20110917133206.GB3798@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030808060208020409080204"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.novero.com (mx.novero.com [212.23.138.198])
	by alsa0.perex.cz (Postfix) with ESMTP id C5F3D249E9
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 13:58:23 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--------------030808060208020409080204
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/17/2011 03:32 PM, Mark Brown wrote:
> On Fri, Sep 16, 2011 at 04:07:13PM +0200, Bas Vermeulen wrote:
>> Note that in order to be able to use playback and capture independently
>> on the I2S interface (within reason, it is not possible to use a
>> different rate for instance), I had to add a SUPPLY control to the dapm
>> widgets that turns on the I2S clock when needed.
> Can you send a patch for this please?

Attached is a patch to turn the I2S clock on for both of I2S capture and 
playback instead of just playback.

Regards,

Bas Vermeulen

--------------030808060208020409080204
Content-Type: text/x-patch;
	name="0001-ASoC-88pm860x-codec-Allow-independent-use-of-both-I2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-ASoC-88pm860x-codec-Allow-independent-use-of-both-I2.pa";
	filename*1="tch"

>From a02c4f024daeae6f0708467bc1adbe20bc7458bb Mon Sep 17 00:00:00 2001
From: Bas Vermeulen <bas.vermeulen@novero.com>
Date: Mon, 19 Sep 2011 12:57:09 +0200
Subject: [PATCH 1/2] [ASoC] 88pm860x-codec - Allow independent use of both I2S playback and capture

Introduce a I2S CLK supply so playback and capture can operate independently.

Signed-off-by: Bas Vermeulen <bas.vermeulen@novero.com>
---
 sound/soc/codecs/88pm860x-codec.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 1924157..0198dbb 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -772,11 +772,12 @@ static const struct snd_soc_dapm_widget pm860x_dapm_widgets[] = {
 
 
 	SND_SOC_DAPM_AIF_IN("I2S DIN", "I2S Playback", 0,
-			    PM860X_DAC_EN_2, 0, 0),
+			    SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("I2S DIN1", "I2S Playback", 0,
-			    PM860X_DAC_EN_2, 0, 0),
+			    SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("I2S DOUT", "I2S Capture", 0,
 			     PM860X_I2S_IFACE_3, 5, 1),
+	SND_SOC_DAPM_SUPPLY("I2S CLK", PM860X_DAC_EN_2, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MUX("I2S Mic Mux", SND_SOC_NOPM, 0, 0, &i2s_mic_mux),
 	SND_SOC_DAPM_MUX("ADC Left Mux", SND_SOC_NOPM, 0, 0, &adcl_mux),
 	SND_SOC_DAPM_MUX("ADC Right Mux", SND_SOC_NOPM, 0, 0, &adcr_mux),
@@ -868,6 +869,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Left ADC", NULL, "Left ADC MOD"},
 	{"Right ADC", NULL, "Right ADC MOD"},
 
+	/* I2S Clock */
+	{"I2S DIN", NULL, "I2S CLK"},
+	{"I2S DIN1", NULL, "I2S CLK"},
+	{"I2S DOUT", NULL, "I2S CLK"},
+
 	/* PCM/AIF1 Inputs */
 	{"PCM SDO", NULL, "ADC Left Mux"},
 	{"PCM SDO", NULL, "ADCR EC Mux"},
-- 
1.7.0.4


--------------030808060208020409080204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030808060208020409080204--
