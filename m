From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH 2/3] ASoC: max98357a: Use DAI input as a dapm
	widget
Date: Sun, 12 Jul 2015 08:14:20 -0700
Message-ID: <1436714061-18618-2-git-send-email-anatol.pomozov@gmail.com>
References: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B6042605E4
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 17:14:41 +0200 (CEST)
Received: by pdbep18 with SMTP id ep18so210618164pdb.1
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 08:14:40 -0700 (PDT)
In-Reply-To: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
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
It makes more sense to use DAI input that created automatically by DAPM
and route it to Speaker output.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/max98357a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index fa1b793..b9e1131 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -51,12 +51,11 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("SDMode", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("Speaker"),
 };
 
 static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
-	{"Speaker", NULL, "SDMode"},
+	{"Speaker", NULL, "HiFi Playback"},
 };
 
 static int max98357a_codec_probe(struct snd_soc_codec *codec)
-- 
2.4.5
