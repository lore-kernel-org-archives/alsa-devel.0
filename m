From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: Re: [PATCH] ALSA: usb-midi: fix a memory leak bug
Date: Wed, 7 Aug 2019 01:37:58 -0400
Message-ID: <CAAa=b7cOAONyFVd=s19d+00gb9_CtECP59ZR_sc6z4z=BOVjEA@mail.gmail.com>
References: <CAAa=b7ebEkQZhPCbJPK=dVC+cR8_pTE3OOxX+PV+MNx7-Y25Cw@mail.gmail.com>
 <s5hef1xo81o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hef1xo81o.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>, Wenwen Wang <wenwen@cs.uga.edu>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 7, 2019 at 1:31 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 07 Aug 2019 05:22:09 +0200,
> Wenwen Wang wrote:
> >
> > In __snd_usbmidi_create(), a MIDI streaming interface structure is
> > allocated through kzalloc() and the pointer is saved to 'umidi'. Later on,
> > the endpoint structures are created by invoking
> > snd_usbmidi_create_endpoints_midiman() or snd_usbmidi_create_endpoints(),
> > depending on the type of the audio quirk type. However, if the creation
> > fails, the allocated 'umidi' is not deallocated, leading to a memory leak
> > bug.
> >
> > To fix the above issue, free 'umidi' before returning the error.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
>
> It's again a false-positive report.  The object is released
> automatically by the destructor of its base snd_rawmidi object.

Thanks for your response! Sorry for the false positives. :(

Wenwen
