From: nick dowell <nickdowell@yahoo.co.uk>
Subject: ADMIN PROBLEM (Re: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI))
Date: Thu, 14 Oct 2004 17:27:14 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041014162714.69040.qmail@web25408.mail.ukl.yahoo.com>
References: <20041014132603.EB3492D0C1@server.perex-int.cz>
Reply-To: nick@nickdowell.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web25408.mail.ukl.yahoo.com (web25408.mail.ukl.yahoo.com [217.12.10.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 4A9BF260
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2004 19:38:17 +0200 (MEST)
In-Reply-To: <20041014132603.EB3492D0C1@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I don't understand how this has happened, but I did
not subscribe to this list.

Please remove me from this list ASAP.

Regards,
Nick


 --- bugtrack@alsa-project.org wrote:=20
>=20
> A BUGNOTE has been added to this bug.
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0425
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Reported By:                rncbc
> Assigned To:                karsten
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Project:                    ALSA - driver
> Bug ID:                     425
> Category:                   USB - usb-usx2y
> Reproducibility:            always
> Severity:                   block
> Priority:                   normal
> Status:                     assigned
> Distribution:               Mandrake 10.0 Official
> Kernel Version:             2.6.8-rc2
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Date Submitted:             08-06-2004 10:53 CEST
> Last Modified:              10-14-2004 15:26 CEST
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Summary:                    usb-usx2y: System lockup
> on PCM device open (OHCI)
> Description:=20
> As of ALSA 1.0.6rc1, the US-x2y PCM device driver
> module exposes a hard
> conflict on OHCI based USB controllers, causing a
> complete system lockup
> -- kernel oops on an interrupt handler -- exactly
> upon starting or
> openning the PCM device for audio playback.=20
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>
----------------------------------------------------------------------
>  rncbc - 08-06-2004 12:16 CEST=20
>
----------------------------------------------------------------------
> Just to add, that this issue does not occur as of
> previous
> alsa-driver-1.0.5a, same platform, kernel or
> hardware. Seems to have been
> introduced on CVS semewhere since mid-July.
> Something about "no sleeping"
> in ALSA's pcm START/STOP callbacks, but no sure.
>=20
>
----------------------------------------------------------------------
>  karsten - 09-23-2004 20:52 CEST=20
>
----------------------------------------------------------------------
> that seams to have something to do with a threaded
> IRQ10?
> Does it also happen with hardirq_preempting off?
> Please geneate oops traces from the 2.6.9-rc2-mmx-Sy
> kernel also.=20
> If those traces also happen in non usx2y-module
> area,
> find out, which snd_*() call triggers the oops.
> Check wether it happens if you disable hyperthreads.
> Erm, did I fail to include some important
> errorchecks after calling
> kernel/usb functions?
> Run with at least ALSA debug options enabled. Other
> kernel debug options
> may help too.
>=20
>
----------------------------------------------------------------------
>  rncbc - 09-24-2004 09:43 CEST=20
>
----------------------------------------------------------------------
> Please note that this problem is not related to the
> voluntary-preempt
> kernel patch nor is SMP/HT related. The machine
> where its beeing exposed
> is a Compaq Presario 2516EA (laptop), P4 2.533GHz
> (UP, no-HT enabled).
>=20
> Also FWIW, it doesn't matter if ACPI is enabled or
> not. The point where
> the kernel oops occurs seems to be always under
> ohci_hcd (see
> hard-screenshot).
>=20
>
----------------------------------------------------------------------
>  rncbc - 09-25-2004 17:18 CEST=20
>
----------------------------------------------------------------------
> Now using 2.6.9-rc2-mm3-S6 (voluntary-preempt).
>=20
> One thing I've noticed, but just related to VP, is
> that while having
> hardirq-preempt=3D1 and
> /proc/irq/10/ohci_hcd/threaded=3D1, the kernel
> doesn't
> crash when opening the PCM hw device (either via
> jackd or aplay). But
> still useless or zombie anyway. It does crash
> however when I unplug my
> US-224 (switch its power down).
>=20
> With hardirq-preempt=3D0 or
> /proc/irq/10/ohci_hcd/threaded=3D0, I get the
> same
> old bad behavior: a kernel oops somewhere on the
> ohci_irq handling,
> almost
> immediately when the PCM device is open (e.g. by
> jackd or aplay). Yet
> another screenshot added here (usx2y-oops4.png).
>=20
>
----------------------------------------------------------------------
>  karsten - 09-26-2004 15:26 CEST=20
>
----------------------------------------------------------------------
> its always dl_done_list().
> Please post unassembly of the oops.
> Look in linux/Documentation/oops-tracing.txt.
> Do:
> $gdb
>
/lib/modules/2.6.9-rc2-mm3-S6/kernel/usb/host/ohci_hcd.ko
> $disassemble dl_done_list
>=20
> Or find out the point up until evrything is still
> ok.
> Calling snd_pcm_open from i.e. jackd's alsa or usx2y
> driver should not
> harm anything as no usb_thingy is triggered, no?
> That like snd_pcm_hw_params_*() should still be ok.
> Most likely things crash in snd_pcm_prepare().
>=20
> Place exit() calls or debug breaks before those
> alsa-lib calls.=20
> Step by step check corresponding snd_usb_usx2y
> functions:
> Place return -EFAULT in those functions before usb
> subsystem calls.
> Ok, erm sounds like complicated?
>=20
> Mmh, there is this CONFIG_KEXEC kernel option.
>
http://marc.theaimsgroup.com/?i=3D<20040915125041.GA15450%20()%20in%20!%2=
0ibm%20!%20com>
> Could help if it already works.
>=20
> Might also set a smaller console font to get more
> screen estate.
> making visible alsa-debug statements being dumped
> immediately before the
> oops.
>=20
> Or get yourself a pcmcia rs232 card.
>=20
> edited on: 09-26-04 15:26
>=20
>
----------------------------------------------------------------------
>  rncbc - 09-26-2004 15:28 CEST=20
>
----------------------------------------------------------------------
> After some netconsole sessions, I have uploaded here
> the respective output
> logs, which would be a bit more intelligible than
> the actual but
> incomplete screenshots.
>=20
> Both traces are from US-224 power up and firmware
> initial loads and then
> the kernel oops that results from issuing just a
> simple aplay -D hw:1
> somefile.wav.
>=20
> netconsole.out.0.txt traces a session with all
> system modules loaded for a
> full functional laptop; netconsole.out.1.txt results
> from a session
> without pcmcia and ohci1394 related stuff loaded
> (and therefore saving
> some irq claims).
>=20
> Hope this eases the search for a solution :)
>=20
>
----------------------------------------------------------------------
>  karsten - 09-26-2004 15:43 CEST=20
>
----------------------------------------------------------------------
> Please update all of alsa-kernel/usb from cvs head.
> "Badness in usb_unlink_urb at
> drivers/usb/core/urb.c:457" should vanish.
> Redo netconsole logs.
>=20
>
----------------------------------------------------------------------
>  rncbc - 09-28-2004 22:02 CEST=20
>
----------------------------------------------------------------------
> Just uploaded netconsole.out.2.txt which is the
> result after updating to
> full ALSA 1.0.7rc1 CVS (full update: alsa-kernel,
> alsa-driver, alsa-lib,
> alsa-oss, alsa-tools, alsa-utils and alsa-firmware).
>=20
> The ohci_hcd oops remains, but the badness on
> usb_unlink_urb has vanished,
> as Karsten predicted.
>=20
> Some other run-time info that someone might find
> useful:
>=20
> --
> # uname -a
>=20
> Linux lambda 2.6.9-rc2-mm3-S6.3
>
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0001
> Sun Sep 26 12:54:30 WEST 2004 i686
>=20
=3D=3D=3D message truncated =3D=3D=3D=20


=09
=09
	=09
___________________________________________________________ALL-NEW Yahoo!=
 Messenger - all new features - even more fun!  http://uk.messenger.yahoo=
.com


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
