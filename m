From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: da7218: Correct IRQ level in DT
	binding example
Date: Fri, 17 Nov 2017 15:09:28 +0000
Message-ID: <c57eabe7cd6bb5a5466c774725c5150cc33d1ab5.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 61932267232
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 16:09:30 +0100 (CET)
In-Reply-To: <cover.1510930791.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Current DT binding documentation shows an example where the IRQ
for the device is chosen to be ACTIVE_HIGH. This is incorrect as
the device only supports ACTIVE_LOW, so this commit fixes that
discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7218.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/da7218.txt b/Documentation/devicetree/bindings/sound/da7218.txt
index 5ca5a70..3ab9dfe 100644
--- a/Documentation/devicetree/bindings/sound/da7218.txt
+++ b/Documentation/devicetree/bindings/sound/da7218.txt
@@ -73,7 +73,7 @@ Example:
 		compatible = "dlg,da7218";
 		reg = <0x1a>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
 
 		VDD-supply = <&reg_audio>;
-- 
1.9.1
