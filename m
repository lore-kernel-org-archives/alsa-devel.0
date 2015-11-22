From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: hdac-hdmi: make driver select
	CONFIG_HDMI
Date: Sun, 22 Nov 2015 16:24:58 +0530
Message-ID: <1448189698-8756-2-git-send-email-vinod.koul@intel.com>
References: <1448189698-8756-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8031F2606CD
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 11:51:13 +0100 (CET)
In-Reply-To: <1448189698-8756-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Since driver use infoframe symbols from video/hdmi.c we should select this
symbol for this driver

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b2b0b71f0bcf..5c584dad0af0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -458,6 +458,7 @@ config SND_SOC_DMIC
 config SND_SOC_HDAC_HDMI
 	tristate
 	select SND_HDA_EXT_CORE
+	select HDMI
 
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
-- 
1.9.1
