From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [resend PATCH] dt-bindings: sound: Add documentation
	for pcm3060 property out-single-ended
Date: Thu, 15 Nov 2018 08:12:53 +0100
Message-ID: <20181115071253.22558-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id CA587267A61
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 08:12:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Output of pcm3060 codec may be configured as single-ended or differential

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: devicetree@vger.kernel.org
---
Hello Mark,

yesterday there was a misunderstanding: when I wrote you

> I think you forgot one patch in the series

you accidently applied the already-applied patch instead of the forgotten
one. To avoid the confusion, in this e-mail I resend you the proper
forgotten patch in a separate mailing thread.

Please apply this patch for-next.

Best Regards,
Kirill
---
 Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/pcm3060.txt b/Documentation/devicetree/bindings/sound/pcm3060.txt
index 90fcb8523099..97de66932d44 100644
--- a/Documentation/devicetree/bindings/sound/pcm3060.txt
+++ b/Documentation/devicetree/bindings/sound/pcm3060.txt
@@ -9,9 +9,15 @@ Required properties:
 - reg : the I2C address of the device for I2C, the chip select
         number for SPI.
 
+Optional properties:
+
+- ti,out-single-ended: "true" if output is single-ended;
+                       "false" or not specified if output is differential.
+
 Examples:
 
 	pcm3060: pcm3060@46 {
 		 compatible = "ti,pcm3060";
 		 reg = <0x46>;
+		 ti,out-single-ended = "true";
 	};
-- 
2.13.6
