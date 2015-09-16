From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4642: exchange macro name to avoid
	redefinition" to the asoc tree
Date: Wed, 16 Sep 2015 21:01:44 +0100
Message-ID: <E1ZcItk-0007rR-AG@finisterre>
References: <87613c4day.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF9B264F22
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:01:51 +0200 (CEST)
In-Reply-To: <87613c4day.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4642: exchange macro name to avoid redefinition

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

>From 544637bf3f4ddc1971740026e1cf58d8516b53fa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Sep 2015 02:42:42 +0000
Subject: [PATCH] ASoC: ak4642: exchange macro name to avoid redefinition

71a0138ab("ASoC: ak4642: enable to use MCKO as fixed rate output
pin on DT") added new FS() macro, but x86 already has it in
arch/x86/include/uapi/asm/ptrace-abi.h
This patch exchange FS() to FSs() to avoid redefinition warning

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4642.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index b5c4981..cda27c2 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -130,8 +130,8 @@
 #define I2S		(3 << 0)
 
 /* MD_CTL2 */
-#define FS(val)		(((val & 0x7) << 0) | ((val & 0x8) << 2))
-#define PS(val)		((val & 0x3) << 6)
+#define FSs(val)	(((val & 0x7) << 0) | ((val & 0x8) << 2))
+#define PSs(val)	((val & 0x3) << 6)
 
 /* MD_CTL3 */
 #define BST1		(1 << 3)
@@ -458,7 +458,8 @@ static int ak4642_set_mcko(struct snd_soc_codec *codec,
 	for (ps = 0; ps < ARRAY_SIZE(ps_list); ps++) {
 		for (fs = 0; fs < ARRAY_SIZE(fs_list); fs++) {
 			if (frequency == ps_list[ps] * fs_list[fs]) {
-				snd_soc_write(codec, MD_CTL2, PS(ps) | FS(fs));
+				snd_soc_write(codec, MD_CTL2,
+					      PSs(ps) | FSs(fs));
 				return 0;
 			}
 		}
-- 
2.5.0
