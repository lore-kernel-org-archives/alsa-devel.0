From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v6 2/2] ASoC: sirf: Add hdmi support
Date: Thu, 27 Mar 2014 13:27:05 +0800
Message-ID: <1395898025-5437-3-git-send-email-rongjun.ying@csr.com>
References: <1395898025-5437-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C8592651CE
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 06:28:13 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id fb1so2963827pad.15
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 22:28:12 -0700 (PDT)
In-Reply-To: <1395898025-5437-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

Use the simple-card

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
-v6:
Use the simple-card instead of hdmi card driver

 sound/soc/sirf/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index e0b7157..ccbf571 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -13,6 +13,13 @@ config SND_SOC_SIRF_AUDIO_PORT
 	select REGMAP_MMIO
 	tristate
 
+config SND_SOC_SIRF_HDMI
+	tristate "SoC Audio support for SiRF HDMI"
+	depends on SND_SOC_SIRF
+	select SND_SIMPLE_CARD
+	select SND_SOC_SIRF_I2S
+	select SND_SOC_HDMI_CODEC
+
 config SND_SOC_SIRF_I2S
 	select REGMAP_MMIO
 	tristate
-- 
1.7.5.4
