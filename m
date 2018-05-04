From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] ASoC: cs42xx8: Make the node name generic
Date: Fri,  4 May 2018 16:12:03 -0300
Message-ID: <1525461123-16686-4-git-send-email-festevam@gmail.com>
References: <1525461123-16686-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 14FDE26761D
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 21:12:19 +0200 (CEST)
Received: by mail-qt0-f194.google.com with SMTP id f13-v6so18970062qtp.10
 for <alsa-devel@alsa-project.org>; Fri, 04 May 2018 12:12:19 -0700 (PDT)
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
 Documentation/devicetree/bindings/sound/cs42xx8.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cs42xx8.txt b/Documentation/devicetree/bindings/sound/cs42xx8.txt
index f631fbc..8619a15 100644
--- a/Documentation/devicetree/bindings/sound/cs42xx8.txt
+++ b/Documentation/devicetree/bindings/sound/cs42xx8.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Example:
 
-codec: cs42888@48 {
+cs42888: codec@48 {
 	compatible = "cirrus,cs42888";
 	reg = <0x48>;
 	clocks = <&codec_mclk 0>;
-- 
2.7.4
