From: Christian Melki <christian.melki@ericsson.com>
Subject: [PATCH]: sound/usb/mixer.c: Volume quirks compare
 empty string kctl->id.name.
Date: Mon, 7 May 2012 09:51:29 +0200
Message-ID: <1346E68D3A5B2043907CF4BF466383411A080EFFAB@ESESSCMS0353.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.ericsson.se (mailgw1.ericsson.se [193.180.251.45])
	by alsa0.perex.cz (Postfix) with ESMTP id 22CF6243BF
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2012 09:51:31 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "clemens@ladisch.de" <clemens@ladisch.de>, "zonque@gmail.com" <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > Hi,
> > 
> > Sorry to mail you directly. But I have tried to mail several times to 
> > the mailing list but I don't get through. Everything checks out fine, 
> > no html etc, other mailing lists work fine, but not alsa devel.
> > Anyway, could you please have a look at this?
> 
> Could you resend the patch but just add me, Clemens and Daniel to Cc, so that it reaches to main developers for usb-audio?  Even if we take your patch as is, it'd be needed to be applicable via git-am.
> 
> 
> thanks,
> 
> Takashi

Hi.

I noticied that volume quirks in usb-audio did not get applied.
This is because kctl->id.name gets built properly _after_ calling the quirk adjustments.
My solution is a bit ugly, but check_mapped_dB needs the adjustment before getting called.
I split the call over the switch. If someone feels like writing something cleaner, please feel free.
This works for me atleast.

Regards,
Christian Melki

Signed-off-by: Christian Melki <christian.melki@ericsson.se>
---

diff -urN linux-3.3.2.orig/sound/usb/mixer.c linux-3.3.2/sound/usb/mixer.c
--- linux-3.3.2.orig//sound/usb/mixer.c	2012-04-30 09:08:29.000000000 +0200
+++ linux-3.3.2/sound/usb/mixer.c	2012-04-30 09:46:28.000000000 +0200
@@ -1121,9 +1121,6 @@
 		len = snd_usb_copy_string_desc(state, nameid,
 				kctl->id.name, sizeof(kctl->id.name));
 
-	/* get min/max values */
-	get_min_max_with_quirks(cval, 0, kctl);
-
 	switch (control) {
 	case UAC_FU_MUTE:
 	case UAC_FU_VOLUME:
@@ -1155,6 +1152,7 @@
 		}
 		append_ctl_name(kctl, control == UAC_FU_MUTE ?
 				" Switch" : " Volume");
+		get_min_max_with_quirks(cval, 0, kctl);
 		if (control == UAC_FU_VOLUME) {
 			check_mapped_dB(map, cval);
 			if (cval->dBmin < cval->dBmax || !cval->initialized) {
@@ -1170,6 +1168,7 @@
 		if (! len)
 			strlcpy(kctl->id.name, audio_feature_info[control-1].name,
 				sizeof(kctl->id.name));
+		get_min_max_with_quirks(cval, 0, kctl);
 		break;
 	}
 
