From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/31] ASoC: wm8904: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:39:58 +0100
Message-ID: <1383673218-18405-12-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1B62651CF
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8904.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 4dfa8dceeabf..c173ab3cd18a 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -658,7 +658,8 @@ SOC_SINGLE_TLV("EQ5 Volume", WM8904_EQ6, 0, 24, 0, eq_tlv),
 static int cp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
-	BUG_ON(event != SND_SOC_DAPM_POST_PMU);
+	if (WARN_ON(event != SND_SOC_DAPM_POST_PMU))
+		return -EINVAL;
 
 	/* Maximum startup time */
 	udelay(500);
-- 
1.8.4.2
