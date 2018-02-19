From: Olivier Moysan <olivier.moysan@st.com>
Subject: [RFC PATCH 1/3] ASoC: stm32: Add S/PDIF to SAI bindings
Date: Mon, 19 Feb 2018 16:00:35 +0100
Message-ID: <1519052437-24011-2-git-send-email-olivier.moysan@st.com>
References: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 936B5267409
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 16:00:45 +0100 (CET)
In-Reply-To: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add S/PDIF IEC6958 protocol support to STM32 SAI bindings.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index b1acc1a..f301cdf 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -45,6 +45,12 @@ SAI subnodes Optional properties:
 	This property sets SAI sub-block as slave of another SAI sub-block.
 	Must contain the phandle and index of the sai sub-block providing
 	the synchronization.
+  - st,iec60958: support S/PDIF IEC6958 protocol for playback
+	IEC60958 protocol is not available for capture.
+	By default, custom protocol is assumed, meaning that protocol is
+	configured according to protocol defined in related DAI link node,
+	such as i2s, left justified, right justified, dsp and pdm protocols.
+	Note: ac97 protocol is not supported by SAI driver
 
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
-- 
1.9.1
