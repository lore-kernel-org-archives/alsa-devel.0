From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: questions about usbmidi
Date: Wed, 09 Apr 2003 16:34:00 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304091624500.23768-100000@studcom.urz.uni-halle.de>
References: <3E941991.7080000@drehmoment.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3E941991.7080000@drehmoment.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Rabe <raven@drehmoment.org>
Cc: alsa-devel@lists.sourceforge.net, us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

Thomas Rabe wrote:
> I try to hack a little bit on Karstens tascam-us428 alsa patch and have
> some problems to integrate usbmidi (usbaudio works). in the patch
> (written for alsa rc3?) this was done with:
> [...]
> i changed this to:
> ...
> #if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)

You don't need this #if; the new code doesn't use the sequencer.

> 	.in_ep = 0x86,

This endpoint number must not include the USB_DIR_IN flag. Make this:
	.in_ep = 0x06,

If this is the only endpoint in the interface, you can omit the endpoint
number and let the driver autodetect it.

> is it a good idea to link against usbmidi.o? (the us428 is non standard
> audio/midi device).

Yes, the MIDI interface part of the US428 is mostly standard compliant.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
