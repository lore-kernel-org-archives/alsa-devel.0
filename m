From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA release 1.0.1
Date: Thu, 8 Jan 2004 19:15:10 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401081520520.13704@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Announce <alsa-announce@alsa-project.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

	this is our first final ALSA release with number 1.0.1. As you all 
expected, there are only minor fixes against 1.0.0rc2.

	The 1.0 code is a direct successor of the 0.9 code which firstly
introduced the completely reworked APIs since 0.5 version. Our focus is
to offer a hardware abstraction layer for all kinds of hardware including
proffesional equipment.

	I would like to say a strong THANK YOU to all people who
contributed to this project. Namely: Abramo Bagnara, Takashi Iwai, Paul 
Davis, Clemens Ladisch, Massimo Piccioni and all others.

Changes since 1.0.0rc2:

* alsa-driver
  - added --with-redhat switch to force RedHat kernel detection
  - fixed system timer behaviour
  - OSS PCM emulation
    - added OSS_ALSAEMULVER ioctl to identify ALSA driver
    - changed whole-frag (default again) => partial-frag
    - small corrections in snd_pcm_oss_get_ptr()
  - USB audio fix
  - RME9652 - fixed driver load
  - GUS - fixed race - scheduling in interrupt
* alsa-lib
  - added ipc_perm option for direct plugins (dsnoop, dmix, dshare)
  - fixed range settings for simple mixer
  - added asym plugin
  - alisp work (not too much important at the moment)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
