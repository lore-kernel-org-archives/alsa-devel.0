From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: Re: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame
	checks
Date: Mon, 7 Oct 2013 17:31:38 +0100
Message-ID: <1836158.zzFflPHOng@arial>
References: <1380728990-8443-1-git-send-email-zonque@gmail.com>
 <s5ha9ildrge.wl%tiwai@suse.de> <5252D48D.5060608@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3277276.nN6QxYhbbe"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plockton.cent.gla.ac.uk (plockton.cent.gla.ac.uk
 [130.209.16.75])
 by alsa0.perex.cz (Postfix) with ESMTP id BCED4265162
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 18:36:24 +0200 (CEST)
In-Reply-To: <5252D48D.5060608@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Guido Aulisi <guido.aulisi@gmail.com>
List-Id: alsa-devel@alsa-project.org

--nextPart3277276.nN6QxYhbbe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 07 October 2013 16:07:28 you wrote:
> OK, then the sequence error thingy is independent from the bogus
> overrun check.  But I guess you still get the errors about "should not
> be here with..." even with the sequence-check-removal patch?
> 
> 
> thanks,
> 
> Takashi

No, because I did the bigger of the two original patches (this is getting 
difficult!!) as per the other email I just sent, so the whole of the function 
usX2Y_error_sequence is gone. So no messages.

I did also build a package I called

	linux-image-3.10.11_3.10.11.TASCAM.1_i386.deb

which had just the change to the

	if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 
0xFFFF)))

(0xFFFF to 0X03FF or whatever). That worked too. I can't remember if there 
were still sequence errors. I've deleted now I'm afraid, having gone for the 
larger version.

The patch that works well for me modifies sound/usb/usx2y/usx2yhwdeppcm.c as 
well, replacing a whole similar if statement at line 244  with the line

	subs->completed_urb = urb;

I got it from the attached email from Daniel.

Nick/.

--nextPart3277276.nN6QxYhbbe
Content-Disposition: attachment; filename="forwarded message"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="forwarded message"

Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: Daniel Mack <zonque@gmail.com>: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame checks

Received: from palin.cent.gla.ac.uk (130.209.34.34) by smtp.campus.gla.ac.uk (130.209.14.19) with Microsoft SMTP Server id 8.3.327.1; Wed, 2 Oct 2013 16:50:03 +0100
Received: from svenfoo.org ([82.94.215.22] helo=mail.zonque.de)	by palin.cent.gla.ac.uk with esmtp (Exim 4.72)	(envelope-from <zonque@gmail.com>)	id 1VROgc-00033f-QQ	for nicholas.bailey@glasgow.ac.uk; Wed, 02 Oct 2013 16:50:03 +0100
Received: from localhost (localhost [127.0.0.1])	by mail.zonque.de (Postfix) with ESMTP id 817F7C1744;	Wed,  2 Oct 2013 17:50:00 +0200 (CEST)
Received: from mail.zonque.de ([127.0.0.1])	by localhost (rambrand.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id Hk6AJ7ax5yMM; Wed,  2 Oct 2013 17:50:00 +0200 (CEST)
Received: from tamtam.taperay.com (unknown [46.115.92.231])	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mail.zonque.de (Postfix) with ESMTPSA id B37B4C1732;	Wed,  2 Oct 2013 17:49:58 +0200 (CEST)
From: Daniel Mack <zonque@gmail.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Nicholas Bailey <Nicholas.Bailey@glasgow.ac.uk>, "guido.aulisi@gmail.com" <guido.aulisi@gmail.com>, Daniel Mack <zonque@gmail.com>, "fzu@wemgehoertderstaat.de" <fzu@wemgehoertderstaat.de>
Date: Wed, 02 Oct 2013 16:49:50 +0100
Subject: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame checks
Thread-Topic: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame checks
Thread-Index: Ac6/hw9nqvIRMxIZQoqDHPQXxXHLkQ==
Message-ID: <1380728990-8443-1-git-send-email-zonque@gmail.com>
Accept-Language: en-GB
Content-Language: en-GB
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: hub01.campus.gla.ac.uk
x-gla-spam-scan: R
x-gla-spam-report: _SUMMARY_
x-gla-spam-score: 0.0 (/)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

The frame check in i_usX2Y_urb_complete() and
i_usX2Y_usbpcm_urb_complete() is bogus and produces false positives as
described in this LAU thread:

  http://linuxaudio.org/mailarchive/lau/2013/5/20/200177

This patch removes the check code entirely.

Cc: fzu@wemgehoertderstaat.de
Reported-by: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/usx2y/usbusx2yaudio.c | 22 +++-------------------
 sound/usb/usx2y/usx2yhwdeppcm.c |  7 +------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudi=
o.c
index 63fb521..6234a51 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -299,19 +299,6 @@ static void usX2Y_error_urb_status(struct usX2Ydev *us=
X2Y,
 	usX2Y_clients_stop(usX2Y);
 }
=20
-static void usX2Y_error_sequence(struct usX2Ydev *usX2Y,
-				 struct snd_usX2Y_substream *subs, struct urb *urb)
-{
-	snd_printk(KERN_ERR
-"Sequence Error!(hcd_frame=3D%i ep=3D%i%s;wait=3D%i,frame=3D%i).\n"
-"Most probably some urb of usb-frame %i is still missing.\n"
-"Cause could be too long delays in usb-hcd interrupt handling.\n",
-		   usb_get_current_frame_number(usX2Y->dev),
-		   subs->endpoint, usb_pipein(urb->pipe) ? "in" : "out",
-		   usX2Y->wait_iso_frame, urb->start_frame, usX2Y->wait_iso_frame);
-	usX2Y_clients_stop(usX2Y);
-}
-
 static void i_usX2Y_urb_complete(struct urb *urb)
 {
 	struct snd_usX2Y_substream *subs =3D urb->context;
@@ -328,12 +315,9 @@ static void i_usX2Y_urb_complete(struct urb *urb)
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((urb->start_frame & 0xFFFF) =3D=3D (usX2Y->wait_iso_frame & 0x=
FFFF)))
-		subs->completed_urb =3D urb;
-	else {
-		usX2Y_error_sequence(usX2Y, subs, urb);
-		return;
-	}
+
+	subs->completed_urb =3D urb;
+
 	{
 		struct snd_usX2Y_substream *capsubs =3D usX2Y->subs[SNDRV_PCM_STREAM_CAP=
TURE],
 			*playbacksubs =3D usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppc=
m.c
index f2a1acd..814d0e8 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -244,13 +244,8 @@ static void i_usX2Y_usbpcm_urb_complete(struct urb *ur=
b)
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((urb->start_frame & 0xFFFF) =3D=3D (usX2Y->wait_iso_frame & 0x=
FFFF)))
-		subs->completed_urb =3D urb;
-	else {
-		usX2Y_error_sequence(usX2Y, subs, urb);
-		return;
-	}
=20
+	subs->completed_urb =3D urb;
 	capsubs =3D usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE];
 	capsubs2 =3D usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE + 2];
 	playbacksubs =3D usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
--=20
1.8.3.1


--nextPart3277276.nN6QxYhbbe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart3277276.nN6QxYhbbe--
