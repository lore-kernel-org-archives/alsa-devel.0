From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ASoC: cs35l32: prevent unexpected parse result
	of device tree
Date: Tue, 15 Mar 2016 21:06:14 +0900
Message-ID: <1458043574-6078-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1458043574-6078-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id BF3D42614A0
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 13:06:23 +0100 (CET)
In-Reply-To: <1458043574-6078-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brian.austin@cirrus.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When device tree blob has no node properties requested by callers,
of_property_read_u32() returns minus value, then given argument is
not changed.

In current code of cs35l32 codec, the function is used with no condition
statement for evaluation of the return value. Thus, the value of 'val'
argument can be evaluated in following switch statement without
initialization or assignment.

This causes a bug that the property retrieved by previous function calls
can be evaluated in later switch statements when some properties are
missing.

This commit fixes the bug. Unfortunately, these switch statements include
cases with zero value. I initialize the argument with maximum number for
argument type so that it apparently matches default cases and generates
debug messages when missing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/cs35l32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 44c30fe..e464107 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -274,6 +274,7 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 	if (of_property_read_u32(np, "cirrus,sdout-share", &val) >= 0)
 		pdata->sdout_share = val;
 
+	val = UINT_MAX;
 	of_property_read_u32(np, "cirrus,boost-manager", &val);
 	switch (val) {
 	case CS35L32_BOOST_MGR_AUTO:
@@ -288,6 +289,7 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 		pdata->boost_mng = CS35L32_BOOST_MGR_BYPASS;
 	}
 
+	val = UINT_MAX;
 	of_property_read_u32(np, "cirrus,sdout-datacfg", &val);
 	switch (val) {
 	case CS35L32_DATA_CFG_LR_VP:
@@ -302,6 +304,7 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 		pdata->sdout_datacfg = CS35L32_DATA_CFG_LR;
 	}
 
+	val = UINT_MAX;
 	of_property_read_u32(np, "cirrus,battery-threshold", &val);
 	switch (val) {
 	case CS35L32_BATT_THRESH_3_1V:
@@ -316,6 +319,7 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 		pdata->batt_thresh = CS35L32_BATT_THRESH_3_3V;
 	}
 
+	val = UINT_MAX;
 	of_property_read_u32(np, "cirrus,battery-recovery", &val);
 	switch (val) {
 	case CS35L32_BATT_RECOV_3_1V:
-- 
2.7.0
