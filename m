From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: cs4270: use 'reset-gpios'
	rather than 'reset-gpio'" to the asoc tree
Date: Thu,  6 Dec 2018 20:26:00 +0000 (GMT)
Message-ID: <20181206202600.8A63A11252F7@debutante.sirena.org.uk>
References: <20181206122426.28194-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BA78267CCA
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 21:26:01 +0100 (CET)
In-Reply-To: <20181206122426.28194-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: cs4270: use 'reset-gpios' rather than 'reset-gpio'

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

>From eab8e354a8c7b4496cb68a6f5adc5ec3a1f59151 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Thu, 6 Dec 2018 13:24:25 +0100
Subject: [PATCH] ASoC: dt-bindings: cs4270: use 'reset-gpios' rather than
 'reset-gpio'

Bindings should use 'reset-gpios', not 'reset-gpio'. The driver needs to
switch to the gpiod consume API to handle this correctly.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/cs4270.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cs4270.txt b/Documentation/devicetree/bindings/sound/cs4270.txt
index 6b222f9b8ef5..c33770ec4c3c 100644
--- a/Documentation/devicetree/bindings/sound/cs4270.txt
+++ b/Documentation/devicetree/bindings/sound/cs4270.txt
@@ -10,8 +10,8 @@ Required properties:
 
 Optional properties:
 
-  - reset-gpio : a GPIO spec for the reset pin. If specified, it will be
-		 deasserted before communication to the codec starts.
+  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
+		  deasserted before communication to the codec starts.
 
 Example:
 
-- 
2.19.0.rc2
