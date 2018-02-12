From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH asoc] ASoC: rt5659:
 rt5659_intel_hd_header_probe_setup() can be static
Date: Tue, 13 Feb 2018 01:16:06 +0800
Message-ID: <20180212171606.GA15960@lkp-wsm-ep1>
References: <201802130145.hD2DgN3c%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A82267463
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 18:16:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201802130145.hD2DgN3c%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


Fixes: 041e74b71491 ("ASoC: rt5659: Add the support of Intel HDA Header")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 rt5659.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index ef3a44d..b772194 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4038,7 +4038,7 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 	regmap_write(rt5659->regmap, RT5659_HP_CHARGE_PUMP_1, 0x0c16);
 }
 
-void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
+static void rt5659_intel_hd_header_probe_setup(struct rt5659_priv *rt5659)
 {
 	int value;
 
