From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000644]: CMI8738 - Line-in as bass conflicts with line-as rear.
Date: Tue, 7 Dec 2004 18:33:45 +0100
Message-ID: <e6721ecebe2df83958bec7f12e7fbb9e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AE92A28B
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 18:33:45 +0100 (MET)
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
Last Modified:              12-07-2004 18:33 CET
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
 jborges - 12-06-04 12:32 
----------------------------------------------------------------------
It seems that I have a different idea about enable. When I say it is not
enable I want to mean that this is a dead control. I can not push the M
key to mute or umute it. Neither it turns off by pushing that key. Another
thing is there is no way to control the volume in these controls. The
columns above their names stay empty all the time. It not possible to move
the colors inside that columns.

Really sorry for the incovenience. It would be more inteligente just to
forget the whole troble. But, I just like to understand what is going on.

Thanks anyway to stay in this strugle with me.

----------------------------------------------------------------------
 tiwai - 12-07-04 18:33 
----------------------------------------------------------------------
Hmm, the constant value is OK.  They have really no values but only
switches.  But non-working switches are of course unexpected problems.

Please attach /proc/asound/card0/cmipci for debugging.
Try to run the following:

amixer set 'Line-In As Bass' off
amixer set 'Line-In As Rear' off

And compare the above proc file.  Any changes?

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
12-06-04 12:32 jborges        Note Added: 0002727                          
12-07-04 18:33 tiwai          Note Added: 0002755                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
