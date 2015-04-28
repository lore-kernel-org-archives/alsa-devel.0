From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 05/12] trivial: ASoC: adau1977: fix typo
	s/Substraction/Subtraction/
Date: Tue, 28 Apr 2015 13:11:24 +0200
Message-ID: <1430219491-5076-6-git-send-email-ao2@ao2.it>
References: <1430219491-5076-1-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id B5212260513
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 13:12:10 +0200 (CEST)
In-Reply-To: <1430219491-5076-1-git-send-email-ao2@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Antonio Ospite <ao2@ao2.it>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/adau1977.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 7ad8e15..dc8ad08 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -202,7 +202,7 @@ static const struct snd_soc_dapm_route adau1977_dapm_routes[] = {
 		ADAU1977_REG_DC_HPF_CAL, (x) - 1, 1, 0)
 
 #define ADAU1977_DC_SUB_SWITCH(x) \
-	SOC_SINGLE("ADC" #x " DC Substraction Capture Switch", \
+	SOC_SINGLE("ADC" #x " DC Subtraction Capture Switch", \
 		ADAU1977_REG_DC_HPF_CAL, (x) + 3, 1, 0)
 
 static const struct snd_kcontrol_new adau1977_snd_controls[] = {
-- 
2.1.4
