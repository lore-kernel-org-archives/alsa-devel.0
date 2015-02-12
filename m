From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [Patch V5 04/12] ASoC: qcom: Document IPQ806X-MAX89357A bindings
Date: Wed, 11 Feb 2015 18:10:07 -0800
Message-ID: <1423707015-14527-5-git-send-email-kwestfie@codeaurora.org>
References: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423707015-14527-1-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Add documentation to the sound directory of the
device-tree bindings for the IPQ806x-MAX98357A
soundcard.

Signed-off-by: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../bindings/sound/qcom,ipq806x-max98357a.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,ipq806x-max98357a.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,ipq806x-max98357a.txt b/Documentation/devicetree/bindings/sound/qcom,ipq806x-max98357a.txt
new file mode 100644
index 0000000000000000000000000000000000000000..54c6211ce34ab8eb5c764df516c875694eeab3cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,ipq806x-max98357a.txt
@@ -0,0 +1,24 @@
+* Qualcomm Technologies IPQ806x-MAX98357A SoundCard
+
+This node models a soundcard for boards with the Qualcomm Technologies IPQ806x
+SOC connected to a MAX98357A DAC via I2S.
+
+Required properties:
+
+- compatible	: "qcom,ipq806x-max98357a"
+- qcom,model	: The user-visible name of this sound card.
+- cpu		: Phandle of the CPU DAI
+- codec		: Phandle of the codec DAI
+- codec-dai	: Name of the codec DAI which must be selected from one of the
+		  following entries:
+			* max98357a
+
+Example:
+
+sound {
+	compatible = "qcom,ipq806x-max98357a";
+	model = "ipq806x-max98357a";
+	cpu = <&lpass_cpu>;
+	codec = <&max98357a>;
+	codec-dai = "max98357a";
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
