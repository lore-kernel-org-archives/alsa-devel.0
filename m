From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Enable autodisable on
	SOC_DAPM_SINGLE_TLV_AUTODISABLE
Date: Wed, 22 Apr 2015 13:58:47 +0100
Message-ID: <1429707527-5998-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BDF12605CF
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 15:05:49 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Correct small copy and paste error where autodisable was not being
enabled for the SOC_DAPM_SINGLE_TLV_AUTODISABLE control.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 0bc8364..1065095 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -287,7 +287,7 @@ struct device;
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
 #define SOC_DAPM_SINGLE_TLV_VIRT(xname, max, tlv_array) \
 	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0, tlv_array)
 #define SOC_DAPM_ENUM(xname, xenum) \
-- 
1.7.2.5
