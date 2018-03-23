From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] ASoC: AMD: acpd7219_clks_ops can be static
Date: Fri, 23 Mar 2018 23:45:41 +0800
Message-ID: <20180323154541.GA1131@xian>
References: <1521605103-13574-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B842266AE4
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 16:46:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1521605103-13574-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


Fixes: 446f0d1d7a90 ("ASoC: AMD: Enable/Disable auxiliary clock via common clock framework")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 acp-da7219-max98357a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index baea370..389598e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -309,7 +309,7 @@ static int acpd7219_clks_is_enabled(struct clk_hw *hw)
 	return !(reg_val & OSCCLKENB);
 }
 
-const struct clk_ops acpd7219_clks_ops = {
+static const struct clk_ops acpd7219_clks_ops = {
 	.prepare = acpd7219_clks_prepare,
 	.unprepare = acpd7219_clks_unprepare,
 	.is_enabled = acpd7219_clks_is_enabled,
