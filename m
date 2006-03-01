From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000573]: no SPDIF output with vt82xx/ICEnsemble VT1616i
Date: Wed, 1 Mar 2006 01:02:22 +0100
Message-ID: <5cf2f20afcc8268544a256c60a308fb4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0143C1C1
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 01:02:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=573> 
======================================================================
Reported By:                vladimir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   573
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3 test 2
Kernel Version:             2.6.8-1.541, as shipped with FC3t2
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             10-09-2004 00:59 CEST
Last Modified:              03-01-2006 01:02 CET
======================================================================
Summary:                    no SPDIF output with vt82xx/ICEnsemble VT1616i
Description: 
With alsa 1.0.6 (in kernel), 1.0.7rc1, or CVS, I'm unable to reliably get
SPDIF output to work -- it might work once out of a dozen or so times. 
The attached patch improves things -- ignoring the cached values in
ac97_read_cache gives me working spdif playbac.  The values I see printed
with the printk added in ac97_read_cache by the patch are:

AC97_read_cache: register 0x002a has real value 0x01f1 cached 0x05f1 
AC97_read_cache: register 0x002a has real value 0x05f1 cached 0x01f1 

which indicates a change in the read-only SPCV bit.  Perhaps registers
with read-only status bits shouldn't be cached?  I'm not sure if that's
the fix, or if there's a deeper issue here.

======================================================================

----------------------------------------------------------------------
 vladimir - 04-10-05 06:05 
----------------------------------------------------------------------
I ended up RMA'ing my EPIA ME6000 for an identical one, and just recently
got around to setting the machine up. Reinstalling stock FC3, and updating
to the latest kernel -- kernel-2.6.10-1.770_FC3 -- and now I've yet to get
any SPDIF output at all.  Trying to track it down..

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:39 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 00:59 vladimir       New Issue                                    
10-09-04 00:59 vladimir       File Added: ac97_codec-no-readcache.patch         
          
10-09-04 00:59 vladimir       Distribution              => Fedora Core 3 test 2
10-09-04 00:59 vladimir       Kernel Version            => 2.6.8-1.541, as
shipped with FC3t2
10-11-04 08:21 vladimir       Note Added: 0002070                          
10-11-04 12:54 tiwai          Note Added: 0002076                          
10-11-04 19:46 vladimir       Note Added: 0002083                          
10-12-04 14:31 tiwai          Note Added: 0002092                          
10-12-04 14:31 tiwai          File Added: ac97-spcv-debug.diff                  
 
10-12-04 19:44 vladimir       Note Added: 0002107                          
10-13-04 11:16 tiwai          Note Added: 0002118                          
10-13-04 11:17 tiwai          File Added: ac97-ea-fix.diff                    
04-09-05 16:17 jdthood        Note Added: 0004409                          
04-10-05 06:05 vladimir       Note Added: 0004432                          
12-30-05 04:39 rlrevell       Note Added: 0007216                          
03-01-06 01:02 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
