From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 10/11] ASoC: codec: Support for ASoC Realtek
	HDA codec Driver
Date: Fri, 15 Dec 2017 17:00:47 +0530
Message-ID: <1513337448-31685-11-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AFEA267BAC
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:26:40 +0100 (CET)
In-Reply-To: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds a Kconfig entry to compile existing legacy Realtek
HDA codec drivers as ASoC codec driver.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/codecs/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1d41d11..97fd997 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -80,6 +80,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_HDAC_HDA
+	select SND_SOC_HDA_REALTEK
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C
@@ -587,6 +588,11 @@ config SND_SOC_HDAC_HDA
 	select SND_HDA_EXT_CORE
 	select SND_PCM_ELD
 
+config SND_SOC_HDA_REALTEK
+	select SND_HDA_CODEC_REALTEK
+	select SND_SOC_HDAC_HDA
+	tristate "Realtek ASoC HDA Codec Driver patch"
+
 config SND_SOC_ICS43432
 	tristate
 
-- 
2.7.4
