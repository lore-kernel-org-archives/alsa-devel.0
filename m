From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt: Fix typo" to the asoc tree
Date: Mon, 23 May 2016 18:50:26 +0100
Message-ID: <E1b4tzm-0006cL-OV@debutante>
References: <20160521114421.1953-1-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 498EB261585
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 19:50:33 +0200 (CEST)
In-Reply-To: <20160521114421.1953-1-andrea.gelmini@gelma.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, andrea.gelmini@gelma.net
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt: Fix typo

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

>From c317fe585ca8244ac1768c7c8d29f14697995f8d Mon Sep 17 00:00:00 2001
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 13:44:21 +0200
Subject: [PATCH] ASoC: dt: Fix typo

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/alsa/soc/machine.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index 74056dba52be..6bf2d2063b52 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -3,7 +3,7 @@ ASoC Machine Driver
 
 The ASoC machine (or board) driver is the code that glues together all the
 component drivers (e.g. codecs, platforms and DAIs). It also describes the
-relationships between each componnent which include audio paths, GPIOs,
+relationships between each component which include audio paths, GPIOs,
 interrupts, clocking, jacks and voltage regulators.
 
 The machine driver can contain codec and platform specific code. It registers
-- 
2.8.1
