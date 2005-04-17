From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001059]: dsx_support and APIC interaction
Date: Sun, 17 Apr 2005 21:44:46 +0200
Message-ID: <a7c0ee91b52af707f747611cd2da3543@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2BB391E4
	for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2005 21:44:46 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1059> 
======================================================================
Reported By:                systemloc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1059
Category:                   PCI - via82xx
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0
Kernel Version:             2.6.7
======================================================================
Date Submitted:             04-17-2005 20:41 CEST
Last Modified:              04-17-2005 21:44 CEST
======================================================================
Summary:                    dsx_support and APIC interaction
Description: 
I was using the 2.6.7 kernel without APIC or ACPI support, and the via82xx

driver worked perfectly, compiled as a module, without any options. I
built a 
new 2.6.7 kernel on the same hardware with APIC and ACPI support in the 
kernel, as the board supports it, and the driver did not work correctly.
When 
sound was played, a short, 1 second long bit of the sound to be played was

looped. Possibly this is the clicking noise described by some people? The

driver works fine with this new kernel after adding the option 
"dxs_support=1". I hope this interaction with ACPI and APIC sheds some
light 
on some of the troubles with this driver. I can provide more information
if 
anyone wants it. Please CC me, I'm not on the list.

TJ


======================================================================

----------------------------------------------------------------------
 systemloc - 04-17-05 20:42 
----------------------------------------------------------------------
I recieved this feedback from: Sergey Vlasov <vsu@altlinux.ru>

On Sun, 17 Apr 2005 12:53:24 -0400 TJ wrote:

> I was using the 2.6.7 kernel without APIC or ACPI support, and the
via82xx
> driver worked perfectly, compiled as a module, without any options. I
built a
> new 2.6.7 kernel on the same hardware with APIC and ACPI support in the
> kernel, as the board supports it, and the driver did not work
correctly.

2.6.7 is pretty old; there were many bugfixes in both ACPI and sound
drivers since that time.

> When sound was played, a short, 1 second long bit of the sound to be
> played was looped. Possibly this is the clicking noise described by
> some people?

Does not look like it.  The most common cause of looping sound are
interrupt problems, and unfortunately ACPI (especially when coupled
with APIC support) often triggers them (sometimes because of bugs in
the kernel ACPI support, sometimes because a buggy BIOS supplies
broken data).

If interrupts are not working, usually this happens:

- The driver sets up a circular buffer which contains the first
  portion of sound samples to be played, and starts the playback
  hardware.

- The sound card reads the samples from the buffer; when it reaches
  some point in the buffer, it sends the interrupt signal, notifying
  the driver about it.

- Normally, when the driver handles the interrupt, it will place more
  sound data in the circular buffer (or, in the mmap mode, it will
  notify the application, which will write to the buffer directly).
  However, if interrupts are not working, the driver will never get
  such notification, and the same portion of sound samples will stay
  in the buffer forever.  The sound card does not know that the buffer
  was not updated and will play that piece of sound forever.

Another symptom of not working interrupts is that aplay just hangs
forever (aplay -vv should draw a histogram of played data).

> The driver works fine with this new kernel after adding the option
> "dxs_support=1".

This is very strange - the dxs_support option should not cause such
changes.  Usually the problem caused by a wrong dxs_support value is
that sound is basically there, but distorted.

Also, seems that dxs_support=1 should not work at all (at least in
theory).  dxs_support=4 seems to be more correct; latest code in ALSA
CVS supports dxs_support=5, which uses more capabilities of the
hardware (apparently the VIA VT8233/5/7 chips are able to perform
sample rate conversion from arbitrary rates to 48000 Hz with 4
independent channels).

> I hope this interaction with ACPI and APIC sheds some light on some
> of the troubles with this driver.

Most likely you have some trouble with ACPI (either with the buggy
implementation in 2.6.7, or with the buggy BIOS, or maybe both).

> I can provide more information if
> anyone wants it. Please CC me, I'm not on the list.
> 
> TJ
> 
> Motherboard: MSI K7T266 Pro2
> 
> 00:11.5 Class 0401: 1106:3059 (rev 10)

Hmm, seems to be some old chip revision:

#define VIA_REV_PRE_8233        0x10    /* not in market */

>         Subsystem: 4005:4710

Not in the known devices list of snd-via82xx (this list contains
working values of the dxs_support option for known boards).  But you
should report it to ALSA developers (e.g., in their bug tracking
system, https://bugtrack.alsa-project.org/alsa-bug/ ) - your message
to LKML will likely be lost.

----------------------------------------------------------------------
 systemloc - 04-17-05 21:44 
----------------------------------------------------------------------
After upgrading to kernel version 2.6.11.7 with the same options, APIC/ACPI
enabled, the via82xx driver worked correctly without any dxs_support
options enabled. I'm guessing this may have been a bug with APIC or
something, which was already fixed, as suggested by Sergey Vlasov.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-05 20:41 systemloc      New Issue                                    
04-17-05 20:41 systemloc      Distribution              => Slackware 10.0  
04-17-05 20:41 systemloc      Kernel Version            => 2.6.7           
04-17-05 20:42 systemloc      Note Added: 0004510                          
04-17-05 21:44 systemloc      Note Added: 0004511                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
