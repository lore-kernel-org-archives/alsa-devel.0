From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bug in intel8x0 joystick/midi ?
Date: Tue, 10 Jun 2003 11:29:16 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306101113450.1810-100000@studcom.urz.uni-halle.de>
References: <33175.24.225.156.130.1055006496.squirrel@webmail.ouroboros-complex.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <33175.24.225.156.130.1055006496.squirrel@webmail.ouroboros-complex.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jfm3@ouroboros-complex.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jfm3@ouroboros-complex.org wrote:
> I have intel8x0 on my mother board. There are headers for a joystick/midi
> port I'd like to use. I look in BIOS and find joystick io=201, midi
> io=330, and midi irq=10. I put this in modules.conf:
>
> options -k snd-intel8x0 index=0 mpu_port=330 joystick_port=201
>
> snd-mpu401-uart gets loaded, but no midi ports appear. I notice in the
> source code to the driver three things.
>
> 3) The setup routine doesn't seem to look for joystick and midi. I don't
> see the word "joystick" or "midi" in dmesg.

The joystick/midi part is handled by a separate logical PCI device
(see the snd_intel8x0_joystick_ids array). Your chipset may not be
listed in there.

> 2) There is no way to tell the driver what irq is the mpu401.

Yes. Currently, the snd-intel8x0 module instructs the mpu401 driver to
use polling, which would actually work. Theoretically. If you'd
disregard some dropped MIDI bytes here and there.

When the MIDI port has already been enabled by the BIOS, you can
simply ignore the buggy stuff in snd-intel8x0 and use the snd-mpu401
driver instead.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
