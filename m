From: HighEnergyParticle <highenergyparticle@attbi.com>
Subject: Echoaudio driver hangs on Darla24
Date: Tue, 13 May 2003 21:24:41 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305132122.23955.david.ge@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I downloaded ALSA 0.9.3 and echo generic driver and 0.5.10.  Built with gcc 3.2.2 on 2.4.20-gentoo kernel.

modprobe snd-echoaudio don't give out any error. 

But after start the Emixer, the X-Window went blank. I can kill the X-Window with Ctrl-Alt-BS. This is when the Echo Darla24 in a PCI slot that share IRQ with Radeon AGP card.

Moved Darla24 to a slot that has it's own IRQ, now start the Emixer would completely freeze up the whole system. I had to use the hardware reset button.

I tried with both APIC mode and convention IRQ, disabled ACPI, and PnP OS. Still the same thing.

I'm running a Athlon XP, on KT400 chipset. Tried the built-in Via AC97 codec driver snd-via82xx works fine.

I've sent this email a few days ago before I subscribe. Which is now waiting for aproval. I appologize for duplicate In case that email ever gets posted.

David


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
