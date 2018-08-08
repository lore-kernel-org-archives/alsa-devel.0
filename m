From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH] ASoC: max98373: Added software reset register
	to readable registers
Date: Tue,  7 Aug 2018 20:06:38 -0700
Message-ID: <20180808030638.8085-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0128.outbound.protection.outlook.com [104.47.36.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EF71267898
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 05:07:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Added 'MAX98373_R2000_SW_RESET' register to 'max98373_readable_register'
           Software reset didn't work properly after suspend/resume.
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a925861..92b7125 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -488,6 +488,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
 static bool max98373_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MAX98373_R2000_SW_RESET:
 	case MAX98373_R2001_INT_RAW1 ... MAX98373_R200C_INT_EN3:
 	case MAX98373_R2010_IRQ_CTRL:
 	case MAX98373_R2014_THERM_WARN_THRESH
-- 
2.7.4
