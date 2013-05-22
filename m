From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 2/4] cs42l52: microphone bias is controlled by
	IFACE_CTL2 register.
Date: Wed, 22 May 2013 19:19:25 +0200
Message-ID: <1369243167-28700-3-git-send-email-nschichan@freebox.fr>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B17260861
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:19:52 +0200 (CEST)
In-Reply-To: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 sound/soc/codecs/cs42l52.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 6445d95..d2ee37d 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -225,7 +225,7 @@ static const char * const mic_bias_level_text[] = {
 };
 
 static const struct soc_enum mic_bias_level_enum =
-	SOC_ENUM_SINGLE(CS42L52_IFACE_CTL1, 0,
+	SOC_ENUM_SINGLE(CS42L52_IFACE_CTL2, 0,
 			ARRAY_SIZE(mic_bias_level_text), mic_bias_level_text);
 
 static const char * const cs42l52_mic_text[] = { "Single", "Differential" };
-- 
1.7.10.4
