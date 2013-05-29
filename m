From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 2/2] ASoC: cs42l52: fix hp_gain_enum shift
	value.
Date: Wed, 29 May 2013 20:01:20 +0200
Message-ID: <1369850480-1772-3-git-send-email-nschichan@freebox.fr>
References: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 2738126500D
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 20:01:46 +0200 (CEST)
In-Reply-To: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 sound/soc/codecs/cs42l52.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 756c204..987f728 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -262,7 +262,7 @@ static const char * const hp_gain_num_text[] = {
 };
 
 static const struct soc_enum hp_gain_enum =
-	SOC_ENUM_SINGLE(CS42L52_PB_CTL1, 4,
+	SOC_ENUM_SINGLE(CS42L52_PB_CTL1, 5,
 		ARRAY_SIZE(hp_gain_num_text), hp_gain_num_text);
 
 static const char * const beep_pitch_text[] = {
-- 
1.7.10.4
