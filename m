From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Haswell: Remove set but not used
	variable 'stage_type'" to the asoc tree
Date: Fri, 19 Apr 2019 17:14:05 +0100 (BST)
Message-ID: <20190419161405.ED76A441D3C@finisterre.ee.mobilebroadband>
References: <20190418024848.39112-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FB76F896FB
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 18:14:12 +0200 (CEST)
In-Reply-To: <20190418024848.39112-1-yuehaibing@huawei.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, yang.jie@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Haswell: Remove set but not used variable 'stage_type'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 479879701758206a2cc75176119fcc9dacc40846 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 18 Apr 2019 10:48:48 +0800
Subject: [PATCH] ASoC: Intel: Haswell: Remove set but not used variable
 'stage_type'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 31fcdf12c67d..74acf9c65161 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -345,11 +345,6 @@ static inline u32 msg_get_stream_type(u32 msg)
 	return (msg & IPC_STR_TYPE_MASK) >>  IPC_STR_TYPE_SHIFT;
 }
 
-static inline u32 msg_get_stage_type(u32 msg)
-{
-	return (msg & IPC_STG_TYPE_MASK) >>  IPC_STG_TYPE_SHIFT;
-}
-
 static inline u32 msg_get_stream_id(u32 msg)
 {
 	return (msg & IPC_STR_ID_MASK) >>  IPC_STR_ID_SHIFT;
@@ -666,13 +661,12 @@ static int hsw_module_message(struct sst_hsw *hsw, u32 header)
 
 static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
 {
-	u32 stream_msg, stream_id, stage_type;
+	u32 stream_msg, stream_id;
 	struct sst_hsw_stream *stream;
 	int handled = 0;
 
 	stream_msg = msg_get_stream_type(header);
 	stream_id = msg_get_stream_id(header);
-	stage_type = msg_get_stage_type(header);
 
 	stream = get_stream_by_id(hsw, stream_id);
 	if (stream == NULL)
-- 
2.20.1
