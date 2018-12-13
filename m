From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-sai: Fix typo in "transmitter"" to
	the asoc tree
Date: Thu, 13 Dec 2018 12:08:49 +0000 (GMT)
Message-ID: <20181213120849.0E43A11254D1@debutante.sirena.org.uk>
References: <1544697398-10653-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AE4C267C38
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 13:08:49 +0100 (CET)
In-Reply-To: <1544697398-10653-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-sai: Fix typo in "transmitter"

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

>From f0b3f8418711d2e482bd57d6c0b5790947ca6863 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Dec 2018 08:36:38 -0200
Subject: [PATCH] ASoC: fsl-sai: Fix typo in "transmitter"

Fix the spelling of "transmitter".

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index dd9e59738e08..2e726b983845 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -35,13 +35,13 @@ Required properties:
 
   - fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
 			  that SAI will work in the synchronous mode (sync Tx
-			  with Rx) which means both the transimitter and the
+			  with Rx) which means both the transmitter and the
 			  receiver will send and receive data by following
 			  receiver's bit clocks and frame sync clocks.
 
   - fsl,sai-asynchronous: This is a boolean property. If present, indicating
 			  that SAI will work in the asynchronous mode, which
-			  means both transimitter and receiver will send and
+			  means both transmitter and receiver will send and
 			  receive data by following their own bit clocks and
 			  frame sync clocks separately.
 
@@ -58,8 +58,8 @@ Optional properties (for mx6ul):
 Note:
 - If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
   default synchronous mode (sync Rx with Tx) will be used, which means both
-  transimitter and receiver will send and receive data by following clocks
-  of transimitter.
+  transmitter and receiver will send and receive data by following clocks
+  of transmitter.
 - fsl,sai-asynchronous and fsl,sai-synchronous-rx are exclusive.
 
 Example:
-- 
2.19.0.rc2
