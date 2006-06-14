From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002210]: poll() behaving anomalously,
	returning alternate streams on each interrupt,
	playback then capture but never both together
Date: Wed, 14 Jun 2006 23:56:18 +0200
Message-ID: <6fe65f16e717896e79cf2c935277f68e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16FC519F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jun 2006 23:56:19 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2210> 
======================================================================
Reported By:                cmorgan
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2210
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.16-2-amd64-k8 (Debian 2.6.16-14)
======================================================================
Date Submitted:             06-14-2006 23:56 CEST
Last Modified:              06-14-2006 23:56 CEST
======================================================================
Summary:                    poll() behaving anomalously, returning alternate
streams on each interrupt, playback then capture but never both together
Description: 
poll() behaving anomalously, returning alternate streams on each interrupt,
playback then capture but never both together.  Causes jack audio server
to be unable to play back audio.

Running jack with the alsa plugin and giving it the -P option puts the
jack alsa driver into playback only mode.  This makes jack work again.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-06 23:56 cmorgan        New Issue                                    
06-14-06 23:56 cmorgan        Distribution              => Debian          
06-14-06 23:56 cmorgan        Kernel Version            => 2.6.16-2-amd64-k8
(Debian 2.6.16-14)
======================================================================
