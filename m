From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001648]: Front speakers are quiet
Date: Thu, 15 Dec 2005 01:16:48 +0100
Message-ID: <7c6cff8062cba65e648a4fdbd5c28e23@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 61E1A19A
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2005 01:16:48 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1648> 
======================================================================
Reported By:                kamilp11
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1648
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             2.6.14
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-13-2005 19:30 CET
Last Modified:              12-15-2005 01:16 CET
======================================================================
Summary:                    Front speakers are quiet
Description: 
I have SoundBlaster Live! 5.1 Digital. When I run sound program who has
support 5.1 (xine, mplayer) everythings work fine without front speakers.
When I run sound program on default sound device 5 speakers play and wave,
wave center, wave surround volume controls has effect

I have wave, wave surround, wave center, pcm, master and other volume
controls unmute.

======================================================================

----------------------------------------------------------------------
 kamilp11 - 12-15-05 00:44 
----------------------------------------------------------------------
I used EMU10K1.conf from CVS (like #1624) and now everythigs works fine. So
newer version of drivers must be work, thanks.

----------------------------------------------------------------------
 rlrevell - 12-15-05 01:16 
----------------------------------------------------------------------
Fixed in CVS

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-13-05 19:30 kamilp11       New Issue                                    
12-13-05 19:30 kamilp11       Distribution              => Fedora Core 4   
12-13-05 19:30 kamilp11       Kernel Version            => 2.6.14          
12-13-05 20:27 rlrevell       Note Added: 0007021                          
12-13-05 20:52 mikma          Note Added: 0007023                          
12-14-05 02:54 kamilp11       Note Added: 0007027                          
12-14-05 03:15 rlrevell       Note Added: 0007028                          
12-14-05 13:12 Winterbird     Note Added: 0007037                          
12-15-05 00:44 kamilp11       Note Added: 0007045                          
12-15-05 01:16 rlrevell       Status                   new => resolved     
12-15-05 01:16 rlrevell       Resolution               open => fixed       
12-15-05 01:16 rlrevell       Assigned To               => rlrevell        
12-15-05 01:16 rlrevell       Note Added: 0007046                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
