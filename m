From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001753]: M-Audio Revolution 5.1: Mute Line-In / Mic
Date: Fri, 20 Jan 2006 17:12:34 +0100
Message-ID: <1ad9275878e8be4f2f3c145270be69ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DEAA16B
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 17:12:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1753> 
======================================================================
Reported By:                wollschaf
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1753
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-15-2006 15:49 CET
Last Modified:              01-20-2006 17:12 CET
======================================================================
Summary:                    M-Audio Revolution 5.1: Mute Line-In / Mic
Description: 
There is no mixer element to enable or disable Line and Mic inputs.

The problem is that even with all DAC mixers set to zero, white noise can
be heard . It is pretty loud, and too loud to enjoy music / the good SNR
of the card ;)

Setting 
#define VT1724_REVO_MUTE        (1<<22)

to 
#define VT1724_REVO_MUTE        (0<<22)

gets rid of the noise, but playback volume is pretty low, especially for
headphones - even with the DAC mixer set to 100%.

Even if there is no way to adjust input gain in hardware (correct?), there
should be a possibility to disable / mute the inputs or change the routing
so they are not played back internally.


======================================================================

----------------------------------------------------------------------
 wollschaf - 01-19-06 21:52 
----------------------------------------------------------------------
Loopback is not enabled until the driver is initialized. Complete silence,
as it should be.

Another (perhaps useful) hint: DAC mixer does not affect the volume of
static at all.

I would even accept a module parameter to disable inputs completely...
IMHO the card is not usable right now, it's like sitting next to a radio
tuned to a dead station.

----------------------------------------------------------------------
 wollschaf - 01-20-06 17:12 
----------------------------------------------------------------------
The revo5.1 has an AK5365VQ ADC, which has built-in volume control
(Datasheet Page 21).

I keep crawling through code, registers, bit shifts and datasheets which
are still a big mystery to me. In the distant future, I'll understand how
it works. I hope. ;)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 15:49 wollschaf      New Issue                                    
01-15-06 15:49 wollschaf      Kernel Version            => 2.6.15          
01-15-06 15:49 wollschaf      Issue Monitored: wollschaf                    
01-19-06 21:52 wollschaf      Note Added: 0007722                          
01-20-06 17:12 wollschaf      Note Added: 0007726                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
