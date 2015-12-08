From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 05/13] ASoC: wm_adsp: Select SND_SOC_COMPRESS
Date: Tue, 8 Dec 2015 16:08:29 +0000
Message-ID: <1449590917-21170-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 69A042604EF
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:07 +0100 (CET)
In-Reply-To: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Additions to the DSP mean we will need to include support for the
compressed framework. This patch selects SND_SOC_COMPRESS.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c0c5c8e..2b51aff 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -218,6 +218,7 @@ config SND_SOC_WM_HUBS
 
 config SND_SOC_WM_ADSP
 	tristate
+	select SND_SOC_COMPRESS
 	default y if SND_SOC_CS47L24=y
 	default y if SND_SOC_WM5102=y
 	default y if SND_SOC_WM5110=y
-- 
2.1.4
