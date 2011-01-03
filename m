From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: regarding references taken on platform and codec
 driver modules
Date: Mon, 3 Jan 2011 23:26:34 +0530
Message-ID: <98769532B4BB14429434178695419EAE053BF51BC3@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
	<20110103155454.GE6783@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51B26@bgsmsx501.gar.corp.intel.com>
	<20110103163532.GB7370@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DBC91038CD
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 18:57:29 +0100 (CET)
In-Reply-To: <20110103163532.GB7370@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> driver are left at 3. I did a trace back as where all the references 
>> are taken and  where all they are released. I find that 4 references 
>> of codec driver and  platform driver are taken but only one of them is released.
>
>> How do I fix this problem?
>
>By understanding where the references should be taken and released then 
>fixing the code to do that.

When the dais are binded, the reference to codec and platform driver are taken
for every dai link but released only once. Instead, the below patch moves to
taking the reference to codec and platform driver when they are probed and
release it once. This allows the ASoC driver modules to be inserted and removed 
without issues.

Please provide your comments on the patch below that makes this change

From: Harsha Priya <priya.harsha@intel.com>
Date: Mon, 3 Jan 2011 22:36:05 +0530
Subject: [PATCH] Fix the reference to codec and platform driver to where they are probed

The soc-core take the platform and codec driver reference and does not free
them all. This cause the module unload to fail.

This patch fixes by the taking one reference to platform and codec module and 
free the same.This allows load/unload properly

Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: Vinod Koul<vinod.koul@intel.com>

	modified:   sound/soc/soc-core.c

---
 sound/soc/soc-core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c index 606281a..97f9d3e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1259,9 +1259,6 @@ find_codec:
 		if (!strcmp(codec->name, dai_link->codec_name)) {
 			rtd->codec = codec;
 
-			if (!try_module_get(codec->dev->driver->owner))
-				return -ENODEV;
-
 			/* CODEC found, so find CODEC DAI from registered DAIs from this CODEC*/
 			list_for_each_entry(codec_dai, &dai_list, list) {
 				if (codec->dev == codec_dai->dev && @@ -1287,10 +1284,6 @@ find_platform:
 	/* no, then find CPU DAI from registered DAIs*/
 	list_for_each_entry(platform, &platform_list, list) {
 		if (!strcmp(platform->name, dai_link->platform_name)) {
-
-			if (!try_module_get(platform->dev->driver->owner))
-				return -ENODEV;
-
 			rtd->platform = platform;
 			goto out;
 		}
@@ -1425,6 +1418,9 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	soc_init_codec_debugfs(codec);
 
 	/* mark codec as probed and add to card codec list */
+	if (!try_module_get(codec->dev->driver->owner))
+		return -ENODEV;
+
 	codec->probed = 1;
 	list_add(&codec->card_list, &card->codec_dev_list);
 	list_add(&codec->dapm.list, &card->dapm_list); @@ -1556,6 +1552,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 			}
 		}
 		/* mark platform as probed and add to card platform list */
+
+		if (!try_module_get(platform->dev->driver->owner))
+			return -ENODEV;
+
 		platform->probed = 1;
 		list_add(&platform->card_list, &card->platform_dev_list);
 	}
--
1.7.2.3
