From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: use kmemdup rather than
	duplicating its implementation" to the asoc tree
Date: Fri, 07 Aug 2015 13:30:09 +0100
Message-ID: <E1ZNgmn-00024p-F0@finisterre>
References: <1438934377-4922-31-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C04326046A
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 14:30:19 +0200 (CEST)
In-Reply-To: <1438934377-4922-31-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: use kmemdup rather than duplicating its implementation

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

>From b42e093e59c320e91b9c2de73bf3f0429fc45307 Mon Sep 17 00:00:00 2001
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Fri, 7 Aug 2015 09:59:36 +0200
Subject: [PATCH] ASoC: intel: use kmemdup rather than duplicating its
 implementation

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 5a27861..3dc7358 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -352,10 +352,9 @@ void sst_process_reply_mrfld(struct intel_sst_drv *sst_drv_ctx,
 	 * copy from mailbox
 	 **/
 	if (msg_high.part.large) {
-		data = kzalloc(msg_low, GFP_KERNEL);
+		data = kmemdup((void *)msg->mailbox_data, msg_low, GFP_KERNEL);
 		if (!data)
 			return;
-		memcpy(data, (void *) msg->mailbox_data, msg_low);
 		/* Copy command id so that we can use to put sst to reset */
 		dsp_hdr = (struct ipc_dsp_hdr *)data;
 		cmd_id = dsp_hdr->cmd_id;
-- 
2.5.0
