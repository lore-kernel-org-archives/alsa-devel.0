From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: hsw: remove i386 build warning
	w/ size_t argument" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:27 +0100 (BST)
Message-ID: <20190815171427.927662742BC7@ypsilon.sirena.org.uk>
References: <20190812140305.17570-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com
 [209.85.208.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E054F80600
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 19:14:28 +0200 (CEST)
Received: by mail-ed1-f98.google.com with SMTP id p28so2709439edi.3
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 10:14:28 -0700 (PDT)
In-Reply-To: <20190812140305.17570-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Cezary Rojewski <cezary.rojewski@intel.com>, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: hsw: remove i386 build warning w/ size_t argument

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8da2d74c10fd71cc04e2585fe8bb3ced325f8e25 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 12 Aug 2019 09:03:05 -0500
Subject: [PATCH] ASoC: Intel: hsw: remove i386 build warning w/ size_t
 argument

Recent changes in the common IPC code introduced a build warning with
size_t fields, use the correct %zu format.

include/linux/dynamic_debug.h:82:16: warning: format '%lu' expects
argument of type 'long unsigned int', but argument 4 has type 'size_t'
[-Wformat=]

Fixes: abf31feea26c0 ('ASoC: Intel: Update request-reply IPC model')
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20190812140305.17570-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
