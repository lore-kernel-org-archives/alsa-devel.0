From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec
	driver
Date: Fri, 17 Mar 2017 15:08:21 +0100
Message-ID: <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B094266B26
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 15:08:59 +0100 (CET)
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

This patch adds documentation of device tree bindings for audio DMIC codec.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 Documentation/devicetree/bindings/sound/dmic.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
new file mode 100644
index 0000000..eb2a9d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -0,0 +1,11 @@
+Device-Tree bindings for dmic codec
+
+Required properties:
+	- compatible: should be "dmic-codec".
+
+Example node:
+
+	dmic_audio: dmic_audio@0 {
+		compatible = "dmic-codec";
+		status = "okay";
+	};
-- 
1.9.1
