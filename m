From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: db1200: Fix DAI link format for db1300
	and db1550
Date: Fri, 25 Sep 2015 11:07:04 +0200
Message-ID: <1443172024-19906-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-240.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 59FC9265AA7
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2015 11:07:12 +0200 (CEST)
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit b4508d0f95fa ("ASoC: db1200: Use static DAI format setup") switched
the db1200 driver over to using static DAI format setup instead of a
callback function. But the commit only added the dai_fmt field to one of
the three DAI links in the driver. This breaks audio on db1300 and db1550.

Add the two missing dai_fmt settings to fix the issue.

Fixes: b4508d0f95fa ("ASoC: db1200: Use static DAI format setup")
Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Tested-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/au1x/db1200.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 638ca0b..5c73061 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -129,6 +129,8 @@ static struct snd_soc_dai_link db1300_i2s_dai = {
 	.cpu_dai_name	= "au1xpsc_i2s.2",
 	.platform_name	= "au1xpsc-pcm.2",
 	.codec_name	= "wm8731.0-001b",
+	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
@@ -146,6 +148,8 @@ static struct snd_soc_dai_link db1550_i2s_dai = {
 	.cpu_dai_name	= "au1xpsc_i2s.3",
 	.platform_name	= "au1xpsc-pcm.3",
 	.codec_name	= "wm8731.0-001b",
+	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
-- 
2.1.4
