From: Jaroslav Kysela <perex@suse.cz>
Subject: 0.9.0rc8b alsa-driver and alsa-lib packages
Date: Wed, 5 Mar 2003 22:02:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303052153400.17739-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA25678
	for <alsa-devel@alsa-project.org>; Wed, 5 Mar 2003 22:02:10 +0100
Received: from pnote.perex-int.cz (pnote.perex-int.cz [160.217.124.88])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA09915
	for <alsa-devel@alsa-project.org>; Wed, 5 Mar 2003 23:02:08 +0100
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

Hi all,

	I've just released compilation fixes for driver and library. The 
main change in library is that the pcm jack plugin is separated now and 
must be build manually in the alsa-lib/src/pcm/ext directory to avoid 
circular dependency jack <-> alsa-lib. The jack plugin installs itself to 
the /usr/lib/alsa-lib directory. Probably, I'll move some other plugins to 
this directory, too. Like: pcm_share, pcm_meter, pcm_dmix, pcm_adpcm, 
pcm_null, pcm_file, pcm_ladspa, pcm_shm.
	I'm going to release 0.9.0 final on Friday.

					Have fun,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
