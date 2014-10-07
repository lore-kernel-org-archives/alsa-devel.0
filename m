From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 4/8] ASoC: eukrea-tlv320: Add indentation for binding doc to increase readability
Date: Tue,  7 Oct 2014 12:29:07 -0700
Message-ID: <54aeea0c484b42125e10c54056b3b7f2b67b14d6.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1412708790.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

This patch refines the DT binding doc for more readability by adding
extra blank lines and indentations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/devicetree/bindings/sound/eukrea-tlv320.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
index 0d7985c..6dfa88c 100644
--- a/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
+++ b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
@@ -1,11 +1,16 @@
 Audio complex for Eukrea boards with tlv320aic23 codec.
 
 Required properties:
-- compatible : "eukrea,asoc-tlv320"
-- eukrea,model : The user-visible name of this sound complex.
-- ssi-controller : The phandle of the SSI controller.
-- fsl,mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
-- fsl,mux-ext-port : The external port of the i.MX audio muxer.
+
+  - compatible		: "eukrea,asoc-tlv320"
+
+  - eukrea,model	: The user-visible name of this sound complex.
+
+  - ssi-controller	: The phandle of the SSI controller.
+
+  - fsl,mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX).
+
+  - fsl,mux-ext-port	: The external port of the i.MX audio muxer.
 
 Note: The AUDMUX port numbering should start at 1, which is consistent with
 hardware manual.
-- 
1.9.1
