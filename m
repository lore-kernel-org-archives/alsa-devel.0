From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 6/6] arm64: dts: apq8016-sbc: add mbhc
	buttons support
Date: Wed,  2 Aug 2017 19:09:30 +0200
Message-ID: <20170802170930.26083-7-srinivas.kandagatla@linaro.org>
References: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B9CF26738E
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 19:09:55 +0200 (CEST)
Received: by mail-io0-f171.google.com with SMTP id m88so22767708iod.2
 for <alsa-devel@alsa-project.org>; Wed, 02 Aug 2017 10:09:55 -0700 (PDT)
In-Reply-To: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: damien.riegel@savoirfairelinux.com, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 0981efc..bce458c 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -387,6 +387,8 @@
         status = "okay";
         clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
         clock-names = "mclk";
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
 };
 
 &spmi_pon {
-- 
2.9.3
