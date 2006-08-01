From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002323]: MythTV PCM control doesn't
	change alsamixer PCM with intel-hda driver and NVidia hardware
Date: Tue, 1 Aug 2006 21:29:32 +0200
Message-ID: <8ac54135606f50e2040cfd206a67194c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 35469153
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 21:29:32 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2323> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2323
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo-2006.0 fully updated
Kernel Version:             2.6.17-gentoo-r4
======================================================================
Date Submitted:             08-01-2006 21:15 CEST
Last Modified:              08-01-2006 21:29 CEST
======================================================================
Summary:                    MythTV PCM control doesn't change alsamixer PCM with
intel-hda driver and NVidia hardware
Description: 
MYthTV is a popular set of programs for viewing live and recorded TV on the
Linux platform. I run it here on about 10 machines. After setting up a new
NVidia-based machine with mythfrontend I found I could not control the
volume with MYth's default settings. I have not seen this problem on any
other machine here.

Looking at alsamixer for this machine I see 'PCM' and 'Front' as the main
two controls. With MythTV in it's default setting (Mixer controls PCM)
when I change volume in Myth the PCM level in alsamixer does not change
it's level. This is clearly different than all my other machines.

When I changed the Myth setting to 'Mixer controls Master' I found that
Myth changes the 'Front' setting in alsamixer and I am able to control the
volume, so it works, but it works differently than all my other machines.

Since MYth is working correctly with all my other machines and since it's
only the intel-hda driver that seems to act differently I assume this is a
low-level bug in the Intel-HDA driver.
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-01-06 21:29 
----------------------------------------------------------------------
"With MythTV in it's default setting (Mixer controls PCM) when I change
volume in Myth the PCM level in alsamixer does not change it's level."

Can you control the PCM volume using alsamixer directly?  If so it's a
MythTV bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-06 21:15 Mark Knecht    New Issue                                    
08-01-06 21:15 Mark Knecht    Distribution              => Gentoo-2006.0 fully
updated
08-01-06 21:15 Mark Knecht    Kernel Version            => 2.6.17-gentoo-r4
08-01-06 21:29 rlrevell       Note Added: 0011383                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
