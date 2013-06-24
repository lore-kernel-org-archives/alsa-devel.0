From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/5] ASoC: codecs: tas5086: fix documentation
Date: Mon, 24 Jun 2013 16:25:28 +0200
Message-ID: <1372083932-4318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 18E3E26508C
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:25:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The property 'ti,charge-period' must be given in nanoseconds, not
microseconds.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/sound/ti,tas5086.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas5086.txt b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
index 8ea4f5b..e8310f1 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas5086.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
@@ -11,7 +11,7 @@ Optional properties:
 			chip's !RESET pin. If specified, the driver will
 			assert a hardware reset at probe time.
 
- - ti,charge-period:	This property should contain the time in microseconds
+ - ti,charge-period:	This property should contain the time in nanoseconds
 			that closely matches the external single-ended
 			split-capacitor charge period. The hardware chip
 			waits for this period of time before starting the
-- 
1.8.1.4
