From: Jaroslav Kysela <perex@suse.cz>
Subject: dmix plugin
Date: Wed, 12 Feb 2003 10:45:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302121015420.14550-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA02289
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 10:45:57 +0100
Received: from pnote.perex-int.cz ([192.168.105.2])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA18567
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 10:45:50 +0100
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

	a next step to get the lowlatency sharing of exclusive PCM devices 
is in ALSA CVS - the dmix (direct mixing) plugin..
	How it works? Basically, the playback in driver runs forewer
without any xrun detection. The ring buffer (only just played areas) is
also silenced in each interrupt. Then we have multiple clients and a
process (server) which passes the file descriptor of playback devices to
them. The server also takes care about freeing of used shm memory and
semaphore.
	The big step forward is that we share one mmaped ring buffer
accross many processes and each process can add samples into it without
any process<->kernel swaps. Also, each processes are independant, thus
failing of one doesn't break others. It's not multithreaded, we don't need
this mechanism.

Here is an .asoundrc example configuration (plugin defaults are 48kHz, 
stereo, signed 16-bit little endian):

pcm.dmix {
	type dmix
	ipc_key 1234	# must be unique for all dmix plugins!!!!
	slave {
		pcm "hw:0,0"
	}
}

	Then try: 'aplay -Dplug:dmix <filename>' on multiple consoles.

	Note that it's still alpha code and there are some not correctly
implemented functions (like drain, rewind and more). Note that you'll need
also the latest ALSA driver from CVS, because the silence settings was
enhanced a bit and bug in the timer code will crash your machine.

					Enjoy it!
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
