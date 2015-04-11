From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: davinci-evm: Use card DAPM context to
	access widgets
Date: Sat, 11 Apr 2015 13:11:28 +0200
Message-ID: <1428750688-12171-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EB312608AB
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 13:11:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/davinci/davinci-evm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 8c2b9be..731fb0d 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -117,7 +117,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_codec *codec = rtd->codec;
 	struct device_node *np = card->dev->of_node;
 	int ret;
 
@@ -136,9 +135,9 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* not connected */
-	snd_soc_dapm_nc_pin(&codec->dapm, "MONO_LOUT");
-	snd_soc_dapm_nc_pin(&codec->dapm, "HPLCOM");
-	snd_soc_dapm_nc_pin(&codec->dapm, "HPRCOM");
+	snd_soc_dapm_nc_pin(&card->dapm, "MONO_LOUT");
+	snd_soc_dapm_nc_pin(&card->dapm, "HPLCOM");
+	snd_soc_dapm_nc_pin(&card->dapm, "HPRCOM");
 
 	return 0;
 }
-- 
1.8.0
