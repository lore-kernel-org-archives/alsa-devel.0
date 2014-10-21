From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ASoC: s6000: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:14:55 +0200
Message-ID: <1413886496-19158-2-git-send-email-tiwai@suse.de>
References: <1413886496-19158-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 43824266667
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
 sound/soc/s6000/s6105-ipcam.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index 3510c01f8a6a..e1e159257b57 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -80,16 +80,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int output_type_info(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_info *uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item) {
-		uinfo->value.enumerated.item = 1;
-		strcpy(uinfo->value.enumerated.name, "HPLOUT/HPROUT");
-	} else {
-		strcpy(uinfo->value.enumerated.name, "HPLOUT/HPLCOM");
-	}
-	return 0;
+	static const char * const texts[] = {
+		"HPLOUT/HPLCOM", "HPLOUT/HPROUT",
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int output_type_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
