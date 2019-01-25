From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/15] ASoC: Intel: bytcht_da7213: platform
	name fixup support
Date: Fri, 25 Jan 2019 14:35:01 -0600
Message-ID: <20190125203509.22994-8-pierre-louis.bossart@linux.intel.com>
References: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E56926680F
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 21:35:19 +0100 (CET)
In-Reply-To: <20190125203509.22994-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_da7213.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 2179dedb28ad..b8e884803777 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -225,6 +225,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
 	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
 	int ret_val = 0;
@@ -250,6 +251,13 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 		dailink[dai_index].codec_name = codec_name;
 	}
 
+	/* override plaform name, if required */
+	platform_name = mach->mach_params.platform;
+
+	ret_val = snd_soc_fixup_dai_links_platform_name(card, platform_name);
+	if (ret_val)
+		return ret_val;
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
 		dev_err(&pdev->dev,
-- 
2.17.1
