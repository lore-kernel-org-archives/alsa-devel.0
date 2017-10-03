From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-analog: fix module
	autoload" to the asoc tree
Date: Tue,  3 Oct 2017 17:53:49 +0100 (BST)
Message-ID: <20171003165349.C00F4440053@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9801A266E55
 for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2017 18:53:50 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-analog: fix module autoload

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

>From 46d69e141d479585c105a4d5b2337cd2ce6967e5 Mon Sep 17 00:00:00 2001
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Tue, 3 Oct 2017 11:49:51 +0200
Subject: [PATCH] ASoC: codecs: msm8916-wcd-analog: fix module autoload

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo snd_soc_msm8916_analog | grep alias
$

After this patch:

$ modinfo snd_soc_msm8916_analog | grep alias
alias:          of:N*T*Cqcom,pm8916-wcd-analog-codecC*
alias:          of:N*T*Cqcom,pm8916-wcd-analog-codec

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index f562f2d86907..3593c578e3e7 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1239,6 +1239,8 @@ static const struct of_device_id pm8916_wcd_analog_spmi_match_table[] = {
 	{ }
 };
 
+MODULE_DEVICE_TABLE(of, pm8916_wcd_analog_spmi_match_table);
+
 static struct platform_driver pm8916_wcd_analog_spmi_driver = {
 	.driver = {
 		   .name = "qcom,pm8916-wcd-spmi-codec",
-- 
2.14.1
