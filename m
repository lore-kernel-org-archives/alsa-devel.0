From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/4] ASoC: simple-card-utils: accept NULL
 parameter on asoc_simple_card_xxx()
Date: Wed, 21 Nov 2018 02:09:16 +0000
Message-ID: <87tvkbp4v0.wl-kuninori.morimoto.gx@renesas.com>
References: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410108.outbound.protection.outlook.com [40.107.141.108])
 by alsa0.perex.cz (Postfix) with ESMTP id E9990267936
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 03:09:18 +0100 (CET)
In-Reply-To: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <63591ECD4526174FB3C10BCB2DC45FD9@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

If simple-card-utils accept NULL pointer on asoc_simple_card_xxx(),
each driver code will be more simple.
Let's accept NULL pointer.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-card-utils.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index dcac45dad..2fe7ea2 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -153,13 +153,17 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 
 int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 {
-	return clk_prepare_enable(dai->clk);
+	if (dai)
+		return clk_prepare_enable(dai->clk);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_clk_enable);
 
 void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
 {
-	clk_disable_unprepare(dai->clk);
+	if (dai)
+		clk_disable_unprepare(dai->clk);
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_clk_disable);
 
@@ -345,6 +349,9 @@ int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 {
 	int ret;
 
+	if (!simple_dai)
+		return 0;
+
 	if (simple_dai->sysclk) {
 		ret = snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk,
 					     simple_dai->clk_direction);
-- 
2.7.4
