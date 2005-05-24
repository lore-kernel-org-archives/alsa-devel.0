From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001125]: reproducible hang on nforce3 -- all applications
Date: Tue, 24 May 2005 23:36:35 +0200
Message-ID: <49091ae646474e616ed6afe44c9dc344@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 587321D0
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 23:36:35 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1125> 
======================================================================
Reported By:                dogpatch
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1125
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11-gentoo-r8
======================================================================
Date Submitted:             05-24-2005 23:36 CEST
Last Modified:              05-24-2005 23:36 CEST
======================================================================
Summary:                    reproducible hang on nforce3 -- all applications
Description: 
Just upgraded to the latest kernel/alsa-driver via Gentoo emerge. I'm using
Gentoo profile 2005.0. Prior to the upgrade, sound worked fine both as
direct ALSA and via OSS emulation.

Now, any attempt to play a sound causes the playing application to hang
forever on an ioctl.

This happens even after a poweroff cold boot.
intel8x0m module is not and has not ever been loaded.
No other applications using the sound devices.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-05 23:36 dogpatch       New Issue                                    
05-24-05 23:36 dogpatch       File Added: aplay.trace                      
05-24-05 23:36 dogpatch       Distribution              => Gentoo          
05-24-05 23:36 dogpatch       Kernel Version            => 2.6.11-gentoo-r8
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
