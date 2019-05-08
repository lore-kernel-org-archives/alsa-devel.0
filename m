From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Fix unused variable warnings" to
	the asoc tree
Date: Wed,  8 May 2019 10:34:42 +0100 (BST)
Message-ID: <20190508093442.5E0E444000C@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6460744888605321225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58869F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 11:34:51 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============6460744888605321225==
Content-Type: text/plain

The patch

   ASoC: SOF: Fix unused variable warnings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2a79e3d342e4b8883ff7fe2cf1b3e9192c26f61a Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 8 May 2019 10:50:37 +0200
Subject: [PATCH] ASoC: SOF: Fix unused variable warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recent fix for the build fix caused a couple of unused variable
compiler warnings when CONFIG_SND_SOC_SOF_NOCODEC isn't set:
  sound/soc/sof/core.c:263:6: warning: unused variable ‘ret’ [-Wunused-variable]
  sound/soc/sof/core.c:262:28: warning: unused variable ‘machine’ [-Wunused-variable]

Fix them by adding another ifdef.

Fixes: ce38a75089f7 ("ASoC: SOF: core: fix undefined nocodec reference")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 5ddbfa8f1a28..32105e0fabe8 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -259,8 +259,10 @@ int snd_sof_create_page_table(struct snd_sof_dev *sdev,
 static int sof_machine_check(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pdata *plat_data = sdev->pdata;
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
 	struct snd_soc_acpi_mach *machine;
 	int ret;
+#endif
 
 	if (plat_data->machine)
 		return 0;
-- 
2.20.1


--===============6460744888605321225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6460744888605321225==--
