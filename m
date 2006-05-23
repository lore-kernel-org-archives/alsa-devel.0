From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002134]: arecord doesn't work in amd x86_64 X2 dual core.
Date: Tue, 23 May 2006 14:39:31 +0200
Message-ID: <c90dec7d4c0f7516b306f090c776b892@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09733170
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 14:39:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2134> 
======================================================================
Reported By:                bolsog
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2134
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-18-2006 13:25 CEST
Last Modified:              05-23-2006 14:39 CEST
======================================================================
Summary:                    arecord doesn't work in amd x86_64 X2 dual core.
Description: 
arecord doen't work on a amd x86_64 X2 dual core.

examples:
arecord -d 10 -c 2 -f S16_LE -r 32000 foo.wav
arecord -d 10 -f S16_LE -r 48000 foo.wav
arecord -d 10 -f S16_LE -r 32000 foo.wav
arecord -d 10 -f S16_LE -r 16000 foo.wav

all examples must be terminated using Ctrl-c and only the 44 byte header
is saved. 

The soundcard is a 
Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio
Controller
(rev a2)

We tested this problem on a similar pc with amd x86_64 single core with
the same
soundcard and all works fine.

aplay works on both pcs without problems!

We tested on Fedora Core 4 (1.0.10) and Fedora Core 5 (1.0.11rc2)

We need recording on this pc, so we appreciate every help. Thanks.
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-22-06 18:52 
----------------------------------------------------------------------
This sounds like an interrupt routing problem.

Does the interrupt count for the soundcard in /proc/interrupts increase
while arecord is running?

----------------------------------------------------------------------
 bolsog - 05-23-06 14:39 
----------------------------------------------------------------------
in /proc/interupts is the interrupt of the soundcard constant:

19:        154        108   IO-APIC-level  NVidia CK804

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-06 13:25 bolsog         New Issue                                    
05-21-06 14:12 Raymond        Note Added: 0009899                          
05-21-06 14:13 Raymond        Note Edited: 0009899                         
05-21-06 14:15 Raymond        Note Edited: 0009899                         
05-22-06 11:57 bolsog         Note Added: 0009907                          
05-22-06 17:47 Raymond        Note Added: 0009917                          
05-22-06 17:53 bolsog         File Added: arecord-L.txt                    
05-22-06 18:52 rlrevell       Note Added: 0009918                          
05-23-06 14:39 bolsog         Note Added: 0009932                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
