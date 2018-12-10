From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: sdm845: add rt5663 codec select
Date: Mon, 10 Dec 2018 21:49:28 +0100
Message-ID: <20181210204943.2581826-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A895E267AFE
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 21:49:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Calling into the codec driver adds a dependency on that being reachable
from the module:

ERROR: "rt5663_sel_asrc_clk_src" [sound/soc/qcom/snd-soc-sdm845.ko]
undefined!

Add the corresponding select statement, as it is done in the other user
(Intel).

Fixes: f7485875a687 ("ASoC: sdm845: Add configuration for headset codec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2a4c912d1e48..1b9fc0665792 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -100,6 +100,7 @@ config SND_SOC_SDM845
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
+	select SND_SOC_RT5663
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.0
