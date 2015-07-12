From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH 2/3] ASoC: max98357a: Specify digital input as
	a dapm widget
Date: Sat, 11 Jul 2015 23:56:41 -0700
Message-ID: <1436684202-16461-2-git-send-email-anatol.pomozov@gmail.com>
References: <1436684202-16461-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 6477E260687
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 08:57:18 +0200 (CEST)
Received: by pactm7 with SMTP id tm7so190000188pac.2
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 23:57:17 -0700 (PDT)
In-Reply-To: <1436684202-16461-1-git-send-email-anatol.pomozov@gmail.com>
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
Cc: broonie@kernel.org, lars@metafoo.de, kwestfie@codeaurora.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Spec does not say anything about DAC called SDMode.
Create a dapm path that consists of path from I2S input to Speaker output.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/max98357a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 6d4246a..0d87d35 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -51,12 +51,12 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("SDMode", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIFRX", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("Speaker"),
 };
 
 static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
-	{"Speaker", NULL, "SDMode"},
+	{"Speaker", NULL, "AIFRX"},
 };
 
 static int max98357a_codec_probe(struct snd_soc_codec *codec)
-- 
2.4.5
