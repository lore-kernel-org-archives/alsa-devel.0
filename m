From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Intel: sst-firmware: missing curly
	braces (harmless)
Date: Fri, 21 Feb 2014 11:52:40 +0300
Message-ID: <20140221085240.GA13185@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 5464B26162E
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 09:52:45 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

There were some curly braces intended here, but the code actually
works the same either way so it's not a bug.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index b6f9b5ecb66a..51b56a473bc5 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -293,7 +293,7 @@ static int block_module_prepare(struct sst_module *module)
 	/* enable each block so that's it'e ready for module P/S data */
 	list_for_each_entry(block, &module->block_list, module_list) {
 
-		if (block->ops && block->ops->enable)
+		if (block->ops && block->ops->enable) {
 			ret = block->ops->enable(block);
 			if (ret < 0) {
 				dev_err(module->dsp->dev,
@@ -301,6 +301,7 @@ static int block_module_prepare(struct sst_module *module)
 					block->type, block->index);
 				goto err;
 			}
+		}
 	}
 	return ret;
 
