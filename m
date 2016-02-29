From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ASoC: max98088: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:08:01 +0100
Message-ID: <1456765684-5717-3-git-send-email-tiwai@suse.de>
References: <1456765684-5717-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24EA72625D7
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:08:06 +0100 (CET)
In-Reply-To: <1456765684-5717-1-git-send-email-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

"EQ1 Mode" and "EQ2 Mode" ctls in max98088 codec driver are enum,
while the current driver accesses wrongly via value.integer.value[].
They have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/max98088.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 20dcc496d39c..fc22804cabc5 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1496,7 +1496,7 @@ static int max98088_put_eq_enum(struct snd_kcontrol *kcontrol,
        struct max98088_pdata *pdata = max98088->pdata;
        int channel = max98088_get_channel(codec, kcontrol->id.name);
        struct max98088_cdata *cdata;
-       int sel = ucontrol->value.integer.value[0];
+	int sel = ucontrol->value.enumerated.item[0];
 
        if (channel < 0)
 	       return channel;
-- 
2.7.2
