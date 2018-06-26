From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: q6adm: dt-bindings: add compatible
	string to routing" to the asoc tree
Date: Tue, 26 Jun 2018 16:11:55 +0100 (BST)
Message-ID: <20180626151155.A49E9440070@finisterre.ee.mobilebroadband>
References: <20180625143115.8346-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FFF2267905
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 17:11:56 +0200 (CEST)
In-Reply-To: <20180625143115.8346-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: q6adm: dt-bindings: add compatible string to routing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c486a185744c593417a126aebb119771c1bbe670 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:05 +0100
Subject: [PATCH] ASoC: q6adm: dt-bindings: add compatible string to routing

Add compatible string to routing so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6adm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
index cb709e5dbc44..bbae426cdfb1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -18,6 +18,11 @@ used by the apr service device.
 = ADM routing
 "routing" subnode of the ADM node represents adm routing specific configuration
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6adm-routing".
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -28,6 +33,7 @@ q6adm@8 {
 	compatible = "qcom,q6adm";
 	reg = <APR_SVC_ADM>;
 	q6routing: routing {
+		compatible = "qcom,q6adm-routing";
 		#sound-dai-cells = <0>;
 	};
 };
-- 
2.17.1
