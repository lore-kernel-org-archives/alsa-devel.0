From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000091]: Realtek ALC658 rev 0: Input/output error on plughw:0,4
Date: Sat, 19 Mar 2005 14:35:39 +0100
Message-ID: <3f5a4a345559267bd977dab0ae128325@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6A50C1CD
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 14:35:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=91> 
======================================================================
Reported By:                da-x
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   91
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             Latest 2.6.3 from BK
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             02-26-2004 15:36 CET
Last Modified:              03-19-2005 14:35 CET
======================================================================
Summary:                    Realtek ALC658 rev 0: Input/output error on
plughw:0,4
Description: 
while 'aplay -D plughw:0,0  test.wav' works, when I try to use the other
playback device I get this:

# aplay -D plughw:0,4  test.wav 
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
aplay: pcm_write:1083: write error: Input/output error

Plus, when playing on hw:0,0, if I mute one of these: Surround, Line-In As
Surround, or Duplicate Front, I get no sound. Also, if I mute Aux, the
volumes goes down by a factor. What is causing this?
======================================================================

----------------------------------------------------------------------
 tiwai - 02-26-04 20:02 
----------------------------------------------------------------------
BTW, try "external amplifier power down" OFF.

----------------------------------------------------------------------
 jdthood - 03-19-05 09:25 
----------------------------------------------------------------------
This one can probably be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-04 15:36 da-x           New Issue                                    
02-26-04 15:44 da-x           Issue Monitored: da-x                        
02-26-04 20:00 tiwai          Note Added: 0000369                          
02-26-04 20:02 tiwai          Note Added: 0000370                          
03-12-04 20:51 Csan           Issue Monitored: Csan                        
03-19-05 09:25 jdthood        Note Added: 0004016                          
03-19-05 14:35 perex          Status                   new => resolved     
03-19-05 14:35 perex          Resolution               open => unable to
duplicate
03-19-05 14:35 perex          Assigned To               => perex           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
