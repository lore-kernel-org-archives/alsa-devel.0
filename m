From: <MR.Swami.Reddy@ti.com>
Subject: [PATCH] ASoC:isabelle:Fix warning message
Date: Tue, 5 Jun 2012 20:11:21 +0530
Message-ID: <1338907281-22442-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B2342442F
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 16:35:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
Cc: vishwas.a.deshpande@ti.com, MR Swami Reddy <MR.Swami.Reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

From: MR Swami Reddy <MR.Swami.Reddy@ti.com>

Patch to fix the below warning message:
sound/soc/codecs/isabelle.c:1126: warning: 'isabelle_regmap' is used uninitialized in this function

Signed-off-by: Vishwas A Deshpande <vishwas.a.deshpande@ti.com>
Signed-off-by: M R Swami Reddy <MR.Swami.Reddy@ti.com>
---
 sound/soc/codecs/isabelle.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index bcc77ef..a2efe1a 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1126,8 +1126,6 @@ static int __devinit isabelle_i2c_probe(struct i2c_client *i2c,
 	struct regmap *isabelle_regmap;
 	int ret = 0;
 
-	i2c_set_clientdata(i2c, isabelle_regmap);
-
 	isabelle_regmap = devm_regmap_init_i2c(i2c, &isabelle_regmap_config);
 	if (IS_ERR(isabelle_regmap)) {
 		ret = PTR_ERR(isabelle_regmap);
