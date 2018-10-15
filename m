From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/4] ASoC: dt-bindings: add mclk provider
	support to stm32 sai
Date: Mon, 15 Oct 2018 16:03:33 +0200
Message-ID: <1539612216-12602-2-git-send-email-olivier.moysan@st.com>
References: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 9FADC2677F5
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 16:03:43 +0200 (CEST)
In-Reply-To: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

add mclk provider support to stm32 sai

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index 3a3fc506e43a..3f4467ff0aa2 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -31,7 +31,11 @@ SAI subnodes required properties:
   - reg: Base address and size of SAI sub-block register set.
   - clocks: Must contain one phandle and clock specifier pair
 	for sai_ck which feeds the internal clock generator.
+	If the SAI shares a master clock, with another SAI set as MCLK
+	clock provider, SAI provider phandle must be specified here.
   - clock-names: Must contain "sai_ck".
+	Must also contain "MCLK", if SAI shares a master clock,
+	with a SAI set as MCLK clock provider.
   - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
   - dma-names: identifier string for each DMA request line
 	"tx": if sai sub-block is configured as playback DAI
@@ -51,6 +55,9 @@ SAI subnodes Optional properties:
 	configured according to protocol defined in related DAI link node,
 	such as i2s, left justified, right justified, dsp and pdm protocols.
 	Note: ac97 protocol is not supported by SAI driver
+   - #clock-cells: should be 0. This property must be present if the SAI device
+	is a master clock provider, according to clocks bindings, described in
+	Documentation/devicetree/bindings/clock/clock-bindings.txt.
 
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
-- 
2.7.4
