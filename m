From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] ASoC: sgtl5000: Make the node name generic
Date: Fri,  4 May 2018 16:12:00 -0300
Message-ID: <1525461123-16686-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C1C12673A6
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 21:12:13 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id f1-v6so28764666qtj.6
 for <alsa-devel@alsa-project.org>; Fri, 04 May 2018 12:12:13 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the binding example.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9a36c7e..0f21445 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -39,7 +39,7 @@ VDDIO		1.8V		2.5V		3.3V
 
 Example:
 
-codec: sgtl5000@a {
+sgtl5000: codec@a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
 	#sound-dai-cells = <0>;
-- 
2.7.4
