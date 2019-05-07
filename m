From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Fix a compile warning with
	CONFIG_PCI=n" to the asoc tree
Date: Tue,  7 May 2019 03:28:51 +0100 (BST)
Message-ID: <20190507022851.9D800440017@finisterre.sirena.org.uk>
References: <20190506150224.1394-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7513827711148578589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5797FF89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 04:28:57 +0200 (CEST)
In-Reply-To: <20190506150224.1394-3-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

--===============7513827711148578589==
Content-Type: text/plain

The patch

   ASoC: SOF: Fix a compile warning with CONFIG_PCI=n

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

>From c41d384c39f17ffb5326531da2374a1ab5859403 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 6 May 2019 17:02:23 +0200
Subject: [PATCH] ASoC: SOF: Fix a compile warning with CONFIG_PCI=n
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A trivial fix for the randconfig build error:
  sound/soc/sof/ops.c:20:6: warning: ‘ret’ is used uninitialized in this function [-Wuninitialized]

Fixes: d1d95fcb63e3 ("ASoC: SOF: Add DSP HW abstraction operations")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ops.c b/sound/soc/sof/ops.c
index 80f907740b82..7a27c3b719e7 100644
--- a/sound/soc/sof/ops.c
+++ b/sound/soc/sof/ops.c
@@ -17,7 +17,7 @@ bool snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	unsigned int old, new;
-	u32 ret;
+	u32 ret = 0;
 
 	pci_read_config_dword(pci, offset, &ret);
 	old = ret;
-- 
2.20.1


--===============7513827711148578589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7513827711148578589==--
