From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ASoC: core: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:14:56 +0200
Message-ID: <1413886496-19158-3-git-send-email-tiwai@suse.de>
References: <1413886496-19158-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 43436266666
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:15:03 +0200 (CEST)
In-Reply-To: <1413886496-19158-1-git-send-email-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

... and reduce the open codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4c8f8a23a0e9..96ecdc30eb60 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2348,16 +2348,8 @@ int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
 {
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
-	uinfo->value.enumerated.items = e->items;
-
-	if (uinfo->value.enumerated.item >= e->items)
-		uinfo->value.enumerated.item = e->items - 1;
-	strlcpy(uinfo->value.enumerated.name,
-		e->texts[uinfo->value.enumerated.item],
-		sizeof(uinfo->value.enumerated.name));
-	return 0;
+	return snd_ctl_enum_info(uinfo, e->shift_l == e->shift_r ? 1 : 2,
+				 e->items, e->texts);
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_enum_double);
 
-- 
2.1.2
