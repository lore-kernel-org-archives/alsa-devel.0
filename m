From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000209]: Sometimes XMMS stop playing songs (dmix used)
Date: Wed, 12 Jan 2005 10:41:06 +0100
Message-ID: <85c2023eba4239186ca254f7bfa7d259@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3691B31B
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 10:41:06 +0100 (MET)
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
Last Modified:              01-12-2005 10:41 CET
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
 martin - 11-28-04 18:33 
----------------------------------------------------------------------
At least my rme32 problems are fixed in CVS. (see also bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=611 for a
patch)

----------------------------------------------------------------------
 leahcim - 01-12-05 10:41 
----------------------------------------------------------------------
I also see this mmap+dmix problem on two machines. Pausing and unpausing
XMMS (rather than restarting the track) is sufficient to make sound output
resume normally. Occasionally all sound-playing processes (ie. aplay,
which I use for all system & mail alert sounds) will log-jam behind any
xmms or aplay process that halts in this way.

ALSA 1.0.6 on kernels 2.6.10-rc3 and 2.6.10, running Debian sarge.
I82801BAICH2 and CMI8738 audio hardware respectively.

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
01-12-05 10:41 leahcim        Note Added: 0003161                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
