From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000490]:  Choppy sound when playing on Acer TravelMate 2000
Date: Wed, 19 Jan 2005 15:20:18 +0100
Message-ID: <c2b0aa11959d2013923f478a16a2f705@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 34B0B26D
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 15:20:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=490> 
======================================================================
Reported By:                feixm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   490
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               linuxfromscratch, everything compiled from original
sources
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             09-08-2004 21:16 CEST
Last Modified:              01-19-2005 15:20 CET
======================================================================
Summary:                     Choppy sound when playing on Acer TravelMate 2000
Description: 
Hello,

when playing any audio file from my new Acer TravelMate 2000, the sound is
very choppy. I tried playing using xmms, mplayer and others. From lspci I
see, it is an ATI IXP 150. I understand that this bugreport alone won't
help you guys, so if I can give any more info, pls let me know.

When playing movies with mplayer, I see lots of messages like:

alsa-play: xrun of at least 0,131 msecs. resetting stream%  0%  0,0% 1 0
0%
alsa-play: xrun of at least 0,026 msecs. resetting stream 0%  0%  0,0% 7 0
0%

These appear even more where skipping back and forward in the movie.

I found, that playing movies through SDL helps a little, but sound is
still choppy and cannot be listened to.
======================================================================

----------------------------------------------------------------------
 feixm - 01-19-05 15:17 
----------------------------------------------------------------------
Today I recompiled my Alsa-driver installation with latest 1.0.8. Now
mplayer can play movies with no problems for few minutes and then sound
stops for about a second with almost 100 of lines like:

ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
alsa-play: xrun of at least 0,019 msecs. resetting stream
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
alsa-play: xrun of at least 0,016 msecs. resetting stream
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
alsa-play: xrun of at least 0,016 msecs. resetting stream

Last two lines are always something like:

alsa-space: xrun of at least 1,753 msecs. resetting stream
alsa-space: xrun of at least 1,169 msecs. resetting stream

Then it continues to play normally, just after next few minutes exactly
the same thing happens again.

----------------------------------------------------------------------
 tiwai - 01-19-05 15:20 
----------------------------------------------------------------------
Don't forget to install alsa-lib 1.0.8, too (although I guess this won't
fix the problem...)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 21:16 feixm          New Issue                                    
09-08-04 21:16 feixm          Distribution              => linuxfromscratch,
everything compiled from original sources
09-08-04 21:16 feixm          Kernel Version            => 2.6.8.1         
01-18-05 07:56 rounin         Note Added: 0003242                          
01-18-05 07:59 rounin         Issue Monitored: rounin                      
01-18-05 08:09 rounin         Note Added: 0003245                          
01-18-05 11:32 tiwai          Note Added: 0003247                          
01-18-05 21:25 rlrevell       Note Added: 0003260                          
01-18-05 22:47 feixm          Note Added: 0003261                          
01-19-05 15:17 feixm          Note Added: 0003282                          
01-19-05 15:20 tiwai          Note Added: 0003285                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
