From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Echoaudio driver hangs on Darla24
Date: Wed, 14 May 2003 10:38:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030514103809.pochini@shiny.it>
References: <200305132126.54463.highenergyparticle@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200305132126.54463.highenergyparticle@attbi.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: HighEnergyParticle <highenergyparticle@attbi.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 14-May-2003 HighEnergyParticle wrote:
> I downloaded ALSA 0.9.3 and echo generic driver and 0.5.10.  Built with gcc
> 3.2.2 on 2.4.20-gentoo kernel.
>
> modprobe snd-echoaudio don't give out any error.
>
> But after start the Emixer, the X-Window went blank. I can kill the X-Window
> with Ctrl-Alt-BS. This is when the Echo Darla24 in a PCI slot that share IRQ
> with Radeon AGP card.
>
> Moved Darla24 to a slot that has it's own IRQ, now start the Emixer would
> completely freeze up the whole system. I had to use the hardware reset button.
>
> I tried with both APIC mode and convention IRQ, disabled ACPI, and PnP OS.
> Still the same thing.

The card generates interrupts only during pcm or midi i/o. If the
mixer makes it crash, the problem must be elsewhere. Try to use amixer
instead of Emixer.  Can you send me related system logs and the output
of "amixer controls" or "amixer contents" ?  Also try to play something
with aplay even if you can't set the volume. I need to locate the broken
code path a bit more precisely than the whole driver :)


Bye.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
