From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH 1/2] Add volume range check and warn if it too
	big
Date: Thu, 10 Mar 2011 14:53:38 +0100
Message-ID: <1299765219-31386-2-git-send-email-bug-track@fisher-privat.net>
References: <1299765219-31386-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 105A51037FB
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 14:54:05 +0100 (CET)
In-Reply-To: <1299765219-31386-1-git-send-email-bug-track@fisher-privat.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

Se comment in patch: a5c7d797dcce3be5e77cd6ea62cc4920ededc32b
ALSA: usb-audio - Add volume resolution quirk for some Logitech webcams

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 sound/usb/mixer.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 85af605..eba8ae8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -987,6 +987,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	struct snd_kcontrol *kctl;
 	struct usb_mixer_elem_info *cval;
 	const struct usbmix_name_map *map;
+	unsigned int range;
 
 	control++; /* change from zero-based to 1-based value */
 
@@ -1136,6 +1137,20 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 
 	}
 
+	range = (cval->max - cval->min) / cval->res;
+	/* Are there devices with volume range more than 255? I use a bit more
+	 * to be sure. 384 is a resolution magick nuber found on Logitech
+	 * devices. It will definitively catch all buggy Logitech devices. */
+	if (range > 384) {
+		snd_printk(KERN_WARNING "usb_audio: Warning! Unlikely big "
+			   "volume range (=%u), cval->res is probably wrong.",
+			   range);
+		snd_printk(KERN_WARNING "usb_audio: [%d] FU [%s] ch = %d, "
+			   "val = %d/%d/%d", cval->id,
+			   kctl->id.name, cval->channels,
+			   cval->min, cval->max, cval->res);
+	}
+
 	snd_printdd(KERN_INFO "[%d] FU [%s] ch = %d, val = %d/%d/%d\n",
 		    cval->id, kctl->id.name, cval->channels, cval->min, cval->max, cval->res);
 	add_control_to_empty(state, kctl);
-- 
1.7.1
