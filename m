From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 10/11] ASoC: add bindings for stm32 DFSDM
	filter
Date: Fri, 17 Mar 2017 15:08:23 +0100
Message-ID: <1489759704-30217-11-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 718F8266A0A
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 15:09:02 +0100 (CET)
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, olivier moysan <olivier.moysan@st.com>, kernel@stlinux.com, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

Add bindings that describes audio settings to support
Digital Filter for pulse density modulation(PDM) microphone.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V2->V3:
   Fixes based on V2 comments

 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
new file mode 100644
index 0000000..ab610bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
@@ -0,0 +1,40 @@
+STMicroelectronics audio DFSDM DT bindings
+
+This driver supports audio PDM microphone capture through Digital Filter format
+Sigma Delta modulators (DFSDM).
+
+Required properties:
+  - compatible: "st,stm32h7-adfsdm".
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - io-channels : phandle to iio dfsdm instance node.
+
+
+Example of a simple sound card using audio DFSDM node.
+
+	dmic0: dmic_@0 {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+	};
+
+	asoc-pdm@0 {
+		compatible = "st,stm32h7-adfsdm";
+		#sound-dai-cells = <0>;
+		io-channels = <&dfsdm_adc0 0>;
+	};
+
+	sound_dfsdm_pdm {
+ 		compatible = "simple-audio-card";
+ 		simple-audio-card,name = "dfsdm_pdm";
+
+ 		dfsdm0_mic0: simple-audio-card,dai-link@0 {
+ 			format = "pdm";
+ 			cpu {
+ 				sound-dai = <&asoc_pdm1>;
+ 			};
+ 			dmic0_codec: codec {
+ 				sound-dai = <&dmic0>;
+ 			};
+ 		};
+	};
\ No newline at end of file
-- 
1.9.1
