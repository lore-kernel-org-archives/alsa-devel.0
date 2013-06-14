From: Mark Brown <broonie@linaro.org>
Subject: [PATCH 1/2] ASoC: SPEAr: Add dependency on dmaengine
	helpers
Date: Fri, 14 Jun 2013 12:30:17 +0100
Message-ID: <1371209418-32496-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E9872651A1
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:30:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

I'd be very surprised if anyone has used the Kconfig...

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/spear/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
index 3b7cdad..5b744ed 100644
--- a/sound/soc/spear/Kconfig
+++ b/sound/soc/spear/Kconfig
@@ -27,6 +27,7 @@ config SND_SPEAR_SOC
 	 Say Y or M if you want to add support for any of the audio
 	 controllers (I2S/SPDIF). You will also need to select
 	 the audio interface codecs to support below.
+	select SND_SOC_DMAENGINE_PCM
 
 config SND_SPEAR_SPDIF_OUT
 	tristate "SPEAr SPDIF Out Device Driver"
-- 
1.7.10.4
