From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002221]: Volume entirely too faint on
	82801g ich7
Date: Mon, 19 Jun 2006 02:19:49 +0200
Message-ID: <7a33c70f701989126ee519e24857109d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 479E1157
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jun 2006 02:19:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2221> 
======================================================================
Reported By:                mlfarrell
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2221
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse 10.1
Kernel Version:             2.6.16.13-4-smp
======================================================================
Date Submitted:             06-19-2006 02:19 CEST
Last Modified:              06-19-2006 02:19 CEST
======================================================================
Summary:                    Volume entirely too faint on 82801g ich7
Description: 
I've seen this bug online many times with a resolution of upgrading to alsa
1.0.11, but I upgaded and am still having the issue.

I'm using an hp pavilion dv8000 laptop with built-in altec lansing
speakers.

Windows reports the soundcard as conexant high definition audio, linux as
82801g (ich7).  I've tried setting every model I know in the
/etc/modprobe.d/sound file for the hda-intel driver and am still having a
lack of useful volume sliders.  The key ones that I need are "pc speaker"
to turn it down cause its way too loud and "external amplifier" to turn up
the laptop's altec lansing speakers (sound volume is decent out of the
headphone jack).

Even with the volume all the way up (both master and pcm) I'm getting
sound thats almost too faint to hear.  


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-19-06 02:19 mlfarrell      New Issue                                    
06-19-06 02:19 mlfarrell      Distribution              => Suse 10.1       
06-19-06 02:19 mlfarrell      Kernel Version            => 2.6.16.13-4-smp 
======================================================================
