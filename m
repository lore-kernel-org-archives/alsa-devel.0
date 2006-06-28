From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000209]: Sometimes XMMS stop playing
	songs (dmix used)
Date: Wed, 28 Jun 2006 06:35:45 +0200
Message-ID: <4a719c3121704683b5b210598a1b637c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA44D188
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 06:35:45 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              06-28-2006 06:35 CEST
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
 rlrevell - 03-22-06 03:06 
----------------------------------------------------------------------
This should be fixed in CVS, can you please test?

----------------------------------------------------------------------
 leahcim - 06-28-06 06:35 
----------------------------------------------------------------------
FWIW, I haven't noticed this problem occurring for quite a while now.

(now using kernel 1.0.11rc2 with libs 1.0.11, and empty asound.conf).

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
06-28-06 06:35 leahcim        Note Added: 0010610                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
