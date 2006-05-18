From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002134]: arecord doesn't work in amd x86_64 X2 dual core.
Date: Thu, 18 May 2006 13:25:51 +0200
Message-ID: <90bef740b4fbecafa0cf9cfb68e6826e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBA2C189
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2006 13:25:51 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              05-18-2006 13:25 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-06 13:25 bolsog         New Issue                                    
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
