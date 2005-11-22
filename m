From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001587]: ogg123 when using the OSS interface results in corrupted sound once suspended (even for the next played song)
Date: Tue, 22 Nov 2005 12:53:20 +0100
Message-ID: <323aade7204f8952873a7020435929b4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3BE5F15D
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 12:53:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1587> 
======================================================================
Reported By:                tvignaud
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   1587
Category:                   a typo
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-22-2005 12:53 CET
Last Modified:              11-22-2005 12:53 CET
======================================================================
Summary:                    ogg123 when using the OSS interface results in
corrupted sound once suspended (even for the next played song)
Description: 
ogg123 when using the OSS interface results in corrupted sound (even for
the *next* played song) once resuming the player after it has been
suspended one or two times. The sound is
sizzling/spluttering/sputtering/frizzling (I'm not sure about the right
translation in english) like a radio when it's raining.
It doesn't happen when using the ALSA interface.
It may be an ogg123 bug since it doesn't happen with mpg132.

It's 80% reproductable after one ^Z and totally reproductable after two
suspend (^Z, fg, ^Z, fg).

Hardware is an ATI "IXP400 AC'97 Audio Controller" managed by snd-atiixp
(main PCI ids: 0x1002:0x4370 subids: 0x103c:0x3009) on AMD64.

I'm using ALSA userland tools v1.0.10 and ALSA drivers v1.0.9b

tv@vador ~ $ rpm -q lib64alsa2 alsa-utils $(rpm -qf $(which ogg123))
lib64alsa2-1.0.10-2mdk
alsa-utils-1.0.10-1mdk
vorbis-tools-1.1.1-4mdk

tv@vador ~ $ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.9b.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 12:53 tvignaud       New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
