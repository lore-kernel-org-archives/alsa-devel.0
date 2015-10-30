From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix typo in sizeof" to
	the asoc tree
Date: Fri, 30 Oct 2015 12:02:51 +0900
Message-ID: <E1Zrzxr-0002jq-J5@finisterre>
References: <1446156281-31024-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7368818853047021339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50DCA265D6F
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 04:03:02 +0100 (CET)
In-Reply-To: <1446156281-31024-1-git-send-email-vincent.stehle@laposte.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, trivial@kernel.orgMark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============7368818853047021339==
Content-Type: text/plain

The patch

   ASoC: Intel: Skylake: fix typo in sizeof

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

>From 8552d9581f986426c0c15742d5f5757c82190d57 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Date: Thu, 29 Oct 2015 23:04:41 +0100
Subject: [PATCH] ASoC: Intel: Skylake: fix typo in sizeof
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The size of the pointer to a data structure to send is erroneously
passed to sst_ipc_tx_message_wait() as its tx_bytes argument. It should
be given the size of the pointed skl_ipc_dxstate_info structure instead.

Coincidentally, both the pointer and the structure have the same size of
8 bytes on a 64 bit machine, which "masks" the issue. Compiling for 32
bit reveals the issue more clearly.

Fix the typo for correctness, and to make the code robust to future
evolutions of the skl_ipc_dxstate_info structure size.

This fixes the following coccicheck error:

  sound/soc/intel/skylake/skl-sst-ipc.c:641:8-14: ERROR: application of sizeof to pointer

Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: trivial@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 3345ea0..95679c0 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -650,7 +650,7 @@ int skl_ipc_set_dx(struct sst_generic_ipc *ipc, u8 instance_id,
 	dev_dbg(ipc->dev, "In %s primary =%x ext=%x\n", __func__,
 			 header.primary, header.extension);
 	ret = sst_ipc_tx_message_wait(ipc, *ipc_header,
-				dx, sizeof(dx), NULL, 0);
+				dx, sizeof(*dx), NULL, 0);
 	if (ret < 0) {
 		dev_err(ipc->dev, "ipc: set dx failed, err %d\n", ret);
 		return ret;
-- 
2.6.1


--===============7368818853047021339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7368818853047021339==--
