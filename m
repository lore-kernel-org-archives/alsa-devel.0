From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix allocated block list usage
	when adding blocks.
Date: Fri,  2 May 2014 16:56:29 +0100
Message-ID: <1399046194-5544-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 88AB2261A34
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 17:56:52 +0200 (CEST)
In-Reply-To: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Make sure we add the allocated blocks to the modules list of blocks.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-firmware.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index fb5d084..4d50d2f 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -202,6 +202,9 @@ static int block_alloc_contiguous(struct sst_module *module,
 		size -= block->size;
 	}
 
+	list_for_each_entry(block, &tmp, list)
+		list_add(&block->module_list, &module->block_list);
+
 	list_splice(&tmp, &dsp->used_block_list);
 	return 0;
 }
-- 
1.9.1
