From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.6.4
Date: Mon, 21 Jun 2004 10:02:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406210939370.7655-100000@studcom.urz.uni-halle.de>
References: <200406210805.03061.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406210805.03061.annabellesgarden@yahoo.de>
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
> snd-usb-usx2x calls usb-set-interface() to set the sample format.

.. and the USx2y devices use the same interface for MIDI, it seems.

> This lets midi in work after usb-set-interface() on kernel 2.6.7 and doesn't
> disturb otherwise.

> +  if (urb && urb == ep->urb_retry

It's not obvious why urb_retry is needed.  Isn't it always the same
as ep->urb?

> +      && usb_pipe_needs_resubmit(urb->pipe))

Won't this prevent it from working with interrupt pipes on 2.4?

> +  snd_usbmidi_submit_urb(urb, GFP_ATOMIC);

I think we can use GFP_KERNEL here.


I don't like this solution too much, it's just a device-specific
kludge.  A more general solution would be to have two functions
snd_usbmidi_stop/start_input() and calling them before/after changing
the sample format.  (The start function could be used at the end of
snd_usb_create_midi_interface(), too.)

And what should happen to data that is being output when the sample
format is changed?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
