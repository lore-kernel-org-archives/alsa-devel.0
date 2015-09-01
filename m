From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: SPEAr: Make SND_SPEAR_SOC select
 SND_SOC_GENERIC_DMAENGINE_PCM
Date: Tue, 01 Sep 2015 12:31:24 +0800
Message-ID: <1441081884.12012.7.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 32CE5261A5A
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 06:31:28 +0200 (CEST)
Received: by pabzx8 with SMTP id zx8so162313801pab.1
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 21:31:28 -0700 (PDT)
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
Cc: Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

devm_snd_dmaengine_pcm_register() is guarded by
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/spear/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
index 0a53053..4fb9141 100644
--- a/sound/soc/spear/Kconfig
+++ b/sound/soc/spear/Kconfig
@@ -1,6 +1,6 @@
 config SND_SPEAR_SOC
 	tristate
-	select SND_DMAENGINE_PCM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_SPEAR_SPDIF_OUT
 	tristate
-- 
2.1.0
