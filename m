From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix mismerge of Speyside
	set_bias_level_post()
Date: Wed,  8 Jun 2011 16:12:16 +0100
Message-ID: <1307545936-17485-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 673BB244D6
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 17:12:19 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 2515dba..d6dee4d 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -301,6 +301,7 @@ static struct snd_soc_card speyside = {
 	.num_configs = ARRAY_SIZE(speyside_codec_conf),
 
 	.set_bias_level = speyside_set_bias_level,
+	.set_bias_level_post = speyside_set_bias_level_post,
 
 	.controls = controls,
 	.num_controls = ARRAY_SIZE(controls),
-- 
1.7.5.3
