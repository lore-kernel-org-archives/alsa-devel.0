From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa-ssp: Added blank line after declarations" to the
 asoc tree
Date: Tue, 07 Mar 2017 14:33:51 +0100
Message-ID: <E1clFFP-0005gZ-No@finisterre>
References: <1488058430-15393-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488058430-15393-1-git-send-email-codrut.cristian.grosu@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, haojian.zhuang@gmail.com, perex@perex.cz, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, robert.jarzmik@free.fr, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa-ssp: Added blank line after declarations

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

>From 1dbe692380de6eebdd3702b820a4bee6b931a2e5 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 23:33:50 +0200
Subject: [PATCH] ASoC: pxa-ssp: Added blank line after declarations

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3cad990dad2c..e9f6df38b152 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -354,6 +354,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 		if (ssp->type == PXA3xx_SSP) {
 			u32 val;
 			u64 tmp = 19968;
+
 			tmp *= 1000000;
 			do_div(tmp, freq_out);
 			val = tmp;
-- 
2.11.0
