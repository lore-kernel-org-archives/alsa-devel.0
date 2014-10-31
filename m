From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] usb-audio: Add mixer control for
 Digidesign Mbox 1 clock source
Date: Fri, 31 Oct 2014 13:28:58 +0900
Message-ID: <5453100A.8070602@sakamocchi.jp>
References: <5452EC80.8060005@gmail.com> <54530212.7000804@sakamocchi.jp>
 <545309D8.1020600@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040109030600040905090800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F08326067A
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 05:29:01 +0100 (CET)
In-Reply-To: <545309D8.1020600@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040109030600040905090800
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Damien,

On Oct 31 2014 13:02, Damien Zammit wrote:
> Hi, sorry for the style problems.  See attached for better version.

4 points.

1. please use white-spaces or tabs for indentation to align parameters 
to function-start blacket:

 > +static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
 > +                                       struct snd_ctl_elem_value 
*ucontrol)

 > +static int snd_mbox1_switch_info(struct snd_kcontrol *kcontrol,
 > +                                       struct snd_ctl_elem_info *uinfo)

 > +static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
 > +                                       struct snd_ctl_elem_value 
*ucontrol)

2.please use 'const char *const' for immutable arrays for immutable strings:
 > +       static const char *texts[2] = {"Internal",
 > +                                      "S/PDIF"
 > +       };
 > +

3. I think in your case, snd_ctl_enum_info() is available in struct 
snd_kcontrol_new.info() callback. Please read this thread:
[alsa-devel] [PATCH 00/43] Spread usage of snd_ctl_elem_info()
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082573.html

4. I think 'err' local variable in snd_mbox1_create_sync_switch() can be 
removed because it's assign and evaluated at once:

 > +       err = snd_ctl_add(mixer->chip->card, kctl);
 > +       if (err < 0)
 > +               return err;
 > +
 > +       return 0;

See attached patch.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

--------------040109030600040905090800
Content-Type: text/x-patch;
 name="0001-Comments-for-mbox1-spdif-2.patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Comments-for-mbox1-spdif-2.patch.patch"

>From 6e889e1fc7d7101cfef14484849a412b002798e9 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <mocchi@MocchiSakamoto64.miraclelinux.com>
Date: Fri, 31 Oct 2014 13:17:19 +0900
Subject: [PATCH] Comments for mbox1-spdif-2.patch

See:
[alsa-devel] [PATCH] usb-audio: Add mixer control for Digidesign Mbox 1 clock source
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/083264.html
---
 sound/usb/mixer_quirks.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 6a21dec..87f121f 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -574,7 +574,7 @@ struct snd_mbox1_switch_priv_val {
 };
 
 static int snd_mbox1_switch_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_mbox1_switch_priv_val *pval;
 	unsigned char value;
@@ -597,7 +597,7 @@ static int snd_mbox1_switch_get(struct snd_kcontrol *kctl,
 }
 
 static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_usb_audio *chip;
 	struct snd_mbox1_switch_priv_val *pval;
@@ -692,21 +692,14 @@ static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
 }
 
 static int snd_mbox1_switch_info(struct snd_kcontrol *kcontrol,
-					struct snd_ctl_elem_info *uinfo)
+				 struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[2] = {"Internal",
-				       "S/PDIF"
+	static const char *const texts[2] = {
+		"Internal",
+		"S/PDIF"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);;
 }
 
 static int snd_mbox1_create_sync_switch(struct usb_mixer_interface *mixer)
@@ -722,7 +715,6 @@ static int snd_mbox1_create_sync_switch(struct usb_mixer_interface *mixer)
 		.put = snd_mbox1_switch_put
 	};
 
-	int err;
 	struct snd_kcontrol *kctl;
 	struct snd_mbox1_switch_priv_val *pval;
 
@@ -741,11 +733,7 @@ static int snd_mbox1_create_sync_switch(struct usb_mixer_interface *mixer)
 		return -ENOMEM;
 	}
 
-	err = snd_ctl_add(mixer->chip->card, kctl);
-	if (err < 0)
-		return err;
-
-	return 0;
+	return snd_ctl_add(mixer->chip->card, kctl);
 }
 
 /* Native Instruments device quirks */
-- 
1.9.1


--------------040109030600040905090800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040109030600040905090800--
