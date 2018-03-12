From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98090: Add #sound-dai-cells property
	documentation" to the asoc tree
Date: Mon, 12 Mar 2018 16:40:05 +0000 (GMT)
Message-ID: <20180312164005.37286440079@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ABAF266E63
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:40:08 +0100 (CET)
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
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98090: Add #sound-dai-cells property documentation

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

>From b50c32bd28e399cd4672a1e43645399e5bd1eb85 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 9 Mar 2018 18:48:52 +0100
Subject: [PATCH] ASoC: max98090: Add #sound-dai-cells property documentation

MAX98090 CODEC supports 1 input DAI, adding the #sound-dai-cells property
helps to reference the DAI in DT in a standard way.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/max98090.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/max98090.txt b/Documentation/devicetree/bindings/sound/max98090.txt
index 4e3be6682c98..7e1bbd5c27fd 100644
--- a/Documentation/devicetree/bindings/sound/max98090.txt
+++ b/Documentation/devicetree/bindings/sound/max98090.txt
@@ -16,6 +16,8 @@ Optional properties:
 
 - clock-names: Should be "mclk"
 
+- #sound-dai-cells : should be 0.
+
 - maxim,dmic-freq: Frequency at which to clock DMIC
 
 - maxim,micbias: Micbias voltage applies to the analog mic, valid voltages value are:
-- 
2.16.2
