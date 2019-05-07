From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: Fix an uninitialized variable
	compile warning" to the asoc tree
Date: Tue,  7 May 2019 03:30:30 +0100 (BST)
Message-ID: <20190507023030.D5013440010@finisterre.sirena.org.uk>
References: <20190506150224.1394-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8353707999669851046=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C55AF8975C
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 04:30:45 +0200 (CEST)
In-Reply-To: <20190506150224.1394-4-tiwai@suse.de>
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

--===============8353707999669851046==
Content-Type: text/plain

The patch

   ASoC: rockchip: Fix an uninitialized variable compile warning

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

>From f153bf49ddf6169544b24ef5ea26fa3eb4996b95 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 6 May 2019 17:02:24 +0200
Subject: [PATCH] ASoC: rockchip: Fix an uninitialized variable compile warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Paper over a trivial case leading to an uninitialized variable compile
warning:
  sound/soc/rockchip/rockchip_pdm.c:179:3: warning: ‘clk_out’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Fixes: 624e8e00acaf ("ASoC: rockchip: pdm: fixup pdm fractional div")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 6c0f242db5ef..b9c1d8ad77c1 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -158,7 +158,7 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	struct rk_pdm_dev *pdm = to_info(dai);
 	unsigned int val = 0;
 	unsigned int clk_rate, clk_div, samplerate;
-	unsigned int clk_src, clk_out;
+	unsigned int clk_src, clk_out = 0;
 	unsigned long m, n;
 	bool change;
 	int ret;
-- 
2.20.1


--===============8353707999669851046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8353707999669851046==--
