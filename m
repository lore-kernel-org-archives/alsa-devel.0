From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/3] ASoC: tas6424: Print full register name in
	error message
Date: Fri, 31 Aug 2018 10:14:06 -0500
Message-ID: <20180831151407.18864-2-afd@ti.com>
References: <20180831151407.18864-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by alsa0.perex.cz (Postfix) with ESMTP id B0E2026793E
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:14:11 +0200 (CEST)
In-Reply-To: <20180831151407.18864-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The current short version of the register name may be
ambiguous when another fault register detection is added.
Use the full name.

While here fix comment about clearing faults, the CLEAR_FAULT
register actually only clears sticky bits, which are only
warnings, fault bits can only cleared by resolving the fault.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tas6424.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 0d6145549a98..aac559fffc1a 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -408,7 +408,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT1, &reg);
 	if (ret < 0) {
-		dev_err(dev, "failed to read FAULT1 register: %d\n", ret);
+		dev_err(dev, "failed to read GLOB_FAULT1 register: %d\n", ret);
 		goto out;
 	}
 
@@ -453,7 +453,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 check_global_fault2_reg:
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT2, &reg);
 	if (ret < 0) {
-		dev_err(dev, "failed to read FAULT2 register: %d\n", ret);
+		dev_err(dev, "failed to read GLOB_FAULT2 register: %d\n", ret);
 		goto out;
 	}
 
@@ -530,7 +530,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	/* Store current warn value so we can detect any changes next time */
 	tas6424->last_warn = reg;
 
-	/* Clear any faults by toggling the CLEAR_FAULT control bit */
+	/* Clear any warnings by toggling the CLEAR_FAULT control bit */
 	ret = regmap_write_bits(tas6424->regmap, TAS6424_MISC_CTRL3,
 				TAS6424_CLEAR_FAULT, TAS6424_CLEAR_FAULT);
 	if (ret < 0)
-- 
2.18.0
