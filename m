From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/9] ASoC: max98095: Add missing negative
	channel checks
Date: Wed, 30 Oct 2013 08:35:04 +0100
Message-ID: <1383118507-21503-7-git-send-email-tiwai@suse.de>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B74D264F13
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 08:32:34 +0100 (CET)
In-Reply-To: <1383118507-21503-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Otherwise it'd lead to negative array index read.
Spotted by coverity CIDs 143182, 143184.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/max98095.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 8fb072455802..bffcf4e6a2a2 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1740,6 +1740,8 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 	int fs, best, best_val, i;
 	int regmask, regsave;
 
+	if (channel < 0)
+		return channel;
 	BUG_ON(channel > 1);
 
 	if (!pdata || !max98095->eq_textcnt)
@@ -1798,6 +1800,8 @@ static int max98095_get_eq_enum(struct snd_kcontrol *kcontrol,
 	int channel = max98095_get_eq_channel(kcontrol->id.name);
 	struct max98095_cdata *cdata;
 
+	if (channel < 0)
+		return channel;
 	cdata = &max98095->dai[channel];
 	ucontrol->value.enumerated.item[0] = cdata->eq_sel;
 
-- 
1.8.4.1
