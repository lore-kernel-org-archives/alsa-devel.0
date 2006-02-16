From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001807]: Sound playback hangs and loops on first buffer
Date: Thu, 16 Feb 2006 11:07:51 +0100
Message-ID: <1de67cd75364c146d438af115ddd7b0d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3FD9A1D3
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2006 11:07:51 +0100 (MET)
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
Last Modified:              02-16-2006 11:07 CET
======================================================================
Summary:                    Sound playback hangs and loops on first buffer
Description: 
Trying to play any sound or music produces a never ending loop of the first
1/2 second or so.
======================================================================

----------------------------------------------------------------------
 Eugene Seppel - 02-16-06 00:19 
----------------------------------------------------------------------
I have same motherboard and same problems.
So is there any way to make it works?
Alsa from Realtek doesn't compile on 2.6.16-rc3 kernel and i cat't use
anything else.
Thank you!

----------------------------------------------------------------------
 hno - 02-16-06 11:07 
----------------------------------------------------------------------
Yes, position_fix=1 (or 3) fixes the problem.

/etc/modprobe.conf:

options snd-hda-intel position_fix=1


I have some additional notes regarding using Linux on this board posted in
the MSI forum. See <url:http://forum.msi.com.tw/index.php?topic=93296.0>.
Maybe you will find something useful there. Today I have a Fedora Core 5
test 2 + updates install where everything is working except for 3D
acceleration: sound, clock running normal, SMART control/checks of the
harddrives, fan control etc.

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
02-16-06 11:07 hno            Note Added: 0008093                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
