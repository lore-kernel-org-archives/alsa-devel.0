From: Paul Davis <pbd@op.net>
Subject: "plug" PCM device has odd default behaviour
Date: Wed, 13 Mar 2002 16:44:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203132144.g2DLiaP01978@op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA14161
	for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2002 22:43:14 +0100
Received: from op.net (maxtnt04-137.phlpa.fast.net [209.92.96.137]) by renoir.op.net (o1/$Revision: 1.18 $) with ESMTP id QAA05663 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2002 16:43:10 -0500 (EST)
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

so, you all know jack, i'm sure.

when jack is used with a "plug" PCM device, we end up with duplicated
channel data even on a 2 channel device. using mmap access, everything
we write to the channel area for channel 0 shows up on both channel 0
and channel 1. i don't understand how this could happen. any clues on
what i should start looking for? my first guess is that the channel
addresses supplied for mmap access are wrong/duplicated (i haven't
tried debugging yet).

obviously, jack works fine with a "hw" PCM device.

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
