From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: rmmod snd-es1968 crashes my laptop...
Date: Tue, 15 Jun 2004 00:50:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406150051.00056.annabellesgarden@yahoo.de>
References: <200406132023.48894.annabellesgarden@yahoo.de> <s5hsmcydzrn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmcydzrn.wl@alsa2.suse.de>
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

Am Montag 14 Juni 2004 15:39 schrieb Takashi Iwai:
> At Sun, 13 Jun 2004 20:23:48 +0200,
>
> Karsten Wiese wrote:
> > ...if the us428 is running.
> > the us428 (via uhci module) uses exactly the same irq 5 as the snd-es1968
> > here.
> > If the us428 is deactivated, that is there are only snd-es1968 related
> > interrupts on irq5, "rmmod snd-es1968" is ok.
> >
> > This prevents the crash here (2.4.26 kernel, planet CCRMA fc1):
> >
> > --- alsa-kernel/pci/es1968.c	3 May 2004 17:34:48 -0000	1.66
> > +++ alsa-kernel/pci/es1968.c	13 Jun 2004 17:01:32 -0000
> > @@ -2477,7 +2477,7 @@
> >  		kfree_nocheck(chip->res_joystick);
> >  	}
> >  #endif
> > -	snd_es1968_set_acpi(chip, ACPI_D3);
> > +	//snd_es1968_set_acpi(chip, ACPI_D3);
> >  	chip->master_switch = NULL;
> >  	chip->master_volume = NULL;
> >  	if (chip->res_io_port) {
> > <<<<<<
> >
> > I don't know, if this is the correct solution.
> > Let me know, if you need more details or tests.
>
> I also don't know whether it's correct :)
> ESS chip is always in tons of mystery.
>
> Does the driver work if you reload the module again?

Yes.

> How about suspend/resume?

"apmsleep --suspend +1:00" is OK! 
At least the devices (Maestro2 & us428) are fully functional after wakeup.
I made shure by inserting snd_printd in  es1968_resume & es1968_suspend t5hat 
those are called in the process.
the us428 gets restarted by hotplug, I guess.
The apps I tested (Ecasound & KDE's artsd) didn't survive though.

This patch keeps the "snd_es1968_set_acpi(chip, ACPI_D3);":

>>>>>>
Index: es1968.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/es1968.c,v
retrieving revision 1.66
diff -u -r1.66 es1968.c
--- es1968.c	3 May 2004 17:34:48 -0000	1.66
+++ es1968.c	14 Jun 2004 22:15:20 -0000
@@ -2477,7 +2477,6 @@
 		kfree_nocheck(chip->res_joystick);
 	}
 #endif
-	snd_es1968_set_acpi(chip, ACPI_D3);
 	chip->master_switch = NULL;
 	chip->master_volume = NULL;
 	if (chip->res_io_port) {
@@ -2486,6 +2485,7 @@
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
+	snd_es1968_set_acpi(chip, ACPI_D3);
 	snd_magic_kfree(chip);
 	return 0;
 }
<<<<<<

I think its OK to commit with comment:

	- Prevent shared Interrupts from other devices
	  causing crash on device free.

(Analysis:
the crash was induced when the usb interrupt was still reached to 
snd_es1968_interrupt:
the value "event = inb(chip->io_port + 0x1A)" will possibly be != 0 cause the 
device went into high Z state, so snd_es1968_interrupt falsely tries to 
handle the alien interrupt....
by telling kernel that the module doesn't handle interrupts any more before 
switching the device into powersave mode we keep the system sane.
or so....)

thanks,
Karsten



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
