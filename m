From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: questions about usbmidi
Date: Thu, 10 Apr 2003 17:38:53 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304101733100.4735-100000@studcom.urz.uni-halle.de>
References: <3E9581DB.7060404@drehmoment.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3E9581DB.7060404@drehmoment.org>
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
> > The initialization code does nothing USB-related except allocing some URBs
> > and submitting the input URBs. Please try to remove the call to
> > snd_usbmidi_submit_urb at the end of _create_midi_interface.
>
> removing the snd_usbmidi_submit_urb call also oopses. i tried some
> endpoint configs like below but each crashing my machine:
> ...
> .data = & (const snd_usb_midi_endpoint_info_t) {
> 		 }
>
> last msg:
> created 0 output and 0 input ports

So the oops isn't related to USB at all.

The first thing after outputting "created ... ports" is the line:

	list_add(&umidi->list, &umidi->chip->midi_list);

It may be possible that your US428 driver doesn't initialize
chip->midi_list. This may indicate that you didn't merge all the changes
made to usbaudio.c.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
