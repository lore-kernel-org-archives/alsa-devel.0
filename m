From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000846]: Can't hear sound from one of the surround speaker, while other is working (speakers are functional).
Date: Thu, 10 Mar 2005 03:27:25 +0100
Message-ID: <009e5bfd78f7e7ec8b3cbe7e782b47f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 99DFA1C4
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 03:27:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=846> 
======================================================================
Reported By:                Envel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   846
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             01-24-2005 13:44 CET
Last Modified:              03-10-2005 03:27 CET
======================================================================
Summary:                    Can't hear sound from one of the surround speaker,
while other is working (speakers are functional).
Description: 
With options "Line-In as surround" and "Duplicate front" the right surround
speaker is not working, while others are functional. After uninstalling
ALSA 1.0.8 and installing againg ALSA 1.0.7 with the same mixer
configuration the error is not occures. SoundCard: nForce2 Audio Codec,
Driver: snd-intel8x0, 4 speakers.
p.s. sorry for my English.
======================================================================

----------------------------------------------------------------------
 jor - 03-09-05 19:24 
----------------------------------------------------------------------
Yes, tried new CVS checkout and recompiled the kernel modules. It's working
again.
I guess the "Fix stereo mutes on Surround volume control" CVS diff on
ac97_codec.c does the trick, Many thanks. :)

----------------------------------------------------------------------
 stephenv - 03-10-05 03:27 
----------------------------------------------------------------------
no luck over here:
asus a7n8x-e deluxe
fedora core 3
not sure I built it right.
I did from my home directory as root
mkdir alsa
cd alsa
cvs -q -f -z3 -d  ":pserver:anonymous:@cvs.sourceforge.net:/cvsroot/alsa" 
co -P alsa-driver alsa-kernel alsa-lib

./configure didn't work... something is wrong with the documentation....
so tried
./cvscompile
and
make install
 did this for both alsa-driver and alsa-lib per suggestion, did I need to
do it in a particular order?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-24-05 13:44 Envel          New Issue                                    
01-24-05 13:44 Envel          Kernel Version            => 2.6.8.1         
01-25-05 15:18 tiwai          Note Added: 0003402                          
01-28-05 08:17 ivantheviking  Issue Monitored: ivantheviking                    
01-28-05 08:19 ivantheviking  File Added: asound.state                     
01-28-05 08:20 ivantheviking  File Added: ac97#0-0                         
01-28-05 08:21 ivantheviking  File Added: ac97#0-0+regs                    
01-28-05 08:30 ivantheviking  Note Added: 0003424                          
01-29-05 17:13 ivantheviking  Note Added: 0003438                          
03-01-05 00:03 stephenv       Issue Monitored: stephenv                    
03-01-05 00:06 stephenv       Note Added: 0003752                          
03-02-05 01:19 ivantheviking  Note Edited: 0003438                         
03-04-05 22:53 slammer        Note Added: 0003802                          
03-04-05 22:55 slammer        Issue Monitored: slammer                     
03-07-05 00:12 stephenv       File Added: svs.tar                          
03-08-05 18:43 jor            Issue Monitored: jor                         
03-08-05 19:03 jor            Note Added: 0003816                          
03-09-05 18:43 tiwai          Note Added: 0003834                          
03-09-05 18:43 tiwai          Note Added: 0003835                          
03-09-05 19:24 jor            Note Added: 0003845                          
03-10-05 03:27 stephenv       Note Added: 0003847                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
