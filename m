From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: questions about usbmidi
Date: Thu, 10 Apr 2003 12:47:23 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304101132150.14279-100000@studcom.urz.uni-halle.de>
References: <3E951D6D.2040304@drehmoment.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3E951D6D.2040304@drehmoment.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Rabe <raven@drehmoment.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Rabe wrote:
> Clemens Ladisch wrote:
> > Thomas Rabe wrote:
> >>i don't really know if autodetection will work (for the lsusb see
> >>below).
> >
> > All endpoints are in one interface, so it wouldn't work.
>
> will i have more luck with snd_usbmidi_create_rawmidi?

It's only the autodetection that wouldn't work. Using
snd_usb_create_midi_interface with endpoint 0x06 should work just fine.

> > Well, this may indicate that the MIDI part works and that the error is in
> > some other part of the driver. Does the oops still happen when you don't
> > call snd_usb_create_midi_interface?
>
> the driver works fine without calling snd_usb_create_midi_interface (no
> errors, all audiochannels are available).

The initialization code does nothing USB-related except allocing some URBs
and submitting the input URBs. Please try to remove the call to
snd_usbmidi_submit_urb at the end of _create_midi_interface.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
