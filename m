From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ts3a227e: fix a typo in documentation"
	to the asoc tree
Date: Thu,  4 Oct 2018 15:50:50 +0100 (BST)
Message-ID: <20181004145050.487FE1121C82@debutante.sirena.org.uk>
References: <20181004104301.48121-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 86452267737
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 16:50:51 +0200 (CEST)
In-Reply-To: <20181004104301.48121-1-tzungbi@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ts3a227e: fix a typo in documentation

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

>From 757b1aa00259a44f94bd120b9637720b9aaf36eb Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 4 Oct 2018 18:43:01 +0800
Subject: [PATCH] ASoC: ts3a227e: fix a typo in documentation

There is no "MACBIAS".  It should be "MICBIAS".

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ts3a227e.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.txt b/Documentation/devicetree/bindings/sound/ts3a227e.txt
index 3ed8359144d3..21ab45bc7e8f 100644
--- a/Documentation/devicetree/bindings/sound/ts3a227e.txt
+++ b/Documentation/devicetree/bindings/sound/ts3a227e.txt
@@ -14,7 +14,7 @@ Required properties:
 
 Optional properies:
  - ti,micbias:   Intended MICBIAS voltage (datasheet section 9.6.7).
-      Select 0/1/2/3/4/5/6/7 to specify MACBIAS voltage
+      Select 0/1/2/3/4/5/6/7 to specify MICBIAS voltage
       2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
       Default value is "1" (2.2V).
 
-- 
2.19.0.rc2
