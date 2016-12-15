From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: remove unused 'msg_high'"
	to the asoc tree
Date: Thu, 15 Dec 2016 12:21:51 +0000
Message-ID: <E1cHV2l-0000vh-C2@debutante>
References: <1481218297-17568-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5108027999096305872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CF022671EE
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:21:57 +0100 (CET)
In-Reply-To: <1481218297-17568-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============5108027999096305872==
Content-Type: text/plain

The patch

   ASoC: Intel: sst: remove unused 'msg_high'

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ee9292e859bec2bd8b79b7d14bc352e9ea5d7257 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 8 Dec 2016 23:01:25 +0530
Subject: [PATCH] ASoC: Intel: sst: remove unused 'msg_high'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In process_fw_async_msg(), a variable 'msg_high' is initialized but
not used. So remove it.

sound/soc/intel/atom/sst/sst_ipc.c: In function ‘process_fw_async_msg’:
sound/soc/intel/atom/sst/sst_ipc.c:263:24: warning: variable ‘msg_high’ set but not used [-Wunused-but-set-variable]
  union ipc_header_high msg_high;

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 374bb61c596d..14c2d9d18180 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -260,10 +260,8 @@ static void process_fw_async_msg(struct intel_sst_drv *sst_drv_ctx,
 	u32 data_size, i;
 	void *data_offset;
 	struct stream_info *stream;
-	union ipc_header_high msg_high;
 	u32 msg_low, pipe_id;
 
-	msg_high = msg->mrfld_header.p.header_high;
 	msg_low = msg->mrfld_header.p.header_low_payload;
 	msg_id = ((struct ipc_dsp_hdr *)msg->mailbox_data)->cmd_id;
 	data_offset = (msg->mailbox_data + sizeof(struct ipc_dsp_hdr));
-- 
2.11.0


--===============5108027999096305872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5108027999096305872==--
