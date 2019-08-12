From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: hsw: remove i386 build warning w/
	size_t argument
Date: Mon, 12 Aug 2019 09:03:05 -0500
Message-ID: <20190812140305.17570-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5797F800F6
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 16:09:39 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

Recent changes in the common IPC code introduced a build warning with
size_t fields, use the correct %zu format.

include/linux/dynamic_debug.h:82:16: warning: format '%lu' expects
argument of type 'long unsigned int', but argument 4 has type 'size_t'
[-Wformat=]

Fixes: abf31feea26c0 ('ASoC: Intel: Update request-reply IPC model')
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 5c73b11375e3..0ff89ea96ccf 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2015,11 +2015,11 @@ int sst_hsw_module_set_param(struct sst_hsw *hsw,
 
 	if (payload_size <= SST_HSW_IPC_MAX_SHORT_PARAMETER_SIZE) {
 		/* short parameter, mailbox can contain data */
-		dev_dbg(dev, "transfer parameter size : %lu\n",
+		dev_dbg(dev, "transfer parameter size : %zu\n",
 			request.size);
 
 		request.size = ALIGN(payload_size, 4);
-		dev_dbg(dev, "transfer parameter aligned size : %lu\n",
+		dev_dbg(dev, "transfer parameter aligned size : %zu\n",
 			request.size);
 
 		parameter = kzalloc(request.size, GFP_KERNEL);
-- 
2.20.1
