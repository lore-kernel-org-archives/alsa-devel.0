From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001593]: au88x0 wt synth
Date: Sat, 29 Apr 2006 15:50:31 +0200
Message-ID: <911a9fc4e237874ad95899cb16fd8f39@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 63EF9193
	for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2006 15:50:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1593> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1593
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             11-23-2005 17:16 CET
Last Modified:              04-29-2006 15:50 CEST
======================================================================
Summary:                    au88x0 wt synth
Description: 
After applied the patch as described in 

http://article.gmane.org/gmane.linux.alsa.devel/27095

Sound (like a monster roaring) is heard when using aplay through device 3
of au8830 with the mono files from alsa-utils-1.0.10/speaker-test/samples

The sound repeat 7 times and stop.

Refer to the strace, 

Do the DMA transfer occur when using hw:0,3 ?



======================================================================

----------------------------------------------------------------------
 Raymond - 03-29-06 17:55 
----------------------------------------------------------------------
I upload the spectrum of the sound generated when playing mono through
device 3.

----------------------------------------------------------------------
 Raymond - 04-29-06 15:50 
----------------------------------------------------------------------
alsa-lib-1.0.11/test/timer class=2
Using timer class 2, slave class -1, card 0, device 0, subdevice 0
Timer info:
  slave = no
  card = 0
  id = 'AU8830'
  name = 'AU8830 timer'
  average resolution = 20833
Using 960 tick(s)
STATUS:
  resolution = 20833
  lost = 0
  overrun = 0
  queue = 0
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960
STATUS:
  resolution = 20833
  lost = 0
  overrun = 0
  queue = 0
Done



dmesg

vortex time = 0eee8e8b   period = 3c0  timer->sticks=3c0
vortex time = 0eee8f90 diff = 00000105  <------------
vortex time = 0ef24fb8 diff = 0003c028
vortex time = 0ef61092 diff = 0003c0da
vortex time = 0ef9d1a7 diff = 0003c115
vortex time = 0efd929b diff = 0003c0f4
vortex time = 0f01538d diff = 0003c0f2
vortex time = 0f0514a6 diff = 0003c119
vortex time = 0f08d5a8 diff = 0003c102
vortex time = 0f0c96a8 diff = 0003c100
vortex time = 0f10578b diff = 0003c0e3
vortex time = 0f1418b2 diff = 0003c127
vortex time = 0f17d9a1 diff = 0003c0ef
vortex time = 0f1b9aa5 diff = 0003c104
vortex time = 0f1f5b94 diff = 0003c0ef
vortex time = 0f231c9f diff = 0003c10b
vortex time = 0f26dd8c diff = 0003c0ed
vortex time = 0f2a9ea0 diff = 0003c114
vortex time = 0f2e5f8d diff = 0003c0ed
vortex time = 0f3220ca diff = 0003c13d
vortex time = 0f35e1a9 diff = 0003c0df
vortex time = 0f39a2ce diff = 0003c125
vortex time = 0f3d63a5 diff = 0003c0d7
vortex time = 0f4124ab diff = 0003c106
vortex time = 0f44e5af diff = 0003c104
vortex time = 0f48a6a8 diff = 0003c0f9
vortex time = 0f4c67b4 diff = 0003c10c
vortex time = 0f5028bf diff = 0003c10b
vortex time = 0f53e9b3 diff = 0003c0f4
vortex time = 0f57aabb diff = 0003c108

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-05 17:16 Raymond        New Issue                                    
11-23-05 17:16 Raymond        Distribution              => Fedora Core 1   
11-23-05 17:16 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
11-23-05 20:54 mjander        Note Added: 0006832                          
11-25-05 07:57 Raymond        Note Added: 0006847                          
11-30-05 08:48 Raymond        Note Added: 0006875                          
12-11-05 13:21 Raymond        Note Added: 0006976                          
12-21-05 10:10 Raymond        Note Added: 0007108                          
01-02-06 09:06 Raymond        Note Deleted: 0006976                        
01-02-06 09:54 Raymond        Note Added: 0007369                          
02-26-06 18:08 Raymond        Note Deleted: 0007369                        
02-26-06 18:09 Raymond        Note Deleted: 0006875                        
02-26-06 18:10 Raymond        Note Deleted: 0006847                        
03-24-06 04:53 Raymond        File Added: spectrum.png                     
03-29-06 17:55 Raymond        Note Added: 0008996                          
04-29-06 15:50 Raymond        Note Added: 0009543                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
