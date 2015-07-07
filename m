From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/3] mfd: wm5110: Add register patch for rev
	E and above
Date: Tue,  7 Jul 2015 10:23:12 +0100
Message-ID: <1436260993-8814-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1436260993-8814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AAF72617DE
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 11:39:10 +0200 (CEST)
In-Reply-To: <1436260993-8814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add a register patch for rev E and above that configures the location of
some write sequences to assist with the headphone enables.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Added a comment with the write sequence

Thanks,
Charles

 drivers/mfd/wm5110-tables.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 62a4aa1..b70f76b 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -249,6 +249,15 @@ static const struct reg_default wm5110_revd_patch[] = {
 	{ 0x80, 0x0 },
 };
 
+static const struct reg_default wm5110_reve_patch[] = {
+	{ 0x80, 0x3 },
+	{ 0x80, 0x3 },
+	{ 0x4b, 0x138 }, /* Add extra headphone write sequence locations */
+	{ 0x4c, 0x13d },
+	{ 0x80, 0x0 },
+	{ 0x80, 0x0 },
+};
+
 /* We use a function so we can use ARRAY_SIZE() */
 int wm5110_patch(struct arizona *arizona)
 {
@@ -266,7 +275,9 @@ int wm5110_patch(struct arizona *arizona)
 					     wm5110_revd_patch,
 					     ARRAY_SIZE(wm5110_revd_patch));
 	default:
-		return 0;
+		return regmap_register_patch(arizona->regmap,
+					     wm5110_reve_patch,
+					     ARRAY_SIZE(wm5110_reve_patch));
 	}
 }
 EXPORT_SYMBOL_GPL(wm5110_patch);
-- 
1.7.2.5
