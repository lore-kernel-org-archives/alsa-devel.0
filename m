From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002194]: fglrx and snd_hda_intel
Date: Thu, 8 Jun 2006 19:46:21 +0200
Message-ID: <263f6da8557d1a8ff1ad6e25c6ad4d5e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 05EB2175
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 19:46:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2194> 
======================================================================
Reported By:                emacspy
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2194
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.16-gentoo-r9
======================================================================
Date Submitted:             06-08-2006 19:33 CEST
Last Modified:              06-08-2006 19:46 CEST
======================================================================
Summary:                    fglrx and snd_hda_intel
Description: 
Iam having a problem using snd_hda_intel with fglrx. In games sound lags
but if I do a modprobe snd_hda_intel sound does not lag but video fps
suffers greatly. I am not sure if this is a problem with fglrx or
snd_hda_intel any input would be great.
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-08-06 19:46 
----------------------------------------------------------------------
What sound driver is used if you do not use snd-hda-intel?

If your games support OSS, does it make any difference if you use them in
OSS or ALSA mode?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-06 19:33 emacspy        New Issue                                    
06-08-06 19:33 emacspy        Distribution              => gentoo          
06-08-06 19:33 emacspy        Kernel Version            => 2.6.16-gentoo-r9
06-08-06 19:46 rlrevell       Note Added: 0010115                          
======================================================================
