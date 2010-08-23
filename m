From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: [alsa-lib] Query regarding
 snd_config_update_free_global() and threads etc.
Date: Mon, 23 Aug 2010 10:40:01 +0100
Message-ID: <i4tflh$8c4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E08F2447C
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 11:40:19 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OnTVm-0004Pt-W5
	for alsa-devel@alsa-project.org; Mon, 23 Aug 2010 11:40:14 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 11:40:14 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 11:40:14 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there,

I've got a (hopefully quick) query about snd_config_update_free_global()
and it's general thread safetyness.


I'm currently going insane on this bug:
https://bugs.kde.org/show_bug.cgi?id=232068
which revolves around a bug manifested in snd_pcm_close() (or rather
snd_pcm_ioplug_close()) when dealing with the ALSA->PulseAudio plugin.

>From what I can gather, this problem is related to a KDE module that is
loaded into the library in question which does some alsa probing and
ultimately calls snd_config_update_free_global() several times. The
library itself then goes on to use GStreamer to do actual audio output.
The crash then manifests itself prior to any sound actually being output.

I can reliably reproduce the machine on two machines (I don't have many
at my disposal), but cannot reproduce on a third. The two I can
reproduce it on are two and four core intel duo's. The one I cannot
reproduce on is an older, single core machine. I am leaning towards some
kind of thread safety issue.


In searching for similar problems, I found several references to similar
crashes attributed to snd_dlobj_cache_cleanup() perhaps not being thread
safe.

e.g.:
https://bugzilla.redhat.com/show_bug.cgi?id=482797#c14
 and
http://osdir.com/ml/attachments/txtpisfDmzbcN.txt
(and from that:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2124
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=589896
)


I've found that removing the calls to
snd_config_update_free_global() avoid the issue. I'm not even sure they
are needed, but all the same I wanted to discuss the core issue.

The MEMORY-LEAK file suggests that it should only be called after all
snd_*_open() calls, but it doesn't indicate if this is just a
recommendation or mandatory.  Is the *only* purpose of this call to make
valgrind happy? Or does it serve some other useful purpose too?

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
