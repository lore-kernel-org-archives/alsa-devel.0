From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] bindings: sound: davinci-mcasp: Add support for optional auxclk-fs-ratio
Date: Tue, 11 Jun 2019 15:29:40 +0300
Message-ID: <20190611122941.10708-2-peter.ujfalusi@ti.com>
References: <20190611122941.10708-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611122941.10708-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When McASP is bus master it's reference clock (AUXCLK) might not be a
static clock, but running at a specific FS ratio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/davinci-mcasp-audio.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index a58f79f5345c..c483dcec01f8 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -44,6 +44,9 @@ Optional properties:
   		 please refer to pinctrl-bindings.txt
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
+- auxclk-fs-ratio: When McASP is bus master indicates the ratio between AUCLK
+		   and FS rate if applicable:
+		   AUCLK rate = auxclk-fs-ratio * FS rate
 
 Optional GPIO support:
 If any McASP pin need to be used as GPIO then the McASP node must have:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
