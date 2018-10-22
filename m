From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/2] ASoC: stm32: add clock dependency for sai
Date: Mon, 22 Oct 2018 17:10:45 +0200
Message-ID: <1540221046-11812-2-git-send-email-olivier.moysan@st.com>
References: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 26ED92677D0
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 17:10:50 +0200 (CEST)
In-Reply-To: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")

Add COMMON_CLK dependency for STM32 SAI,
as it is required by clock provider.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 9b2681397dba..c66ffa72057e 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -3,6 +3,7 @@ menu "STMicroelectronics STM32 SOC audio support"
 config SND_SOC_STM32_SAI
 	tristate "STM32 SAI interface (Serial Audio Interface) support"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	depends on COMMON_CLK
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
-- 
2.7.4
