From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH RESEND] Documentation: fsl,
	ssi.txt: Avoid cryptic acronyms
Date: Wed, 10 Sep 2014 16:46:03 -0300
Message-ID: <1410378363-7137-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 92D3B2655B1
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 21:46:37 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id la4so3022804vcb.7
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 12:46:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

It is much clearer to use the full terms here: left-justified/right-justified.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 3aa4a8f..ceca880 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -62,9 +62,9 @@ Optional properties:
                     "i2s-slave" - I2S mode, SSI is clock slave
                     "i2s-master" - I2S mode, SSI is clock master
                     "lj-slave" - left-justified mode, SSI is clock slave
-                    "lj-master" - l.j. mode, SSI is clock master
+                    "lj-master" - left-justified mode, SSI is clock master
                     "rj-slave" - right-justified mode, SSI is clock slave
-                    "rj-master" - r.j., SSI is clock master
+                    "rj-master" - right-justified mode, SSI is clock master
                     "ac97-slave" - AC97 mode, SSI is clock slave
                     "ac97-master" - AC97 mode, SSI is clock master
 
-- 
1.9.1
