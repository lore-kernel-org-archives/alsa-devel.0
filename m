From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Wed, 1 May 2002 12:06:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001001c1f100$4cab6700$0400a8c0@martijn>
References: <Pine.LNX.4.44.0205010047120.23423-100000@pulse.stendahls.net>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Manush Dodunekov <manush@stendahls.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> The following patch:
>
> http://fett.net/m/alsa/alsa-0.9.0rc1-unitor8.patch
>
> implements a driver for the Emagic Unitor family of multiport MIDI
> interfaces. Only serial connection is supported. You need to rerun the
> autoconf toolchain after applying the patch.
>
> The driver is heavily based on serial-u16550.c, which may be the wrong
> concept. A more correct concept seems to have a generic-serial.c and
> generic-usb.c, which only implement a communication channel. The interface
> drivers could then load&use them and only implement their own
> init/port-select/whatever dialect. Lots of MIDI interfaces come with both
> USB and serial connectors nowadays. Any thoughts on this?

This is nice. What documentation did you use for writing the driver?

I think a driver for interfaces like the unitor should not be in the kernel.
The
standard serial port driver already allows access to the device. Also, using
a kernel driver does not allow using many different serial hardware, right?

A solution could be alter libasound to support non-kernel drivers. Or use
a loopback device in the kernel. Perhaps only supporting the alsa sequencer
is an option.

I am myself still working on a library for MIDI i/o that uses plugins for
device
access and IMHO provides a better interface than alsa rawmidi.

--martijn
