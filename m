From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000644]: CMI8738 - Line-in as bass conflicts with line-as rear.
Date: Thu, 2 Dec 2004 19:25:40 +0100
Message-ID: <117eab6e2ca72d033c92df930ad5484e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 54F73245
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2004 19:25:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=644> 
======================================================================
Reported By:                jborges
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   644
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Kurumin 3.2 (a Brazilian flavor of Knoppix) with kde
3.2.3
Kernel Version:             Kernel 2.4.25-klg
======================================================================
Date Submitted:             11-12-2004 00:09 CET
Last Modified:              12-02-2004 19:25 CET
======================================================================
Summary:                    CMI8738 - Line-in as bass conflicts with line-as
rear.
Description: 
I'm using Kurumin 3.2 (a Brazilian flavor of Knoppix) in a ASUS P4B533 with
CMI8738 sound chip, processor is Pentium IV 3.0 GHz, 512 RAM and 120
Maxtor Ultra Dma Hard Disk.

Also I use Kde 3.2.3 on Kernel 2.4.25-klg.

This Linux installation works in a dual-boot with windows xp.

The sound works fine (all 6 channels respond very well)under windows xp or
98.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Trying to configure my sound to work I noticed some problems with
alsamixer:

1 - As I can see, there is a conflict for the output. I can't see Line-In
been used to output as bass and the same Line-In used to output as rear
(L/R).

2 - I think Line-In would be used to output as Rear (L/R) and Mic to
output as Bass/Center.

What is happening is that: when one uses a 6 channel system there is no
sound in the conflicted Line-In as bass and Mic as center. The little
sound that goes there is squeezed from Line-In as rear. The sound in bass
and center is full of noise. Impossible to listen.

I took some snapshots (2) to show you what I'm talking about. Please take
a look on them in the attached files.

Julio Borges
Rio de Janeiro - Brazil
======================================================================

----------------------------------------------------------------------
 jborges - 11-28-04 10:51 
----------------------------------------------------------------------
I seems that I made a mistake in my last reply. I wrote something and
attached a new picture. The picture is there but nothing went togheter.
Maybe I forgot to push the add note button. Sorry about that.
What I wanted to tell you is: in the new picture you can see more clearly
that line-in as bass and line-in as rear are not enabled. There is no bars
on them and neither the doted lines above the empty bars. The samething
happen with 3d control and mic as.

Again, sorry.

----------------------------------------------------------------------
 tiwai - 12-02-04 19:25 
----------------------------------------------------------------------
Both are enabled in the new pictures indeed, too.
You'll see 'MM' on the top of volume bar and '[Off]' in the item name when
the switch is disabled.  Try to push 'M' key on the corresponding volume.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-04 00:09 jborges        New Issue                                    
11-12-04 00:09 jborges        File Added: sound-cm8738-alsamixergui.png         
          
11-12-04 00:09 jborges        Distribution              => Kurumin 3.2 (a
Brazilian flavor of Knoppix) with kde 3.2.3
11-12-04 00:09 jborges        Kernel Version            => Kernel 2.4.25-klg
11-18-04 18:16 tiwai          Note Added: 0002455                          
11-18-04 19:04 jborges        Note Added: 0002458                          
11-18-04 19:40 tiwai          Note Added: 0002463                          
11-20-04 23:25 jborges        File Added: sound-cm8738-alsamixer.png            
       
11-28-04 10:51 jborges        Note Added: 0002621                          
12-02-04 19:25 tiwai          Note Added: 0002691                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
