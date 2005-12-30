From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000809]: asfxload + aconnect called before dsp used causes dsp to be locked
Date: Fri, 30 Dec 2005 23:04:51 +0100
Message-ID: <fb68fd8c072ed7e15984ee163520358b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 75AAE190
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:04:51 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=809> 
======================================================================
Reported By:                vinyvat
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   809
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian testing
Kernel Version:             2.6.8.1
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-12-2005 09:34 CET
Last Modified:              12-30-2005 23:04 CET
======================================================================
Summary:                    asfxload + aconnect called before dsp used causes
dsp to be locked
Description: 
PS: This bug is present in the alsa version in stock kernel 2.6.8.1 up to
1.0.8-rc2.

For convienience I like to have my wavetable loaded and midi connections
setup during bootup so I can use my midi keyboard by just turning on the
computer.

This worked OK with stock kernel 2.6.3 ( and whatever alsa version came
with it ).

Recently upgraded to stock 2.6.8.1 which had the modprobe
snd-emu10k1-synth freeze bug, but was able to work around this by
launching my wavetable loading script post the modprobe. Play back from my
keyboard worked great.

This is when I began to notice apps that accessed the dsp reporting that
they were locked out ( and did not produce any sound ). First would be
arts when kde started up, and then any dvd playing app ( ogle, mplayer,
xine, all of them setup to use alsa ).

Strangely though, alsaplayer still worked despite the fact that the other
apps didn't - could it be using some other way of plugin to the emu10k1
mixer ? 

Have tried upgrading to alsa-driver-1.0.7 ( which didn't play any
wavetable sounds at all - strange ), then to alsa-driver-1.0.8-rc2 ( which
does play wavetable sounds ) but none of these fixes this problem.

If I change the order of things - have artsd start up, start a dvd
playback, and then call asfxload + aconnect, then everything is mixed and
sounds great.
======================================================================

----------------------------------------------------------------------
 vinyvat - 01-13-05 18:58 
----------------------------------------------------------------------
The computer itself has 1 Gigabyte of memory and I thought the emu10k1
cards loaded SF2 into the system memory - one of the very nice features of
the card.

After the asfxload the system still has plenty of memory.

Keep in mind that if I launch an app that keeps a persistent connection to
/dev/dsp ( like ogle playing a DVD ), and then go through the asfxload +
aconnect sequence, then everything works great - which is why this is such
an interesting bug.

----------------------------------------------------------------------
 jdthood - 09-14-05 16:19 
----------------------------------------------------------------------
Looks like there is no ALSA bug.  Close?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 09:34 vinyvat        New Issue                                    
01-12-05 09:34 vinyvat        Distribution              => Debian testing  
01-12-05 09:34 vinyvat        Kernel Version            => 2.6.8.1         
01-12-05 15:16 tiwai          Note Added: 0003171                          
01-12-05 18:50 vinyvat        Note Added: 0003175                          
01-13-05 06:42 vinyvat        Note Added: 0003182                          
01-13-05 12:41 tiwai          Note Added: 0003183                          
01-13-05 18:58 vinyvat        Note Added: 0003198                          
09-14-05 16:19 jdthood        Note Added: 0006180                          
12-30-05 23:04 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
