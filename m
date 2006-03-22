From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000583]: xruns when playing audio or video files
Date: Wed, 22 Mar 2006 03:13:23 +0100
Message-ID: <8716ba8dfa8696030ed06d415d4f2586@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E02F2172
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:13:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=583> 
======================================================================
Reported By:                KAtiOS
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   583
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo Linux
Kernel Version:             2.6.9_rc4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-15-2004 16:27 CEST
Last Modified:              03-22-2006 03:13 CET
======================================================================
Summary:                    xruns when playing audio or video files
Description: 
I get xruns when playing files.
I tested with lots of 2.6 kernels, up to 2.6.9_rc4 with the same results.
It seems that mplayer with sdl output works fine, but xruns with alsa.
Using acpi=off or pci=noacpi helps in mplayer but not in vdr (with
softdevice plugin - using alsa).



======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000776 desynchronization, xruns when running m...
has duplicate       0000490 &nbsp;Choppy sound when playing on Acer...
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-14-05 21:58 
----------------------------------------------------------------------
Hmm, this could have been the ACPI idle latency bug.  That would explain
why generating load reduces the xruns.  This was fixed around 2.6.11.

Try kernel 2.6.13.

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:13 
----------------------------------------------------------------------
Fixed in mplayer CVS (it should ignore xruns rather than resetting the
stream)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 16:27 KAtiOS         New Issue                                    
10-15-04 16:27 KAtiOS         Distribution              => Gentoo Linux    
10-15-04 16:27 KAtiOS         Kernel Version            => 2.6.9_rc4       
10-15-04 18:43 lee            Note Added: 0002168                          
10-15-04 18:51 KAtiOS         Note Added: 0002169                          
10-15-04 19:02 lee            Note Added: 0002170                          
10-15-04 19:12 KAtiOS         Note Added: 0002171                          
10-15-04 19:24 KAtiOS         Note Added: 0002172                          
10-15-04 19:29 lee            Note Added: 0002173                          
10-15-04 20:28 KAtiOS         Note Added: 0002174                          
10-15-04 22:17 lee            Note Added: 0002175                          
10-15-04 23:49 KAtiOS         Note Added: 0002176                          
10-16-04 01:11 lee            Note Added: 0002180                          
10-16-04 01:18 lee            Note Added: 0002181                          
10-16-04 06:05 lee            Note Added: 0002183                          
10-16-04 10:08 KAtiOS         Note Added: 0002185                          
10-16-04 11:39 KAtiOS         Note Added: 0002186                          
09-14-05 15:52 jdthood        Note Added: 0006161                          
09-14-05 16:14 jdthood        Relationship added       has duplicate 0000776
09-14-05 17:44 KAtiOS         Note Added: 0006185                          
09-14-05 21:58 rlrevell       Note Added: 0006186                          
09-15-05 15:13 jdthood        Relationship added       has duplicate 0000490
03-22-06 03:13 rlrevell       Status                   assigned => resolved
03-22-06 03:13 rlrevell       Resolution               open => fixed       
03-22-06 03:13 rlrevell       Note Added: 0008803                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
