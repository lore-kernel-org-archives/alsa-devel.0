From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC AC97 static GPL symbol fix
Date: Thu, 10 May 2007 14:07:38 +0100
Message-ID: <1178802458.10518.76.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YvFLoSBcnuvegm96qipD"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 363D42438F
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:07:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-YvFLoSBcnuvegm96qipD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a bug whereby the GPL'ed symbol ac97_dai was being
declared as static.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-YvFLoSBcnuvegm96qipD
Content-Disposition: attachment; filename=ac97.patch
Content-Type: text/x-patch; name=ac97.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- a/soc/codecs/ac97.c	Mon May 07 09:29:32 2007 +0200
+++ b/soc/codecs/ac97.c	Tue May 08 10:16:09 2007 +0100
@@ -43,7 +43,7 @@ static int ac97_prepare(struct snd_pcm_s
 #define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
 		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
 
-static struct snd_soc_codec_dai ac97_dai = {
+struct snd_soc_codec_dai ac97_dai = {
 	.name = "AC97 HiFi",
 	.playback = {
 		.stream_name = "AC97 Playback",

--=-YvFLoSBcnuvegm96qipD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-YvFLoSBcnuvegm96qipD--
