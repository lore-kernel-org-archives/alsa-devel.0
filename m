From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] ASoC: wm8960: Make the node name generic
Date: Fri,  4 May 2018 16:12:02 -0300
Message-ID: <1525461123-16686-3-git-send-email-festevam@gmail.com>
References: <1525461123-16686-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9826A267412
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 21:12:17 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id m16-v6so28716787qtg.13
 for <alsa-devel@alsa-project.org>; Fri, 04 May 2018 12:12:17 -0700 (PDT)
In-Reply-To: <1525461123-16686-1-git-send-email-festevam@gmail.com>
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
 Documentation/devicetree/bindings/sound/wm8960.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8960.txt b/Documentation/devicetree/bindings/sound/wm8960.txt
index 2deb8a3..6d29ac3 100644
--- a/Documentation/devicetree/bindings/sound/wm8960.txt
+++ b/Documentation/devicetree/bindings/sound/wm8960.txt
@@ -23,7 +23,7 @@ Optional properties:
 
 Example:
 
-codec: wm8960@1a {
+wm8960: codec@1a {
 	compatible = "wlf,wm8960";
 	reg = <0x1a>;
 
-- 
2.7.4
