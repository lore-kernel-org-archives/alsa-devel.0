From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 6/6] ARM: DT: b2120: add audio HDMI dai link in
	audio card
Date: Tue, 19 Jan 2016 14:40:36 +0100
Message-ID: <1453210836-16218-7-git-send-email-arnaud.pouliquen@st.com>
References: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 00ADA265740
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 14:41:14 +0100 (CET)
In-Reply-To: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add the HDMI dai link to support audio for HDMI output

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 1ec71fe..a773c00 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -126,6 +126,19 @@
 		status = "okay";
 
 		simple-audio-card,dai-link@0 {
+			/* HDMI */
+			format = "i2s";
+			mclk-fs = <128>;
+			cpu {
+				sound-dai = <&sti_uni_player0>;
+			};
+
+			codec {
+				sound-dai = <&sti_hdmi>;
+			};
+		};
+
+		simple-audio-card,dai-link@1 {
 			/* DAC */
 			format = "i2s";
 			dai-tdm-slot-width = <32>;
@@ -139,7 +152,7 @@
 			};
 		};
 
-		simple-audio-card,dai-link@1 {
+		simple-audio-card,dai-link@2 {
 			/* SPDIF */
 			format = "left_j";
 			mclk-fs = <128>;
-- 
1.9.1
