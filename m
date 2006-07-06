From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] g_midi: New USB MIDI Gadget class
	driver.
Date: Thu, 6 Jul 2006 09:31:40 -0700
Message-ID: <200607060931.41012.david-b@pacbell.net>
References: <44ACA882.7090209@greyinnovation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44ACA882.7090209@greyinnovation.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Ben Williamson <ben.williamson@greyinnovation.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 05 July 2006 11:06 pm, Ben Williamson wrote:

> Included are usb_audio.h and usb_midi.h containing definitions from
> the relevant USB specifications for USB audio and USB MIDI devices.
> The definitions of struct usb_ms_header_descriptor and struct
> usb_ms_endpoint_descriptor are the same as those that appear in
> sound/usb/usbmidi.c, with the intention of that file including
> <linux/usb_midi.h> instead. I have not included that change here.

Make that <linux/usb/midi.h> or maybe <linux/usb/audio.h> ... in
fact, several pending patches move <linux/usb_*.h> files into that
subdirectory, so watch out when this is ready to submit.

Glad to see such a driver.  I won't comment on the MIDI bits, but
quick comments on other parts are below.

- Dave



This still have some debris left over from gadget zero, like mentions
of having two configurations, using endpoint names rather than just
the endpoints, and even comments describing itself as being gadget zero. 
Best to clean that stuff up more; gadget zero did a bunch of stuff
mostly to make sure that APIs get tested, or to work with earlier
versions of the gadget framework, and your driver can be smaller.

I don't think this is a case where usb_ep_alloc_buffer() and friends
are desired ... such buffers are normally not cacheable.

You should have driver code to support high speed controllers, e.g. the
high speed descriptors including the device qualifier.


> +static const struct USB_MIDI_OUT_JACK_DESCRIPTOR(1) jack_out_emb_desc = {

What's with the SHOUTING in a struct name?  Those are nasty macros.
All the struct names should be lowercase.


Note that this attachment got mangled a bit too (STATE_SYSEX_2 line wrapped).


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
