From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: Skylake: make function skl_clk_round_rate static
Date: Thu,  8 Feb 2018 14:35:30 +0000
Message-ID: <20180208143530.11450-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The function skl_clk_round_rate is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
sound/soc/intel/skylake/skl-ssp-clk.c:250:6: warning: symbol
'skl_clk_round_rate' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl-ssp-clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
index 7fbddf5e3b00..cda1b5fa7436 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -247,8 +247,8 @@ static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
 }
 
 /* Not supported by clk driver. Implemented to satisfy clk fw */
-long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *parent_rate)
 {
 	return rate;
 }
-- 
2.15.1
