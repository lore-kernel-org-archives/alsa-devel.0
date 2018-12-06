From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 3/3] ASoC: Intel: kbl_da7219_max98357a_rt5660:
	cleanup of some unused code
Date: Thu,  6 Dec 2018 22:52:07 +0800
Message-ID: <20181206145207.4477-3-hui.wang@canonical.com>
References: <20181206145207.4477-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CB59B267C88
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 15:52:37 +0100 (CET)
In-Reply-To: <20181206145207.4477-1-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

The code here deleted is not used in the driver.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 .../soc/intel/boards/kbl_da7219_max98357a_rt5660.c  | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a_rt5660.c b/sound/soc/intel/boards/kbl_da7219_max98357a_rt5660.c
index 6ac8163d4c35..cbfe66a9d7c7 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a_rt5660.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a_rt5660.c
@@ -502,19 +502,6 @@ static struct snd_soc_ops kabylake_dmic_ops = {
 	.startup = kabylake_dmic_startup,
 };
 
-static const unsigned int rates_16000[] = {
-	16000,
-};
-
-static const struct snd_pcm_hw_constraint_list constraints_16000 = {
-	.count = ARRAY_SIZE(rates_16000),
-	.list  = rates_16000,
-};
-
-static const unsigned int ch_mono[] = {
-	1,
-};
-
 /* kabylake digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link kabylake_dais[] = {
 	/* Front End DAI links */
-- 
2.17.1
