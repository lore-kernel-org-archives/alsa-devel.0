From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000727]: segmentation fault when running modprobe & alsaconf, no sound, no mixer on D915GAV
Date: Tue, 21 Dec 2004 03:08:01 +0100
Message-ID: <32584465035f7bd33f72eb4cb5b07fab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 25A45275
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2004 03:08:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=727> 
======================================================================
Reported By:                IMAMUDDIN AKBAR
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   727
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               FEDORA CORE 3
Kernel Version:             2.6.9-1.667
======================================================================
Date Submitted:             12-16-2004 09:09 CET
Last Modified:              12-21-2004 03:08 CET
======================================================================
Summary:                    segmentation fault when running modprobe & alsaconf,
no sound, no mixer on D915GAV
Description: 

i have compiled alsa-driver-1.0.7 alsa-lib-1.0.7 alsa-utils-1.0.7
but thereis still no sound, and nomiser appear when running alsamixer

i use Intel D915GAV with lspci -v:
00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 03)
        Subsystem: Intel Corp.: Unknown device e203
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at ffa3c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

when i run 
# modprobe snd-azx
Segmentation fault
#lsmod
snd_azx                31094  6
snd_pcm_oss            51752  0
snd_mixer_oss          21760  1 snd_pcm_oss
snd_pcm                89860  2 snd_azx,snd_pcm_oss
snd_timer              27524  1 snd_pcm

when i run amixer
no mixer appear on screen

and when i reboot my computer it cannot boot and just hang...
so i have to uninstall all alsa from rescue to boot again.

Help me to make mysound work fine...
 




======================================================================

----------------------------------------------------------------------
 IMAMUDDIN AKBAR - 12-21-04 02:39 
----------------------------------------------------------------------
ok - cvs version that i've donwload is  cvs 12-17-2004
ive download the cvs alsa driver, utils, and lib.

when i run 
#./cvscompile
find: /usr/src/alsacvs2/alsa-driver/alsa-kernel/: No such file or
directory
find: /usr/src/alsacvs2/alsa-driver/alsa-kernel/: No such file or
directory
find: /usr/src/alsacvs2/alsa-driver/alsa-kernel/: No such file or
directory
ln -sf ../alsa-kernel alsa-kernel
ln -sf alsa-kernel sound
ln -sf alsa-kernel/scripts scripts
gcc utils/mod-deps.c -o utils/mod-deps
utils/mod-deps --basedir /usr/src/alsacvs2/alsa-driver/alsa-kernel
--hiddendir /usr/src/alsacvs2/alsa-driver --makeconf > toplevel.config.in
utils/mod-deps --basedir /usr/src/alsacvs2/alsa-driver/alsa-kernel
--hiddendir /usr/src/alsacvs2/alsa-driver --acinclude > acinclude.m4
utils/mod-deps --basedir /usr/src/alsacvs2/alsa-driver/alsa-kernel
--hiddendir /usr/src/alsacvs2/alsa-driver --include >
include/config1.h.in
./cvscompile: line 36: aclocal: command not found
./cvscompile: line 37: autoconf: command not found
./configure --with-debug=full --with-isapnp=yes --with-sequencer=yes
./cvscompile: line 39: ./configure: No such file or directory


so what that is mean?

----------------------------------------------------------------------
 rlrevell - 12-21-04 03:08 
----------------------------------------------------------------------
You need the GNU autotools installed to build from CVS.  Specifically
autoconf and aclocal.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-16-04 09:09 IMAMUDDIN AKBARNew Issue                                    
12-16-04 17:21 tiwai          Status                   new => resolved     
12-16-04 17:21 tiwai          Resolution               open => fixed       
12-16-04 17:21 tiwai          Assigned To               => tiwai           
12-16-04 17:21 tiwai          Note Added: 0002829                          
12-16-04 17:21 tiwai          Assigned To              tiwai =>            
12-17-04 10:36 IMAMUDDIN AKBARDistribution              => FEDORA CORE 3   
12-17-04 10:36 IMAMUDDIN AKBARKernel Version            => 2.6.9-1.667     
12-17-04 10:36 IMAMUDDIN AKBARStatus                   resolved => feedback
12-17-04 10:36 IMAMUDDIN AKBARResolution               fixed => reopened   
12-17-04 10:36 IMAMUDDIN AKBARNote Added: 0002848                          
12-17-04 10:37 IMAMUDDIN AKBARAssigned To               => tiwai           
12-20-04 16:04 tiwai          Note Added: 0002880                          
12-21-04 02:39 IMAMUDDIN AKBARNote Added: 0002894                          
12-21-04 03:08 rlrevell       Note Added: 0002895                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
