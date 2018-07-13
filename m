From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: doc: replace codec to component" to the
	asoc tree
Date: Fri, 13 Jul 2018 16:10:20 +0100 (BST)
Message-ID: <20180713151020.715CD440083@finisterre.ee.mobilebroadband>
References: <87woxx3q5g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AAA5F267736
 for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2018 00:44:24 +0200 (CEST)
In-Reply-To: <87woxx3q5g.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: doc: replace codec to component

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

>From a3ac7727f3a226b0569431de62a4e9bb4c770b2b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 02:14:22 +0000
Subject: [PATCH] ASoC: doc: replace codec to component

Now we can replace Codec to Component. Let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/soc/codec.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/soc/codec.rst b/Documentation/sound/soc/codec.rst
index f87612b94812..58f625fe3d39 100644
--- a/Documentation/sound/soc/codec.rst
+++ b/Documentation/sound/soc/codec.rst
@@ -179,12 +179,12 @@ i.e.
 
   static int wm8974_mute(struct snd_soc_dai *dai, int mute)
   {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8974_DAC) & 0xffbf;
+	struct snd_soc_component *component = dai->component;
+	u16 mute_reg = snd_soc_component_read32(component, WM8974_DAC) & 0xffbf;
 
 	if (mute)
-		snd_soc_write(codec, WM8974_DAC, mute_reg | 0x40);
+		snd_soc_component_write(component, WM8974_DAC, mute_reg | 0x40);
 	else
-		snd_soc_write(codec, WM8974_DAC, mute_reg);
+		snd_soc_component_write(component, WM8974_DAC, mute_reg);
 	return 0;
   }
-- 
2.18.0
