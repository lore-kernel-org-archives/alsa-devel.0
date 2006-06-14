From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002210]: poll() behaving anomalously,
	returning alternate streams on each interrupt,
	playback then capture but never both together
Date: Thu, 15 Jun 2006 00:31:36 +0200
Message-ID: <0466cce52affca0125fe1576415c4f3c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0257619F
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 00:31:36 +0200 (MEST)
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
Last Modified:              06-15-2006 00:31 CEST
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

----------------------------------------------------------------------
 rlrevell - 06-15-06 00:31 
----------------------------------------------------------------------
That's normal behavior - on most sound cards the capture and playback are
independent.  JACK should handle it.  I think it might be a bug in JACK.

What exactly are the symptoms - "it doesn't work" is not helpful.  Please
post the exact error messages.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-06 23:56 cmorgan        New Issue                                    
06-14-06 23:56 cmorgan        Distribution              => Debian          
06-14-06 23:56 cmorgan        Kernel Version            => 2.6.16-2-amd64-k8
(Debian 2.6.16-14)
06-15-06 00:31 rlrevell       Note Added: 0010217                          
======================================================================
