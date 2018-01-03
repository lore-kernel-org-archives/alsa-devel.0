From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: skl: Fix kernel warning due to zero NHTL entry" to the asoc tree
Date: Wed, 03 Jan 2018 15:42:54 +0000
Message-ID: <E1eWlBu-0000PU-5k@debutante>
References: <20180103153846.6106-1-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180103153846.6106-1-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: skl: Fix kernel warning due to zero NHTL entry

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

>From 20a1ea2222e7cbf96e9bf8579362e971491e6aea Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 3 Jan 2018 16:38:46 +0100
Subject: [PATCH] ASoC: skl: Fix kernel warning due to zero NHTL entry

I got the following kernel warning when loading snd-soc-skl module on
Dell Latitude 7270 laptop:
 memremap attempted on mixed range 0x0000000000000000 size: 0x0
 WARNING: CPU: 0 PID: 484 at kernel/memremap.c:98 memremap+0x8a/0x180
 Call Trace:
  skl_nhlt_init+0x82/0xf0 [snd_soc_skl]
  skl_probe+0x2ee/0x7c0 [snd_soc_skl]
  ....

It seems that the machine doesn't support the SKL DSP gives the empty
NHLT entry, and it triggers the warning.  For avoiding it, let do the
zero check before calling memremap().

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index d14c50a60289..1ce414d86d8a 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -43,7 +43,8 @@ struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 	obj = acpi_evaluate_dsm(handle, &osc_guid, 1, 1, NULL);
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-		nhlt_table = (struct nhlt_acpi_table *)
+		if (nhlt_ptr->length)
+			nhlt_table = (struct nhlt_acpi_table *)
 				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				MEMREMAP_WB);
 		ACPI_FREE(obj);
-- 
2.15.1
