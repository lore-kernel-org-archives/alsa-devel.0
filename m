From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Exit startup early if no runtime
Date: Wed, 23 Dec 2015 12:48:01 +0000
Message-ID: <1450874881-31458-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D6C7265888
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 13:48:03 +0100 (CET)
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
Cc: vinod.koul@intel.com, jeeja.kp@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

commit 9b8ef9f6b3fc ("ASoC: dapm: Add startup & shutdown for dai_links")

Added support for calling startup on CODEC to CODEC links, however this
is called with a NULL runtime pointer. There isn't really a sensible way
to pass a valid runtime pointer to a CODEC to CODEC link at the moment,
so we need to make the startup function safe for NULL runtimes.  This
patch returns from the Arizona startup function early if there is no
runtime.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

I will fixup the other users as well if everyone is happy
with this approach?

Thanks,
Charles

 sound/soc/codecs/arizona.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 38a73e3..88e2c74 100644
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
