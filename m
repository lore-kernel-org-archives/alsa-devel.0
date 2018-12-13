From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl-sai: Fix typo in "transmitter"
Date: Thu, 13 Dec 2018 08:36:38 -0200
Message-ID: <1544697398-10653-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-f68.google.com (mail-yw1-f68.google.com
 [209.85.161.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D5F5A267B81
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 11:36:42 +0100 (CET)
Received: by mail-yw1-f68.google.com with SMTP id h193so612388ywc.4
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 02:36:42 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix the spelling of "transmitter".

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index dd9e597..2e726b9 100644
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
2.7.4
