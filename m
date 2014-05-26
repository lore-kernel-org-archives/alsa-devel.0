From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: alc5623: Fix Kconfig dependency
Date: Mon, 26 May 2014 16:08:37 +0200
Message-ID: <1401113317-32101-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C85D260309
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 16:08:38 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add "depends on I2C" to shut up the build errors from randconfig.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c59943a19f94..3f7bbe61326d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -274,6 +274,7 @@ config SND_SOC_AK5386
 
 config SND_SOC_ALC5623
        tristate "Realtek ALC5623 CODEC"
+	depends on I2C
 
 config SND_SOC_ALC5632
 	tristate
-- 
1.9.3
