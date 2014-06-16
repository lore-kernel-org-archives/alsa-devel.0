From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/3] sound: Add a quirk to enforce period_bytes
Date: Mon, 16 Jun 2014 09:39:17 +0200
Message-ID: <539E9F25.7030504@ladisch.de>
References: <1402762571-6316-1-git-send-email-m.chehab@samsung.com> <1402762571-6316-2-git-send-email-m.chehab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1402762571-6316-2-git-send-email-m.chehab@samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

(CC stable dropped; this is not how to submit stable patches.)

Mauro Carvalho Chehab wrote:
> The Auvitek 0828 chip, used on HVR950Q actually need two
> quirks and not just one.
>
> The first one, already implemented, enforces that it won't have
> channel swaps at the transfers.
>
> However, for TV applications, like xawtv and tvtime, another quirk
> is needed, in order to enforce that, at least 2 URB transfer
> intervals will be needed to fill a buffer.

> +			period =3D 2 * MAX_URBS * fp->maxpacksize;
> +			min_period =3D period * 90 / 100;
> +			max_period =3D period * 110 / 100;

I don't quite understand what you mean with "URB transfer interval".

All USB audio devices transfer packets in intervals between 125 =B5s an=
d
1000 =B5s.

MAX_URBS is a somewhat random value that is not directly derived from
either a hardware or software constraint.

Are you trying to enforce two packets per URB?

Why are you setting both a minimum and a maximum?

Isn't this affected by the constraints of the playback device?

> Without it, buffer underruns happen when trying to syncronize the
> audio input from au0828 and the audio playback at the default audio
> output device.

This looks like a workaround for a userspace bug that would affect all
USB audio devices.  What period/buffer sizes are xawtv/tvtime trying to
use?


Regards,
Clemens
