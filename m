From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001729]: Only output through headphone jack
Date: Fri, 17 Mar 2006 01:09:05 +0100
Message-ID: <2119590ee7d1846918384ec79860270f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16B701BB
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 01:09:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1729> 
======================================================================
Reported By:                Jeff250
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1729
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu Breezy 5.10
Kernel Version:             2.6.12-10-686
Resolution:                 duplicate
Duplicate:                  1843
Fixed in Version:           
======================================================================
Date Submitted:             01-10-2006 09:16 CET
Last Modified:              03-17-2006 01:09 CET
======================================================================
Summary:                    Only output through headphone jack
Description: 
I have an HDA Intel card with a Sigmatel STAC9200 chip on a Dell XPS m140
laptop.
In Alsa 1.0.10, sound was outputted to both the speakers and headphones. 
I tried updating to a newer version of ALSA to see if there was any way to
disable speaker output when my headphones are plugged in.

However, in Alsa 1.0.11rc2 and latest CVS, sound is only outputted through
the headphone jack and never through the speakers, regardless of any
alsamixer tinkering.  (I suppose that's irony).  Reverting back to 1.0.10
solves the speaker output problem.

Thank you for your time.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001843 regression: no sound with sigmatel stac...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-17-06 01:09 
----------------------------------------------------------------------
Try the patch in #1843 with the latest CVS version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-06 09:16 Jeff250        New Issue                                    
01-10-06 09:16 Jeff250        Distribution              => Ubuntu Breezy 5.10
01-10-06 09:16 Jeff250        Kernel Version            => 2.6.12-10-686   
03-17-06 01:09 tiwai          Relationship added       duplicate of 0001843
03-17-06 01:09 tiwai          Duplicate ID             0 => 1843           
03-17-06 01:09 tiwai          Status                   assigned => resolved
03-17-06 01:09 tiwai          Resolution               open => duplicate   
03-17-06 01:09 tiwai          Note Added: 0008624                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
