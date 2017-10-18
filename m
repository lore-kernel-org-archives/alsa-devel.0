From: Mark Brown <broonie@kernel.org>
Subject: Applied "drm/amd/amdgpu: Added asic_type as ACP DMA
	driver platform data" to the asoc tree
Date: Wed, 18 Oct 2017 01:09:29 +0100
Message-ID: <E1e4bvN-00045A-2E@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B9E8266AE1
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 02:11:39 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   drm/amd/amdgpu: Added asic_type as ACP DMA driver platform data

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

>From d4ba4ef2e894c10f2c16497fb0659e5ded502f97 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 9 Oct 2017 16:35:12 -0400
Subject: [PATCH] drm/amd/amdgpu: Added asic_type as ACP DMA driver platform
 data

asic_type information is passed to ACP DMA Driver as platform data.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index a52795d9b458..ebca22302ebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -371,6 +371,8 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_cell[0].name = "acp_audio_dma";
 	adev->acp.acp_cell[0].num_resources = 4;
 	adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
+	adev->acp.acp_cell[0].platform_data = &adev->asic_type;
+	adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
 
 	adev->acp.acp_cell[1].name = "designware-i2s";
 	adev->acp.acp_cell[1].num_resources = 1;
-- 
2.14.1
