From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] reenable MIDI for usx2y
Date: Wed, 30 Mar 2005 17:22:09 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0503301644400.7928-100000@studcom.urz.uni-halle.de>
References: <s5hzmwlfdd6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmwlfdd6.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: karsten wiese <annabellesgarden@yahoo.de>, "Mr. Devel Alsa" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> karsten wiese wrote:
> > --- Takashi Iwai <tiwai@suse.de> wrote:
> > > karsten wiese wrote:
> > > > usx2y needs to specify exactly what usb-endpoints to
> > > use.
> > > > this feature got lost lately and is restored by
> > > attached
> > > > patch. Please apply!
> > >
> > > IMO, it's better to fix snd_usbmidi_detect_endpoints() to
> > > check
> > > in_ep and out_ep rather than its caller.
> >
> > I'd prefer a new function snd_usbmidi_check_endpoints()
> > then.
> > Caller would call snd_usbmidi_check_endpoints() if
> > ep_out/ep_in would be set by client and would call
> > snd_usbmidi_detect_endpoints() in the other case.
> > How about that?
>
> Hmm, I thought the old code detects in/out endpoints if they are NULL.
> That is, if out_ep == NULL and in_ep != NULL, out_ep is detected but
> in_ep is used as it is.

The old code was designed so that quirks can optionally specify
endpoints.

However, if _any_ endpoint is set, it should be assumed that the quirk
knows what it does, and that no endpoint should be detected
automatically.  (The old code didn't behave in this way.)

> If this isn't the case, checking in the caller side seems OK.

snd_usbmidi_detect_endpoints() is called in several places, and any of
them could theoretically use explicitly specified endpoints.

I've added the check inside the snd_usbmidi_detect_endpoints()
function.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
