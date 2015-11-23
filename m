From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix memory leak" to the
	asoc tree
Date: Mon, 23 Nov 2015 11:41:00 +0000
Message-ID: <E1a0pUS-0005Rg-Nh@debutante>
References: <1448276928-9081-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58740265326
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 12:41:11 +0100 (CET)
In-Reply-To: <1448276928-9081-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip@vectorindia.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix memory leak

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

>From 87b5ed8ecb9fe05a696e1c0b53c7a49ea66432c1 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 23 Nov 2015 16:38:48 +0530
Subject: [PATCH] ASoC: Intel: Skylake: fix memory leak

We have requested the firmware but missed releasing it.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a7854c8fc523..ffea427aeca8 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1240,6 +1240,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 	 */
 	ret = snd_soc_tplg_component_load(&platform->component,
 					&skl_tplg_ops, fw, 0);
+	release_firmware(fw);
 	if (ret < 0) {
 		dev_err(bus->dev, "tplg component load failed%d\n", ret);
 		return -EINVAL;
-- 
2.6.2
