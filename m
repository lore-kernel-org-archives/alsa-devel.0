From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: buffer_size and period_size
Date: Mon, 27 Jan 2003 11:16:28 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEHEBDAB.mknecht@controlnet.com>
References: <20030127181707.8561D3EF7F@vivaldi.controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030127181707.8561D3EF7F@vivaldi.controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Paul Davis [mailto:paul@linuxaudiosystems.com]
> Sent: Monday, January 27, 2003 10:39 AM
> To: Mark Knecht
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] buffer_size and period_size
>
>
> >Paul,
> >   So with -p 64 -n 2 settings, what number of bytes of audio data is
> >transferred across the PCI bus between each interrupt?
>
> the period size is always (as with almost all ALSA metrics) in units
> of audio frames (1 sample for each channel). so with JACK running at
> -p 64, 64 frames of data are transferred. how many bytes that is
> depends on the sample width and the number of channels.

Cool, so this says my RME HSDP puts out 26 samples 64 times, and then
signals with an interrupt, while my Hammerfall Light puts out 18 samples 64
times?  If true, then both cards interrupt at the same rate, but the HDSP
9652 uses more PCI bandwidth. (26/18)

Presumably each sample uses 24-bits of audio data, packed in a 32-bit
hardware DWORD moving across the PCI bus? This would be clean and easy for
software to deal with. If true, then the number of bytes would be 4
bytes/channel * 26 channels * 64 frames = 6656 bytes across the PCI bus
between interrupts. (Or desire to interrupt, not necessarily interrupt
services.)


>
> >   Also, does the number of bytes transferred change based on how many
> >channels are enabled? Or does my RME always transfer 26 channels of data
> >even if I am not using some channels?
>
> its hardware dependent. for the RME, the same amount is always moved,
> regardless of how many channels are enabled. in the case of the RME
> Hammerfall series, its more accurate to say that you cannot change the
> number of channels enabled. this is not true of all other hardware.

Sure. Sensible. They just always send 26 channels of data. The loading on
the PCI bus is therefore independent of how many channels I'm actually
using.

>
> >   I am assuming that a card like the RME is a bus master, moves so many
> >bytes, and then interrupts to tell the system that the bytes are
> there. Is
> >this basically the case?
>
> yes. keep in mind that this only covers 1 direction: the interrupt
> also tells the system that its possible to put data into the "hardware
> buffer".

Good point. Thanks!



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
