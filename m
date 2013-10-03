From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: Re: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame
	checks -- SUCCESS
Date: Thu, 3 Oct 2013 11:25:03 +0100
Message-ID: <1647369.qtCsvN3L35@arial>
References: <1380728990-8443-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plockton.cent.gla.ac.uk (plockton.cent.gla.ac.uk
 [130.209.16.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 84FDD2610B4
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 12:29:43 +0200 (CEST)
In-Reply-To: <1380728990-8443-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, jennifer.macritchie@conservatorio.ch, graham@n-ism.org, "guido.aulisi@gmail.com" <guido.aulisi@gmail.com>
List-Id: alsa-devel@alsa-project.org

I applied the patch by hand to my current source tree (3.10.11) and compile=
d =

the kernel from scratch.

I plugged a MIDI cable between midi in and out on the TASCAM US-122. Using =

QJackCtl, I connected the US-122's MIDI out to fluidsynth, and used amidipl=
ay =

to send play a MIDI file to the US-122.

While the MIDI was playing, I used Audacity to record the audio via the =

US-122's mic inputs holding the mic close to the speakers. After about 10 =

seconds, I rewound audacity and hit record again so that it was both playin=
g =

and recording through the US-122 while the US-122 was also routing MIDI.

This appears to work fine (at 44100Hz sampling; I've not tried any others),=
 and =

I reckon this is a pretty severe test.

Thank you for pushing this patch which seems to resolve the original issue. =

This will be particularly appreciated by many because the US-122, no longer =

supported for Windows I believe, is currently available on eBay for about =
=A330 =

in the UK, and represents an inexpensive way for Linux users to make =

reasonable quality recordings from microphones needing a phantom power sour=
ce.


On Wednesday 02 October 2013 16:49:50 Daniel Mack wrote:
> The frame check in i_usX2Y_urb_complete() and
> i_usX2Y_usbpcm_urb_complete() is bogus and produces false positives as
> described in this LAU thread:
> =

>   http://linuxaudio.org/mailarchive/lau/2013/5/20/200177
> =

> This patch removes the check code entirely.
> =

> Cc: fzu@wemgehoertderstaat.de
> Reported-by: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  sound/usb/usx2y/usbusx2yaudio.c | 22 +++-------------------
>  sound/usb/usx2y/usx2yhwdeppcm.c |  7 +------
>  2 files changed, 4 insertions(+), 25 deletions(-)
> =

> diff --git a/sound/usb/usx2y/usbusx2yaudio.c
> b/sound/usb/usx2y/usbusx2yaudio.c index 63fb521..6234a51 100644
> --- a/sound/usb/usx2y/usbusx2yaudio.c
> +++ b/sound/usb/usx2y/usbusx2yaudio.c
> @@ -299,19 +299,6 @@ static void usX2Y_error_urb_status(struct usX2Ydev
> *usX2Y, usX2Y_clients_stop(usX2Y);
>  }
> =

> -static void usX2Y_error_sequence(struct usX2Ydev *usX2Y,
> -				 struct snd_usX2Y_substream *subs, struct urb *urb)
> -{
> -	snd_printk(KERN_ERR
> -"Sequence Error!(hcd_frame=3D%i ep=3D%i%s;wait=3D%i,frame=3D%i).\n"
> -"Most probably some urb of usb-frame %i is still missing.\n"
> -"Cause could be too long delays in usb-hcd interrupt handling.\n",
> -		   usb_get_current_frame_number(usX2Y->dev),
> -		   subs->endpoint, usb_pipein(urb->pipe) ? "in" : "out",
> -		   usX2Y->wait_iso_frame, urb->start_frame, usX2Y->wait_iso_frame);
> -	usX2Y_clients_stop(usX2Y);
> -}
> -
>  static void i_usX2Y_urb_complete(struct urb *urb)
>  {
>  	struct snd_usX2Y_substream *subs =3D urb->context;
> @@ -328,12 +315,9 @@ static void i_usX2Y_urb_complete(struct urb *urb)
>  		usX2Y_error_urb_status(usX2Y, subs, urb);
>  		return;
>  	}
> -	if (likely((urb->start_frame & 0xFFFF) =3D=3D (usX2Y->wait_iso_frame &
> 0xFFFF))) -		subs->completed_urb =3D urb;
> -	else {
> -		usX2Y_error_sequence(usX2Y, subs, urb);
> -		return;
> -	}
> +
> +	subs->completed_urb =3D urb;
> +
>  	{
>  		struct snd_usX2Y_substream *capsubs =3D
> usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE], *playbacksubs =3D
> usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
> diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c
> b/sound/usb/usx2y/usx2yhwdeppcm.c index f2a1acd..814d0e8 100644
> --- a/sound/usb/usx2y/usx2yhwdeppcm.c
> +++ b/sound/usb/usx2y/usx2yhwdeppcm.c
> @@ -244,13 +244,8 @@ static void i_usX2Y_usbpcm_urb_complete(struct urb
> *urb) usX2Y_error_urb_status(usX2Y, subs, urb);
>  		return;
>  	}
> -	if (likely((urb->start_frame & 0xFFFF) =3D=3D (usX2Y->wait_iso_frame &
> 0xFFFF))) -		subs->completed_urb =3D urb;
> -	else {
> -		usX2Y_error_sequence(usX2Y, subs, urb);
> -		return;
> -	}
> =

> +	subs->completed_urb =3D urb;
>  	capsubs =3D usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE];
>  	capsubs2 =3D usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE + 2];
>  	playbacksubs =3D usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
