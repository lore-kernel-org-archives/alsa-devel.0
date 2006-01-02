From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000737]: Background noise in master when no playing sound on Asus A7N8X Deluxe (nforce 2)
Date: Mon, 2 Jan 2006 20:26:58 +0100
Message-ID: <9ea3fca1168db50084cb77d629df9f70@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 728D2162
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 20:26:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=737> 
======================================================================
Reported By:                keymon
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   737
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.6
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-21-2004 09:28 CET
Last Modified:              01-02-2006 20:26 CET
======================================================================
Summary:                    Background noise in master when no playing sound on
Asus A7N8X Deluxe (nforce 2)
Description: 
Quoting http://www.nvnews.net/vbulletin/printthread.php?t=35148:

Every Asus A7N8X Deluxe Rev 2.0 Board has a problem with a weird "whining"
"whirring" or "buzzing" "static" noise coming out of the speakers AND out
of the motherboard itself. 

When speakers are connected and the volume is turned up to normal levels,
the noise is very loud, approx 20% of the signal.

This noise appear when the card is not playing sound and there is low CPU
using. As soon as you play sound, noise stops. If you pause xmms or any
player, noise returns.

Muting all the channels does not stop the noise, but if you exec: "alsactl
power 0 off" &#161;noise stops!, but you have to exec "alsactl power 0 on"
to use the card again. The driver could do the same than "alsactl power 0
off" when it isn't playing sound.

If you use the lastest nforce drivers (1.0-0283 or newer) noise stops.


======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 17:26 
----------------------------------------------------------------------
Submitter: You were asked to provide additional information.
Can you please provide it?

----------------------------------------------------------------------
 rlrevell - 01-02-06 20:26 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-04 09:28 keymon         New Issue                                    
12-21-04 09:28 keymon         Distribution              => Debian          
12-21-04 09:28 keymon         Kernel Version            => 2.6.6           
12-21-04 09:28 keymon         Issue Monitored: keymon                      
12-21-04 18:40 tiwai          Note Added: 0002900                          
04-09-05 17:26 jdthood        Note Added: 0004423                          
04-09-05 17:26 jdthood        Status                   new => feedback     
01-02-06 20:26 rlrevell       Status                   feedback => closed  
01-02-06 20:26 rlrevell       Note Added: 0007382                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
