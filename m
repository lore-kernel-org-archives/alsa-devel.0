From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/43] ALSA: mts64: Use snd_ctl_elem_info()
Date: Tue, 21 Oct 2014 12:10:41 +0200
Message-ID: <1413886279-18704-6-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CE4CF266638
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0C16BACE5
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:23 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

... and reduce the open codes.  Also add missing const to the text array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/mts64.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index f5fd448dbc57..0388fbbd2c06 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -604,21 +604,11 @@ static struct snd_kcontrol_new mts64_ctl_smpte_time_frames = {
 static int snd_mts64_ctl_smpte_fps_info(struct snd_kcontrol *kctl,
 					struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[5] = { "24",
-				  "25",
-				  "29.97",
-				  "30D",
-				  "30"    };
+	static const char * const texts[5] = {
+		"24", "25", "29.97", "30D", "30"
+	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 5;
-	if (uinfo->value.enumerated.item > 4)
-		uinfo->value.enumerated.item = 4;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 5, texts);
 }
 
 static int snd_mts64_ctl_smpte_fps_get(struct snd_kcontrol *kctl,
-- 
2.1.2
