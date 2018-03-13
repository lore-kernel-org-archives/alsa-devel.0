From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] ASoC: AMD: da7219_dai_clk can be static
Date: Tue, 13 Mar 2018 19:03:53 +0800
Message-ID: <20180313110353.GA117792@lkp-ib04>
References: <1520845883-24062-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 310B2266F68
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 12:04:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1520845883-24062-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, akshu.agrawal@amd.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


Fixes: 7d03b3824d27 ("ASoC: AMD: Enable da7219 master clock using common clock framework")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 acp-da7219-max98357a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 1441be3..d6e7420 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -42,7 +42,7 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
