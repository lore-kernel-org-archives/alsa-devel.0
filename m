From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xlnx: fix error handling in
	xlnx_formatter_pcm_probe" to the asoc tree
Date: Mon, 31 Dec 2018 19:42:20 +0000 (GMT)
Message-ID: <20181231194220.EB6EF440082@finisterre.ee.mobilebroadband>
References: <20181226211106.GA16692@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 40033267B1A
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2018 20:42:23 +0100 (CET)
In-Reply-To: <20181226211106.GA16692@embeddedor>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Takashi Iwai <tiwai@suse.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe

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

>From fbaa95f4397eef4448bf9dbc36b7d4e961b169a6 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 26 Dec 2018 15:11:06 -0600
Subject: [PATCH] ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe

Currently, if platform_get_irq_byname() fails, the returned error
turns into a huge value, once it is being store into a variable
of type unsigned int, hence never actually reporting any error
and causing unexpected behavior when using the values stored
in aud_drv_data->s2mm_irq and aud_drv_data->mm2s_irq.

Fix this by changing the type of variables s2mm_irq and mm2s_irq in
structure xlnx_pcm_drv_data from unsigned int to int.

Addresses-Coverity-ID: 1476096 ("Unsigned compared against 0")
Fixes: 796175a94a7f ("ASoC: xlnx: add pcm formatter platform driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index f7235f7664d7..d2194da928e7 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -76,8 +76,8 @@ struct xlnx_pcm_drv_data {
 	void __iomem *mmio;
 	bool s2mm_presence;
 	bool mm2s_presence;
-	unsigned int s2mm_irq;
-	unsigned int mm2s_irq;
+	int s2mm_irq;
+	int mm2s_irq;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
 	struct clk *axi_clk;
-- 
2.20.1
