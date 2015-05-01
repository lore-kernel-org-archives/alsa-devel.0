From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v3 1/5] ASoC: Correct typo in
	SOC_VALUE_ENUM_SINGLE macro
Date: Fri,  1 May 2015 12:37:23 +0100
Message-ID: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2503826148F
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 13:45:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

xnitmes is clearly intended to be xnitems, but all other macros just
refer to this as xitems, so change it to that.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v2:
 - Use snd_soc_enum_item_to_val to get zero value from mux to account for
   non-value enums
 - Improve handling in snd_soc_dapm_put_enum_double of the situation
   where the register and widget views of the control values don't match

Thanks,
Charles

 include/sound/soc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a73d855..45cfd69 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -190,8 +190,8 @@
 #define SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xitems, xtexts, xvalues) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.mask = xmask, .items = xitems, .texts = xtexts, .values = xvalues}
-#define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xnitmes, xtexts, xvalues) \
-	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xnitmes, xtexts, xvalues)
+#define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xitems, xtexts, xvalues) \
+	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xitems, xtexts, xvalues)
 #define SOC_ENUM_SINGLE_VIRT(xitems, xtexts) \
 	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, xitems, xtexts)
 #define SOC_ENUM(xname, xenum) \
-- 
1.7.2.5
