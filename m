From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000772]: Analog/Digital output not working.
Date: Fri, 30 Dec 2005 23:43:29 +0100
Message-ID: <f35766cbcfed570b71af84b4421f1508@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0BDAC157
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:43:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=772> 
======================================================================
Reported By:                ianw1234
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   772
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.9-1.681_FC3
======================================================================
Date Submitted:             12-31-2004 23:02 CET
Last Modified:              12-30-2005 23:43 CET
======================================================================
Summary:                    Analog/Digital output not working.
Description: 
I've been unable to get my SB Live! to send analog pcm out through the
Analog/Digital port. It's connected through this port to my receiver, and
while AC3 over the digital port works fine, I can't get anything else to
go over the line. I have a 48kHz wave file I've been testing, and I've
tried playing it with aplay over hw0,0 (no good), hw0,1 (doesn't exist),
and hw0,2 (no effect). 

I have the master, IEC Coaxial, AC97, External amplifier, and SB Live
Analog/Digital Output Jack all either unmuted or set to max volume. I've
tried loading the snd_pcm_oss module with various snd_dsp_map settings
without success.

I've tried this on 1.0.7 and 1.0.8rc1. I dimly remember this working in
the past, so I don't know if this was broken in the upgrade to 1.0.7
(which I had to do because AC3 passthrough didn't work in the version that
came with the 2.6.9 kernel) or whether I have some strange
misconfiguration. Help is appreciated! Thanks!
======================================================================

----------------------------------------------------------------------
 razer1 - 09-24-05 17:47 
----------------------------------------------------------------------
I've a similar bug too : geexbox distrib (multimedia usage :
www.geexbox.org), based on kernel 2.6.12, mplayer 1.0-pre7 & alsa 1.0.9. 
I try to use this SB Live 5.1 in 6 channels analog mode.
2 channels mode works, the rear output duplicates the front, but no output
via LFE/Center Jack Output (used for spdif too).
In Surround5.1 mode, the card give an uggly noise instead of movie sound
or music
All different amixer config give same result
Note : the card was working fine in this mode with an 2.6.7 on gentoo

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:43 
----------------------------------------------------------------------
Any improvement in later ALSA releases?  These bugs are thought to have
been fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 23:02 ianw1234       New Issue                                    
12-31-04 23:02 ianw1234       Kernel Version            => 2.6.9-1.681_FC3 
01-01-05 00:33 ianw1234       Note Added: 0003028                          
01-01-05 02:28 rlrevell       Note Added: 0003030                          
01-01-05 10:01 pzad           Note Added: 0003031                          
01-01-05 22:48 ianw1234       Note Added: 0003039                          
01-01-05 23:03 pzad           Note Added: 0003041                          
01-02-05 19:15 jukkat         Note Added: 0003046                          
01-02-05 19:20 jukkat         Note Edited: 0003046                         
01-04-05 21:57 visit0r        Issue Monitored: visit0r                     
04-18-05 23:16 jdthood        Note Added: 0004516                          
09-24-05 17:47 razer1         Note Added: 0006373                          
09-26-05 12:59 razer1         Issue Monitored: razer1                      
12-30-05 23:43 rlrevell       Note Added: 0007296                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
