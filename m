From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] ASoC: TLV320AIC23: make codecs selectable in
	Kconfig
Date: Wed, 29 Oct 2014 16:25:38 +0300
Message-ID: <1414589138-1956-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id CF04F260537
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 14:26:00 +0100 (CET)
Received: by mail-lb0-f176.google.com with SMTP id z11so489370lbi.35
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 06:25:59 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Now that manual selection of drivers for audio subsystem components is
preferred AIC23 codec must be selectable in Kconfig to make it possible.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 sound/soc/codecs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8838838e..7dad805 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -552,11 +552,11 @@ config SND_SOC_TLV320AIC23
 	tristate
 
 config SND_SOC_TLV320AIC23_I2C
-	tristate
+	tristate "Texas Instruments TLV320AIC23 audio CODEC - I2C"
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC23_SPI
-	tristate
+	tristate "Texas Instruments TLV320AIC23 audio CODEC - SPI"
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC26
-- 
1.8.1.4
