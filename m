From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix block offset calculations.
Date: Fri,  2 May 2014 16:56:28 +0100
Message-ID: <1399046194-5544-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CFFB22619E7
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 17:56:50 +0200 (CEST)
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

Block offset calculations are done in the contiguous allocator so
are not required here.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-firmware.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index c4e7126..fb5d084 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -247,8 +247,7 @@ static int block_alloc(struct sst_module *module,
 		/* do we span > 1 blocks */
 		if (data->size > block->size) {
 			ret = block_alloc_contiguous(module, data,
-				block->offset + block->size,
-				data->size - block->size);
+				block->offset, data->size);
 			if (ret == 0)
 				return ret;
 		}
@@ -344,7 +343,7 @@ static int block_alloc_fixed(struct sst_module *module,
 
 			err = block_alloc_contiguous(module, data,
 				block->offset + block->size,
-				data->size - block->size + data->offset - block->offset);
+				data->size - block->size);
 			if (err < 0)
 				return -ENOMEM;
 
@@ -371,8 +370,7 @@ static int block_alloc_fixed(struct sst_module *module,
 		if (data->offset >= block->offset && data->offset < block_end) {
 
 			err = block_alloc_contiguous(module, data,
-				block->offset + block->size,
-				data->size - block->size);
+				block->offset, data->size);
 			if (err < 0)
 				return -ENOMEM;
 
-- 
1.9.1
