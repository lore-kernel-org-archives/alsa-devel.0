From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] ASoC: Intel: cht_bsw_rt5672: fix card name
Date: Thu,  7 Sep 2017 20:12:56 -0500
Message-ID: <20170908011256.7706-4-pierre-louis.bossart@linux.intel.com>
References: <20170908011256.7706-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B0E9266F0A
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 03:13:23 +0200 (CEST)
In-Reply-To: <20170908011256.7706-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

For now reason the current card name is a ridiculous
'cherrytrailcraudio'. This isn't very useful or self-explanatory,
change to driver name cht-bsw-rt5672.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 6d077de..b13d6222 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -384,7 +384,7 @@ static int cht_resume_post(struct snd_soc_card *card)
 
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
-	.name = "cherrytrailcraudio",
+	.name = "cht-bsw-rt5672",
 	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
-- 
2.9.3
