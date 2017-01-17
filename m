From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mxs-saif: fix setting SAIF1 register"
	to the asoc tree
Date: Tue, 17 Jan 2017 18:45:00 +0000
Message-ID: <E1cTYke-0008Nt-OV@debutante>
References: <20170113204428.16703-2-joerg.krause@embedded.rocks>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5114746534498798372=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25AEC2665B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:22 +0100 (CET)
In-Reply-To: <20170113204428.16703-2-joerg.krause@embedded.rocks>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mans Rullgard <mans@mansr.com>, Victorien Vedrine <victorien.vedrine@ophrys.net>, =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

--===============5114746534498798372==
Content-Type: text/plain

The patch

   ASoC: mxs-saif: fix setting SAIF1 register

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

>From b25658ed7d24cd8b1f9a72148e80e216b6a0c17a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>
Date: Fri, 13 Jan 2017 21:44:28 +0100
Subject: [PATCH] ASoC: mxs-saif: fix setting SAIF1 register
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If SAIF0 is used in master and SAIF1 in slave mode setting the SAIF1
register in mxs_saif_set_dai_fmt() does not have any effect on the
interface as the clk gate needs to be cleared before the register can be
written.

Signed-off-by: Jörg Krause <joerg.krause@embedded.rocks>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mxs/mxs-saif.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index a002ab892772..9012a2036131 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -299,6 +299,16 @@ static int mxs_saif_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		return -EBUSY;
 	}
 
+	/* If SAIF1 is configured as slave, the clk gate needs to be cleared
+	 * before the register can be written.
+	 */
+	if (saif->id != saif->master_id) {
+		__raw_writel(BM_SAIF_CTRL_SFTRST,
+			saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+		__raw_writel(BM_SAIF_CTRL_CLKGATE,
+			saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+	}
+
 	scr0 = __raw_readl(saif->base + SAIF_CTRL);
 	scr0 = scr0 & ~BM_SAIF_CTRL_BITCLK_EDGE & ~BM_SAIF_CTRL_LRCLK_POLARITY \
 		& ~BM_SAIF_CTRL_JUSTIFY & ~BM_SAIF_CTRL_DELAY;
-- 
2.11.0


--===============5114746534498798372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5114746534498798372==--
