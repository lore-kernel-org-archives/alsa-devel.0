From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Trivial formatting fix in soc-core.c
Date: Mon,  1 Aug 2011 13:53:11 +0900
Message-ID: <1312174391-10355-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 44B5C243EB
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 08:04:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Utterly trivial but it annoys me.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 83ad8ca..e2ce248 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -105,7 +105,7 @@ static int format_register_str(struct snd_soc_codec *codec,
 	if (wordsize + regsize + 2 + 1 != len)
 		return -EINVAL;
 
-	ret = snd_soc_read(codec , reg);
+	ret = snd_soc_read(codec, reg);
 	if (ret < 0) {
 		memset(regbuf, 'X', regsize);
 		regbuf[regsize] = '\0';
-- 
1.7.5.4
