From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.6.4
Date: Mon, 21 Jun 2004 13:21:19 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406211245160.7655-100000@studcom.urz.uni-halle.de>
References: <200406211156.15096.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406211156.15096.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> Am Montag 21 Juni 2004 10:30 schrieb Karsten Wiese:
> > It is impossible to use different interfaces on one usb_device at the same
> > time. Or not?

On other devices, mixer / PCM output / PCM input / MIDI use one
interface each, as mandated by the USB Audio specification.

> > Am Montag 21 Juni 2004 10:02 schrieb Clemens Ladisch:
> > > And what should happen to data that is being output when the sample
> > > format is changed?
> >
> > There was no out midi urb missed so far. It looks as if there is no special
> > handling needed.

The data in the current URB, if there is one, will be silently
dropped.  Won't happen often, I guess.

> +void snd_usbmidi_in_start(struct list_head* p)
> +void snd_usbmidi_in_stop(struct list_head* p)
> +{
> +       umidi = list_entry(p, snd_usb_midi_t, list);

Logically, these functions operate on a usb_midi structure/object, not
on a list entry.  AFAICS current pratice would put the list_entry()
call int the list iteration loop (in the caller of these functions).

>         for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
> -               if (umidi->endpoints[i].in)
> -                       snd_usbmidi_submit_urb(umidi->endpoints[i].in->urb,
> -                                              GFP_KERNEL);
> +               snd_usbmidi_in_start_do(umidi->endpoints[i].in);

... and then the entire loop could be replaced by a call to
snd_usbmidi_in_start().


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
