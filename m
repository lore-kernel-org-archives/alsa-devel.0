From: Paul Davis <pbd@op.net>
Subject: design for the H-DSP control/mixer interface
Date: Wed, 27 Feb 2002 12:21:18 -0500
Message-ID: <200202271721.g1RHLIh19617@op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA25917
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2002 18:21:54 +0100
Received: from op.net (maxtnt04-470.phlpa.fast.net [209.92.97.216]) by renoir.op.net (o1/$Revision: 1.18 $) with ESMTP id MAA27211 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2002 12:21:49 -0500 (EST)
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

so, the matrix mixer on the hammerfall-dsp comes with 1456 independent
controls. each one represents the volume for routing an input (h/w
input or playback stream) to an output. there are 28 h/w inputs, 28
playback streams and 28 outputs.

it seems unwise to simply map this straight to the control API. no
program is going to be able to usefully cope with this many controls. 

i welcome ideas on ways to represent this kind of mixer with the ALSA
control system.

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
