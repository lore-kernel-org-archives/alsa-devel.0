From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000644]: CMI8738 - Line-in as bass conflicts with line-as rear.
Date: Fri, 12 Nov 2004 00:09:59 +0100
Message-ID: <0d3910e287c627392d2a3c797d233d4b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0313B26B
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 00:09:59 +0100 (MET)
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
Last Modified:              11-12-2004 00:09 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-04 00:09 jborges        New Issue                                    
11-12-04 00:09 jborges        File Added: sound-cm8738-alsamixergui.png         
          
11-12-04 00:09 jborges        Distribution              => Kurumin 3.2 (a
Brazilian flavor of Knoppix) with kde 3.2.3
11-12-04 00:09 jborges        Kernel Version            => Kernel 2.4.25-klg
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
