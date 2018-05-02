From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: usb-audio: Avoid superfluous
	usb_set_interface() calls
Date: Wed,  2 May 2018 16:11:12 +0200
Message-ID: <20180502141116.31966-3-tiwai@suse.de>
References: <20180502141116.31966-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F799266F4E
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 16:11:21 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7B594AEFA
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 14:11:19 +0000 (UTC)
In-Reply-To: <20180502141116.31966-1-tiwai@suse.de>
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

This is a preliminary change for the upcoming quirk implementation.

Currently USB-audio driver tries to call usb_set_interface() whenever
the format change with interface/altset modification happens.  In this
patch, the check is replaced with the comparison of cur_altsetting and
the targeted altsetting pointer, so that the driver may skip the
unnecessary function calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ad39b3cca247..ae7d8a0a0a0a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -499,7 +499,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	iface = usb_ifnum_to_if(dev, fmt->iface);
 	if (WARN_ON(!iface))
 		return -EINVAL;
-	alts = &iface->altsetting[fmt->altset_idx];
+	alts = usb_altnum_to_altsetting(iface, fmt->altsetting);
 	altsd = get_iface_desc(alts);
 	if (WARN_ON(altsd->bAlternateSetting != fmt->altsetting))
 		return -EINVAL;
@@ -521,9 +521,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	}
 
 	/* set interface */
-	if (subs->interface != fmt->iface ||
-	    subs->altset_idx != fmt->altset_idx) {
-
+	if (iface->cur_altsetting != alts) {
 		err = snd_usb_select_mode_quirk(subs, fmt);
 		if (err < 0)
 			return -EIO;
@@ -537,12 +535,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		}
 		dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
 			fmt->iface, fmt->altsetting);
-		subs->interface = fmt->iface;
-		subs->altset_idx = fmt->altset_idx;
-
 		snd_usb_set_interface_quirk(dev);
 	}
 
+	subs->interface = fmt->iface;
+	subs->altset_idx = fmt->altset_idx;
 	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 						   alts, fmt->endpoint, subs->direction,
 						   SND_USB_ENDPOINT_TYPE_DATA);
-- 
2.16.3
