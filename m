From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000209]: Sometimes XMMS stop playing songs (dmix used)
Date: Sun, 28 Nov 2004 18:33:28 +0100
Message-ID: <1dc024a77c82e73188507c6e696691e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1E899243
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 18:33:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=209> 
======================================================================
Reported By:                srr
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   209
Category:                   
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-14-2004 11:41 CEST
Last Modified:              11-28-2004 18:33 CET
======================================================================
Summary:                    Sometimes XMMS stop playing songs (dmix used)
Description: 
Sometimes XMMS stop playing songs and show message that says "Audio device
not
properly configured or busy". It happends when new song just start
playing. If I click on Play button, songs continued playing. 

I can't repeat this bug, it happends 3-5 times in day.

If i start mpg123 and xmms they are play simultaniously (even if i start
10
copies of mpg123)

This is output from xmms:

ALSA lib pcm_hw.c:1057:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed:
Device
or resource busy
ALSA lib pcm_dmix.c:868:(snd_pcm_dmix_open) unable to open slave
 
** WARNING **: alsa_setup(): Failed to open pcm device (default): Device
or
resource busy


======================================================================

----------------------------------------------------------------------
 martin - 10-20-04 20:42 
----------------------------------------------------------------------
Yes, there is some mmap bug. But in my case it happens only in case of
conversion. If I'm playing a file in a format that isn't supported by my
rme32 hardware (e.g. mono) it will hang and the prompt doesn't came back
(infinite loop?). Formats that are supported by the hardware are running
fine.

This happens with aplay, so it's not related to xmms.
The rme32 in halfduplex-mode works with mmap and that's the reason why I
believe it's the same bug.

----------------------------------------------------------------------
 martin - 11-28-04 18:33 
----------------------------------------------------------------------
At least my rme32 problems are fixed in CVS. (see also bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=611 for a
patch)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-04 11:41 srr            New Issue                                    
04-16-04 11:54 tiwai          Note Added: 0000832                          
04-20-04 07:39 srr            Note Added: 0000869                          
04-20-04 07:41 srr            Issue Monitored: srr                         
10-14-04 22:40 chtephan       Note Added: 0002160                          
10-20-04 20:42 martin         Note Added: 0002218                          
11-28-04 18:33 martin         Note Added: 0002626                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
