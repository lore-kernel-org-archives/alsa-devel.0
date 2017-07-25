From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/2] ASoC: Add bindings for DMIC codec driver
Date: Tue, 25 Jul 2017 10:48:13 +0200
Message-ID: <1500972494-10696-2-git-send-email-arnaud.pouliquen@st.com>
References: <1500972494-10696-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 66ACE266C25
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 10:48:30 +0200 (CEST)
In-Reply-To: <1500972494-10696-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds documentation of device tree bindings for audio DMIC codec.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 Documentation/devicetree/bindings/sound/dmic.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
new file mode 100644
index 0000000..a0c58f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -0,0 +1,12 @@
+Device-Tree bindings for Digital microphone (DMIC) codec
+
+This device support generic PDM digital microphone.
+
+Required properties:
+	- compatible: should be "dmic-codec".
+
+Example node:
+
+	dmic_codec: dmic@0 {
+		compatible = "dmic-codec";
+	};
-- 
2.7.4
