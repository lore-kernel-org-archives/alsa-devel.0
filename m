From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000846]: Can't hear sound from one of the surround speaker, while other is working (speakers are functional).
Date: Sat, 19 Mar 2005 18:06:03 +0100
Message-ID: <fe3edb84ffdb22afc628e5e57dfbe2ea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1BEB415C
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 18:06:04 +0100 (MET)
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
Last Modified:              03-19-2005 18:06 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000902 Some channels not working
======================================================================

----------------------------------------------------------------------
 tiwai - 01-25-05 15:18 
----------------------------------------------------------------------
The combination of "Line-In As Surround" and "Duplicate Front" is already
weird.

Attach /etc/asound.state and /proc/asound/card0/codec97#0/* files for
debugging.

----------------------------------------------------------------------
 ivantheviking - 01-28-05 08:30 
----------------------------------------------------------------------
I too have the same problem with my Nvidia CK8 based sound card, and have
uploaded the requested files.
 
I am running Gentoo Linux with 2.6.10 kernel, and alsa 1.0.8
My LFE and Centers are reversed, along with the right rear missing.
Everything surround (that is not the LF and RF) are also alot softer.

I have full 5.1 with 1.0.6 that is in the kernel I am running, except it
is still mixed way too softly.

Thanks!

----------------------------------------------------------------------
 ivantheviking - 03-02-05 01:19 
----------------------------------------------------------------------
One more thing I think I have *found* using speaker test.
Under both 1.0.8 and 1.0.6 the LFE/CENTER and Rear Surround jacks seem to
be swapped.
Oddly enough in 1.0.6 Doom3 has correct surround, while in 1.0.8 it
doesn't work correctly.

Correction : 1.0.6 isn't correct either. I only noticed that I was using
the OSS analog 5.1 from doom3, not the alsa. Even with 1.0.6 alsa surround
doesn't work properly.



----------------------------------------------------------------------
 stephenv - 03-01-05 00:06 
----------------------------------------------------------------------
nforce2 built in sound on an a7n8x-e deluxe motherboard
am also experiencing this issue on 2.6.10. Very frustrating, its a
showstopper on migration from windows to linux. Will attach
/etc/asound.state and /proc/asound/card0/codec97#0/* files tonight.

----------------------------------------------------------------------
 slammer - 03-04-05 22:53 
----------------------------------------------------------------------
I think that my issue report # 902 describes the same problem, although I
have examined that it's the rear socket's channel second not working
regardless of mixer settings. Could anyone check if it's so?

----------------------------------------------------------------------
 jor - 03-08-05 19:03 
----------------------------------------------------------------------
Exact same problem here, right rear surround speaker doesn't work in a 4.0
setup with the "Line-in as Surround" option set.
Works fine with kernel 2.6.10, but 2.6.11 doesn't. Also tried plain alsa
release 1.0.8 and recent checkout from CVS. These also don't work.
asound.state the same in both cases (2.6.10 compared against the others),
also the ac97#0-0+regs only differs in some volume settings. But also
tested it by setting the exact same register settings.

System:
Asus A7N8X-X
Debian Unstable
Kernel 2.6.11-ck1

----------------------------------------------------------------------
 tiwai - 03-09-05 18:43 
----------------------------------------------------------------------
Can you try the latest CVS version?

----------------------------------------------------------------------
 tiwai - 03-09-05 18:43 
----------------------------------------------------------------------
Don't forget to update both alsa-driver and alsa-lib!

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

----------------------------------------------------------------------
 slammer - 03-10-05 11:55 
----------------------------------------------------------------------
Have you read "Compilation from CVS sources" section in alsa-lib/INSTALL
and alsa-driver/INSTALL  ?

----------------------------------------------------------------------
 slammer - 03-10-05 13:17 
----------------------------------------------------------------------
I confirm it too. CVS version fixes my issue reported in 902 so I guess
it's the same bug ;)
Great job guys!

----------------------------------------------------------------------
 stephenv - 03-10-05 18:03 
----------------------------------------------------------------------
I was reading the howto's off the main page, hadn't occured to me that the
INSTALL would contain entirely different instructions. Anyhow, as you can
see, I "did it right" according to the install instruction in INSTALL and
still have the problem. I am running kernel-2.6.10-1.770 for fc3, looks
like this may be the problem as those of you reporting it fixed are
running 2.6.11 of some sort. FC3 hasn't released that yet. I could roll my
own, I know it "shouldn't" break anything, might do that when I can find
the time. I have a wife and family though, and they miss me since I
started this linux thing.

----------------------------------------------------------------------
 slammer - 03-10-05 23:28 
----------------------------------------------------------------------
Yeah. Me too should get life... such things just eat me and digest with
bones. Anyhow I know it's none of my competence but, since this was fixed,
people would really use at least rc version soon.

----------------------------------------------------------------------
 tiwai - 03-16-05 14:49 
----------------------------------------------------------------------
Yes, now 1.0.9rc1 was out.  So, please give it a try.

----------------------------------------------------------------------
 stephenv - 03-16-05 16:41 
----------------------------------------------------------------------
tiwai, Thanks for not closing this out. I will test with rc1 tonight and
let you know my results.

----------------------------------------------------------------------
 jor - 03-19-05 18:06 
----------------------------------------------------------------------
yes, 1.0.9rc1 also works, and I see the patch in 2.6.11.5. So I'm happy
again :)

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
03-10-05 11:55 slammer        Note Added: 0003848                          
03-10-05 13:17 slammer        Note Added: 0003850                          
03-10-05 14:36 tiwai          Relationship added       has duplicate 0000902
03-10-05 18:03 stephenv       Note Added: 0003869                          
03-10-05 23:28 slammer        Note Added: 0003875                          
03-16-05 14:49 tiwai          Note Added: 0003959                          
03-16-05 16:41 stephenv       Note Added: 0003962                          
03-19-05 18:06 jor            Note Added: 0004059                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
