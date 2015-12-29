From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Exit startup early if no runtime
Date: Tue, 29 Dec 2015 09:49:19 +0000
Message-ID: <1451382559-27852-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B11ED265512
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 10:49:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

commit 9b8ef9f6b3fc ("ASoC: dapm: Add startup & shutdown for dai_links")

Added support for calling startup on CODEC to CODEC links, however this
is called with a NULL runtime pointer. There isn't really a sensible way
to pass a valid runtime pointer to a CODEC to CODEC link at the moment,
so we need to make the startup function safe for NULL runtimes.

This patch returns from the Arizona startup function early if there is no
runtime, this is perfectly safe as all the startup function does is set
the PCM constraints for user-space which arn't relevant to a CODEC to
CODEC link anyway.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index fb8f188..33143fe 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1494,6 +1494,9 @@ static int arizona_startup(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hw_constraint_list *constraint;
 	unsigned int base_rate;
 
+	if (!substream->runtime)
+		return 0;
+
 	switch (dai_priv->clk) {
 	case ARIZONA_CLK_SYSCLK:
 		base_rate = priv->sysclk;
-- 
2.1.4
