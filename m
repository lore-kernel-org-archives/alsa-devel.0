From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Re: rmmod snd-es1968 crashes my laptop...
Date: Wed, 16 Jun 2004 00:30:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406160030.08458.annabellesgarden@yahoo.de>
References: <200406132023.48894.annabellesgarden@yahoo.de> <200406150051.00056.annabellesgarden@yahoo.de> <s5hwu29axq0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwu29axq0.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Dienstag 15 Juni 2004 13:04 schrieb Takashi Iwai:
> At Tue, 15 Jun 2004 00:50:59 +0200,
>
> Karsten Wiese wrote:
> > Am Montag 14 Juni 2004 15:39 schrieb Takashi Iwai:
> > > At Sun, 13 Jun 2004 20:23:48 +0200,
> >
> > This patch keeps the "snd_es1968_set_acpi(chip, ACPI_D3);":
>
> (snip)
>
> > I think its OK to commit with comment:
> >
> > 	- Prevent shared Interrupts from other devices
> > 	  causing crash on device free.
> >
> > (Analysis:
> > the crash was induced when the usb interrupt was still reached to
> > snd_es1968_interrupt:
> > the value "event = inb(chip->io_port + 0x1A)" will possibly be != 0 cause
> > the device went into high Z state, so snd_es1968_interrupt falsely tries
> > to handle the alien interrupt....
> > by telling kernel that the module doesn't handle interrupts any more
> > before switching the device into powersave mode we keep the system sane.
> > or so....)
>
> Then we should move free_irq() itself before releasing other
> resources.  calling snd_es1968_set_acpi() after release io's is
> invalid.
>
> How about the attached patch?

Agreed. Works fine here.

Karsten


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
