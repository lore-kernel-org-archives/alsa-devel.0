From: Jack Howarth <howarth@bromo.med.uc.edu>
Subject: alsa breaks alsaplayer on powermac
Date: Fri, 7 Jun 2002 21:05:32 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206080105.VAA15131@bromo.msbb.uc.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bromo.msbb.uc.edu (bromo.med.uc.edu [129.137.3.146])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id DAA09797
	for <alsa-devel@alsa-project.org>; Sat, 8 Jun 2002 03:06:39 +0200
Received: (from howarth@localhost)
	by bromo.msbb.uc.edu (SGI-8.9.3/8.9.3) id VAA15131
	for alsa-devel@alsa-project.org; Fri, 7 Jun 2002 21:05:32 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

   The current alsa-driver, alsa-libs and alsa-utils seem to work
fine with the snd-powermac driver on my Apple G4 Sawtooth Powermac
in both alsa and oss compatibility mode. However, there still is
a conflict with the current alsa-player cvs. As before we are still
getting...

alsaplayer
alsaplayer: pcm.c:5655: snd_pcm_unlink_ptr: Assertion `0' failed.
AlsaPlayer interrupted by signal 6


Has any of the developers been able to reproduce this? Is there
any code changes we can try to test solutions to this problem?
                   Jack

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
