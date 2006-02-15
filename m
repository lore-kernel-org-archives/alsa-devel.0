From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001807]: Sound playback hangs and loops on first buffer
Date: Thu, 16 Feb 2006 00:19:20 +0100
Message-ID: <474b7a33783f5b6cfbec64b1a61a45eb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0CD9B152
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2006 00:19:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1807> 
======================================================================
Reported By:                hno
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1807
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5 test 2 + relevant updates (kernel,
alsa)
Kernel Version:             2.6.15
======================================================================
Date Submitted:             02-02-2006 00:15 CET
Last Modified:              02-16-2006 00:19 CET
======================================================================
Summary:                    Sound playback hangs and loops on first buffer
Description: 
Trying to play any sound or music produces a never ending loop of the first
1/2 second or so.
======================================================================

----------------------------------------------------------------------
 hno - 02-13-06 15:23 
----------------------------------------------------------------------
2005-11-24 16:00 works (at the checkin of the before mentioned patch)
2005-11-24 17:00 fails to detect the codec. (hda_intel.c 1.32)
2005-11-27 00:00 likewise
2005-12-01 00:00 works again..
2005-12-05 00:00 fails with the hanging loop syndrome
now 2005-12-01 00:00 fails again.. odd. must be doing something wrong my
tests. Restarting.

2006-11-30 00:00 fails with the hanging loop syndrome
2006-11-24 16:00 works
2006-11-29 00:00 fails to detect the codec
2006-11-29 00:00 with hda_intel.c 1.32 backed out works.
2006-11-30 00:00 still fails with the looping sound.. (just to verify my
own steps..)
2006-11-30 00:00 with hda_intel.c reverted to revision 1.31 works


Think I see the problem. The handling of positio_fix=0 (auto) changed from
FIFO to POSBUF in hda_intel.c revision 1.32. Maybe or maybe not
intentional (mentioned with other words in the commit message). module
parameter position_fix=3 (FIFO) works.

The commit message says:

hda_intel.c revision 1.32
date: 2005/11/24 16:03:40;  author: tiwai;  state: Exp;  lines: +8 -29
Summary: hda-intel - Use position buffer as default

- Use the position buffer for obtaining the current DMA position
  as default.  This seems more stable than others.

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/hda/hda_intel.c?r1=1.31&r2=1.33



Trying HEAD. Also works with position_fix=3.

position_fix=1 (none) also works here.


So my system is apparently one which is incompatible with this change of
how to obtain the DMA position, where the earlier used method actually
worked much better..

   1 (none)      works
   2 (POSBUF)    fails  (current default)
   3 (FIFO size) works  (old default, kind of..)

----------------------------------------------------------------------
 Eugene Seppel - 02-16-06 00:19 
----------------------------------------------------------------------
I have same motherboard and same problems.
So is there any way to make it works?
Alsa from Realtek doesn't compile on 2.6.16-rc3 kernel and i cat't use
anything else.
Thank you!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-06 00:15 hno            New Issue                                    
02-02-06 00:15 hno            Distribution              => Fedora Core 5 test 2
+ relevant updates (kernel, alsa)
02-02-06 00:15 hno            Kernel Version            => 2.6.15          
02-02-06 00:40 rlrevell       Note Added: 0007865                          
02-02-06 02:42 hno            Note Added: 0007867                          
02-02-06 03:46 hno            Note Added: 0007868                          
02-02-06 18:41 hno            Note Added: 0007879                          
02-02-06 19:07 rlrevell       Note Added: 0007881                          
02-03-06 02:43 hno            Note Added: 0007885                          
02-03-06 02:54 rlrevell       File Added: 1.0.9-diff                       
02-03-06 02:57 rlrevell       Note Added: 0007886                          
02-03-06 04:03 hno            Note Added: 0007887                          
02-03-06 04:28 rlrevell       Note Added: 0007888                          
02-03-06 04:44 hno            Note Added: 0007889                          
02-03-06 04:57 rlrevell       Note Added: 0007890                          
02-03-06 04:58 hno            File Added:
codec#3-working-to-latestnotworking.diff                    
02-03-06 05:02 hno            Note Added: 0007891                          
02-10-06 02:38 hno            Note Added: 0007980                          
02-10-06 02:51 rlrevell       Note Added: 0007981                          
02-13-06 11:24 hno            Note Added: 0008044                          
02-13-06 12:54 hno            Note Added: 0008045                          
02-13-06 13:15 hno            Note Added: 0008046                          
02-13-06 15:23 hno            Note Added: 0008052                          
02-16-06 00:01 Eugene Seppel  Issue Monitored: Eugene Seppel                    
02-16-06 00:19 Eugene Seppel  Note Added: 0008082                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
