From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: sta529: Staticise non-exported codec
	driver struct
Date: Wed,  1 Aug 2012 19:29:11 +0100
Message-ID: <1343845751-19675-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CAF8265F03
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 20:29:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sta529.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 0c225cd..9e31448 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -358,7 +358,7 @@ static int sta529_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct snd_soc_codec_driver sta529_codec_driver = {
+static const struct snd_soc_codec_driver sta529_codec_driver = {
 	.probe = sta529_probe,
 	.remove = sta529_remove,
 	.set_bias_level = sta529_set_bias_level,
-- 
1.7.10.4
