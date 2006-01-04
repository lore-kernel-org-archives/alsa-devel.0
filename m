From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001426]: only mono sound available on via82xx
Date: Wed, 4 Jan 2006 17:27:43 +0100
Message-ID: <ff328c5025ed81ca2a93deaf5c7fce1e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 46318154
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:27:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1426> 
======================================================================
Reported By:                netset99
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1426
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               gentoo
Kernel Version:             2.6.13
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-15-2005 22:12 CEST
Last Modified:              01-04-2006 17:27 CET
======================================================================
Summary:                    only mono sound available on via82xx
Description: 
Only get mono sound with alsa. This is shown by the fact that I cannot
change the master stereo volume e.g. in alsamixer, only mute or unmute
it.

Tried with kernels 2.6.12, 2.6.13, both compiled into the kernel or as
modules. Also happens with the drivers from the alsa homepage
(1.0.10_rc1). Tried live CD's from Gentoo (2.6.12 kernel) and from Knoppix
(2.6.11). dxs_support 1-5 and ac97_quirk parameters didn't solve the
problem. Neither did changing volume / muting and unmuting a combination
of controls in alsamixer.

However: A Ubuntu Live CD (Kernel 2.6.10) gives me normal stereo sound.
======================================================================

----------------------------------------------------------------------
 netset99 - 01-03-06 10:25 
----------------------------------------------------------------------
Just tried with it 2.6.14 gentoo kernel. Still the same thing, it just
doesn't bother me anymore.

----------------------------------------------------------------------
 tiwai - 01-04-06 17:27 
----------------------------------------------------------------------
It's a hardware feature.  The codec chip doesn't have any playback volume
controls.  The volume can be controlled via "PCM" implemented in software
(in alsa-lib).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 22:12 netset99       New Issue                                    
09-15-05 22:12 netset99       Distribution              => gentoo          
09-15-05 22:12 netset99       Kernel Version            => 2.6.13          
09-15-05 22:47 netset99       Note Added: 0006226                          
12-30-05 23:16 rlrevell       Note Added: 0007282                          
01-03-06 10:25 netset99       Note Added: 0007401                          
01-04-06 17:27 tiwai          Status                   new => resolved     
01-04-06 17:27 tiwai          Resolution               open => fixed       
01-04-06 17:27 tiwai          Assigned To               => tiwai           
01-04-06 17:27 tiwai          Note Added: 0007440                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
