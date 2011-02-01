From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: Amstrad Delta: fix NULL pointer
	dereference
Date: Tue, 1 Feb 2011 18:40:55 +0100
Message-ID: <201102011840.55512.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 67BA3245E3
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 18:42:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

It looks like the .card member of the snd_soc_pcm_runtime structure 
pointed to by the snd_soc_dai_link.init() argument is no longer 
initialized before the function being called. As the Amstrad Delta sound 
card driver was making use of it for locating its snd_soc_card 
structure, this resulted in actual or potential NULL pointer 
dereferences.

Since the structure in question is local to the driver, its address can 
be referred directly instead of trying to derive it from the function 
argument. Fix it.

Created and tested against linux-2.6.38-rc2

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Please consider queuing this patch for the current rc cycle.

 sound/soc/omap/ams-delta.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- git/sound/soc/omap/ams-delta.c.orig	2011-01-31 19:49:29.000000000 +0100
+++ git/sound/soc/omap/ams-delta.c	2011-02-01 17:54:22.000000000 +0100
@@ -492,12 +492,14 @@ static void ams_delta_shutdown(struct sn
  * Card initialization
  */
 
+static struct snd_soc_card ams_delta_audio_card;
+
 static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_card *card = &ams_delta_audio_card;
 	int ret;
 	/* Codec is ready, now add/activate board specific controls */
