From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Revert duplicated code in SSM2602
	driver
Date: Mon, 15 Jun 2009 10:33:00 +0100
Message-ID: <1245058382-30813-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090615093223.GA30743@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9824B103801
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:33:03 +0200 (CEST)
In-Reply-To: <20090615093223.GA30743@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Blackfin submission was done as a patch against a different tree
and contained a duplicate hunk which will cause us to loose track of the
substream pointers when shutting down.  Remove one of the duplicated
hunks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ssm2602.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 1fc4c8e..c550750 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -375,10 +375,6 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct ssm2602_priv *ssm2602 = codec->private_data;
 
-	if (ssm2602->master_substream == substream)
-		ssm2602->master_substream = ssm2602->slave_substream;
-
-	ssm2602->slave_substream = NULL;
 	/* deactivate */
 	if (!codec->active)
 		ssm2602_write(codec, SSM2602_ACTIVE, 0);
-- 
1.6.3.1
