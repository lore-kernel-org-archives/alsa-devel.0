From: Paul Davis <pbd@op.net>
Subject: should i be able to abort in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Wed, 13 Feb 2002 12:27:22 -0500
Message-ID: <200202131727.g1DHRM604896@op.net>
Received: from op.net (maxtnt02-354.phlpa.fast.net [209.92.228.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA22239
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 18:32:10 +0100
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

should it work for me to call snd_pcm_drop() for both playback and
capture streams if i'm in the middle of a snd_pcm_mmap_{begin,commit}
pair?

unless i use RT timing, on both the trident and hammerfall, doing do
invariably causes an effect upon restarting the streams that suggests
an out-of-sync hw-pointer.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
