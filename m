From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002218]: Everything ok but no sound.
Date: Tue, 20 Jun 2006 22:50:26 +0200
Message-ID: <780227ff8f99ce26c7b8dba96376fd9e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1F0B618C
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 22:50:27 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2218> 
======================================================================
Reported By:                Layn
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2218
Category:                   PCI - hda-intel
Reproducibility:            unable to duplicate
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.16
======================================================================
Date Submitted:             06-18-2006 16:55 CEST
Last Modified:              06-20-2006 22:50 CEST
======================================================================
Summary:                    Everything ok but no sound.
Description: 
I have installed the lasted driver for my soundcard from hg, also i have
try with ubuntu dapper beta live-cd and finally i have the stable 1.0.11
driver, lib and utils from alsa repository.
Everything look fine, with alsamixer the pcm volume is in 100%, but there
isnt sound, i have probe with mpg123, mplayer and aplay, and never play
anything. No error, nothing...
======================================================================

----------------------------------------------------------------------
 tiwai - 06-20-06 19:54 
----------------------------------------------------------------------
Make sure that model option was really passed, e.g. see
/sys/module/xxx/parameter/* files.
When the option is set in modprobe.conf, the command line option seems
ignored (possibly depending on the module-init-tools version or the system
setup).

----------------------------------------------------------------------
 jlpedrosa - 06-20-06 22:50 
----------------------------------------------------------------------
tiwai:

I don't know but maybe it's the same that 2035?

here's my lspci -v:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Uniwill Computer Corp Unknown device 9072
        Flags: bus master, fast devsel, latency 0, IRQ 137
        Memory at fe0f8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0

my kernel version is the one fom suse 10.1 (32bit)(2.6.16.13-4)... the
only thing different is that thing with the IRQ, now i booted with
acpi=off just for trying but it didn't change anything.

it happens exactly the same to me.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 16:55 Layn           New Issue                                    
06-18-06 16:55 Layn           Distribution              => Debian          
06-18-06 16:55 Layn           Kernel Version            => 2.6.16          
06-20-06 19:54 tiwai          Note Added: 0010351                          
06-20-06 22:50 jlpedrosa      Note Added: 0010355                          
======================================================================
