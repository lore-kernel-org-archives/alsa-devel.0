From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Log addresses as 8 digits in
	wm_adsp_buffer_populate" to the asoc tree
Date: Fri, 19 Oct 2018 13:33:40 +0100 (BST)
Message-ID: <20181019123340.369C51122548@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B4589267950
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:33:41 +0200 (CEST)
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
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Log addresses as 8 digits in wm_adsp_buffer_populate

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

>From e3a360b8cdede74d25807fc405e5d8bfb025692f Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Fri, 19 Oct 2018 13:25:16 +0100
Subject: [PATCH] ASoC: wm_adsp: Log addresses as 8 digits in
 wm_adsp_buffer_populate

Increase the address value width in the debug log from 4 digits to
8 digits to allow for DSP cores with larger memory address ranges.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7ae10c632614..a53dc174bbf0 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3345,7 +3345,7 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 		region->cumulative_size = offset;
 
 		adsp_dbg(buf->dsp,
-			 "region=%d type=%d base=%04x off=%04x size=%04x\n",
+			 "region=%d type=%d base=%08x off=%08x size=%08x\n",
 			 i, region->mem_type, region->base_addr,
 			 region->offset, region->cumulative_size);
 	}
-- 
2.19.0.rc2
