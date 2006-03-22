From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000209]: Sometimes XMMS stop playing songs (dmix used)
Date: Wed, 22 Mar 2006 03:06:56 +0100
Message-ID: <5a8262a8406c57b7eab04da201256ead@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 075701A1
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:06:57 +0100 (MET)
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
Last Modified:              03-22-2006 03:06 CET
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
 Steve Fink - 07-21-05 08:21 
----------------------------------------------------------------------
I have a very similar problem with mplayer (mplayer-1.0pre3try2). I set the
default device to go through dmix. After some combination of starting and
stopping mplayers (some of them overlap in time), I will end up with an
mplayer that sits and sleeps for half a second, over and over again.

That kind of sucks, but it's an mplayer problem. My real problem is that
then when I start up the next program that uses ALSA (another mplayer, my
application, aplay, or whatever), it gets the "open /dev/snd/pcmC0D0p
failed: Device or resource busy" error.

If I kill the offending mplayer process, it fixes it.

I am using alsa-driver 1.0.8 and alsa-lib 1.0.8 with the snd-intel8x0
driver. I tried compiling a 1.0.9 (or something calling itself that) and
using it, but I still had the same problem.

Could anyone tell me what sort of thing is happening? I thought that if
everything went through dmix, you should never be able to get into an
EBUSY state. But it seems that the kernel driver is doing something behind
the pcmC?D?p device that can get into this state? (I see similar output
when I have a user play an ALSA sound app, and then try to play something
from the root account. So it does seem like some state is sticking to the
device somehow.) Is there anything that will dump out the state of a
device? Where can I read more about how this all works?

I don't have a simple test script that shows the problem yet. How I
actually see it is that I start up my application (which itself opens up
the pcm device, via SDL with SDL_AUDIODRIVER=alsa), and it forks off an
mplayer (with -ao sdl:alsa). Then I flip rapidly between two different
movies, where each flip kill -TERM's the old mplayer and starts up a new
one. Oddly, every one of these mplayers is able to play sound. Then I shut
down my app, and wait for the mplayers to stop. If I get the bug, which I
do 80% of the time, then one of them will never stop, and when I try to
restart my app (or aplay, or mplayer), it gives me the error message and
fails to play sound.

fuser /dev/snd/pcmC0D0p shows only the mplayer processes (when my app has
exited and there is an mplayer lurking around.)



----------------------------------------------------------------------
 rlrevell - 03-22-06 03:06 
----------------------------------------------------------------------
This should be fixed in CVS, can you please test?

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
01-12-05 10:41 leahcim        Issue Monitored: leahcim                     
01-12-05 20:26 Dawid Gajownik Issue Monitored: Dawid Gajownik                   

01-19-05 16:54 tiwai          Note Added: 0003296                          
01-19-05 16:54 tiwai          File Added: xmms-1.2.10-alsa-multithread.diff     
              
07-20-05 17:34 Steve Fink     Issue Monitored: Steve Fink                    
07-21-05 01:03 Steve Fink     Note Added: 0005536                          
07-21-05 08:21 Steve Fink     Note Edited: 0005536                         
03-22-06 03:06 rlrevell       Note Added: 0008796                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
