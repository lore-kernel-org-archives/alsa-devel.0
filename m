From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 12/17] ASoC: rt5640: add internal clock source
	support
Date: Fri, 12 Aug 2016 16:27:55 -0500
Message-ID: <1471037280-17433-13-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D59266D87
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:49 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Adding missing definitions and flags to select internal
clock source as system clock, needed for jack detection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5640.c | 3 +++
 sound/soc/codecs/rt5640.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index fbe3af1..3cc1135 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1870,6 +1870,9 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 	case RT5640_SCLK_S_PLL1:
 		reg_val |= RT5640_SCLK_SRC_PLL1;
 		break;
+	case RT5640_SCLK_S_RCCLK:
+		reg_val |= RT5640_SCLK_SRC_RCCLK;
+		break;
 	default:
 		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 58b664b..90c8871 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -984,6 +984,7 @@
 #define RT5640_SCLK_SRC_SFT			14
 #define RT5640_SCLK_SRC_MCLK			(0x0 << 14)
 #define RT5640_SCLK_SRC_PLL1			(0x1 << 14)
+#define RT5640_SCLK_SRC_RCCLK			(0x2 << 14)
 #define RT5640_PLL1_SRC_MASK			(0x3 << 12)
 #define RT5640_PLL1_SRC_SFT			12
 #define RT5640_PLL1_SRC_MCLK			(0x0 << 12)
-- 
2.5.0
