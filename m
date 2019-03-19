From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/3] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK
Date: Tue, 19 Mar 2019 17:49:30 +0000
Message-ID: <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

With the need to expose WCLK and BCLK as separate clocks, the
'clock-cells' and 'clock-output-names' descriptions need to be
updated as now the codec is providing 2 clocks. The example is
also updated accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index e9d0bae..add1caf 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -23,8 +23,8 @@ Optional properties:
   interrupt is to be used to wake system, otherwise "irq" should be used.
 - wakeup-source: Flag to indicate this device can wake system (suspend/resume).
 
-- #clock-cells :  Should be set to '<0>', only one clock source provided;
-- clock-output-names : Name given for DAI clocks output;
+- #clock-cells :  Should be set to '<1>', two clock sources provided;
+- clock-output-names : Names given for DAI clock outputs (WCLK & BCLK);
 
 - clocks : phandle and clock specifier for codec MCLK.
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
@@ -84,8 +84,8 @@ Example:
 		VDDMIC-supply = <&reg_audio>;
 		VDDIO-supply = <&reg_audio>;
 
-		#clock-cells = <0>;
-		clock-output-names = "dai-clks";
+		#clock-cells = <1>;
+		clock-output-names = "dai-wclk", "dai-bclk";
 
 		clocks = <&clks 201>;
 		clock-names = "mclk";
-- 
1.9.1
