From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: apq8016-sbc: dt bindings: remove incorrect property" to the asoc tree
Date: Mon, 24 Oct 2016 19:04:11 +0100
Message-ID: <E1byjbX-0001I5-M8@debutante>
References: <1473339896-9409-4-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1473339896-9409-4-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: apq8016-sbc: dt bindings: remove incorrect property

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 393ac586236c25d36f1a1ea9650ac3f3c3b91bce Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 20 Oct 2016 15:20:47 +0100
Subject: [PATCH] ASoC: apq8016-sbc: dt bindings: remove incorrect property

This patch removes capture-dai property which should not have existed
in this document in the first place. It looks like leftover from old
version of patches by mistake.

Remove it to avoid any confusion in future.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
index d9d8635ff94c..72c192801a69 100644
--- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
@@ -45,7 +45,6 @@ Required CPU/CODEC subnodes properties:
 
 -link-name		: Name of the dai link.
 -sound-dai		: phandle and port of CPU/CODEC
--capture-dai		: phandle and port of CPU/CODEC
 
 Example:
 
-- 
2.8.1
