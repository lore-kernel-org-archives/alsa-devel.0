From: Markus Pargmann <mpa@pengutronix.de>
Subject: [RFC] ASoC: pcm: Trigger all commands on error
Date: Fri,  4 Oct 2013 12:53:17 +0200
Message-ID: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 984FA26109C
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2013 12:53:42 +0200 (CEST)
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
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

If a start command is triggered and an error occures in the first called
function, e.g. DMA, all other functions are not executed and the error
value is returned immediately.

In case of a start command, the calling function will call undo_start,
calling this trigger function with the stop command. It will call stop
for each function. But only the first function was started previously.
The other functions may fail in the assumption that a stop command
always comes after a start command.

As the API does not specify the behaviour of trigger functionpointers, I
think this should be fixed in the function calling the trigger
functionpointers.

This patch changes the behaviour. The trigger function calls all
functionpointers independent of their returncodes. The first error-code
is returned.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/soc-pcm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 330c9a6..23fc25b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -616,26 +616,28 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
+	int ret = 0;
+	int err = 0;
 
 	if (codec_dai->driver->ops->trigger) {
 		ret = codec_dai->driver->ops->trigger(substream, cmd, codec_dai);
-		if (ret < 0)
-			return ret;
+		if (!err && ret)
+			err = ret;
 	}
 
 	if (platform->driver->ops && platform->driver->ops->trigger) {
 		ret = platform->driver->ops->trigger(substream, cmd);
-		if (ret < 0)
-			return ret;
+		if (!err && ret)
+			err = ret;
 	}
 
 	if (cpu_dai->driver->ops->trigger) {
 		ret = cpu_dai->driver->ops->trigger(substream, cmd, cpu_dai);
-		if (ret < 0)
-			return ret;
+		if (!err && ret)
+			err = ret;
 	}
-	return 0;
+
+	return err;
 }
 
 static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
-- 
1.8.4.rc3
