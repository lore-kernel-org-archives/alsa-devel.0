From: Jaroslav Kysela <perex@perex.cz>
Subject: New PCM API extension
Date: Sat, 22 Feb 2003 18:56:20 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302221819040.1497-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA13865
	for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2003 18:56:41 +0100
Received: from pnote.perex-int.cz (pnote.perex-int.cz [160.217.124.88])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA02038
	for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2003 19:56:41 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

	I'd like to announce a new PCM API extension. Although it is 
implemented, it might be changed following the discussion on this list.
	I've added the snd_pcm_forward() function. This function is
function with opposite meaning to snd_pcm_rewind() - it skips given count
of frames (note that in the ring buffer are unchanged, only the r/w
pointer is increased). The application has full control on the r/w pointer
now. It's useful mainly in the no-xrun mode where the stream runs forever.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
