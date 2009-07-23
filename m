From: rom1dep <rom1dep@gmail.com>
Subject: [snd_via82xx] EAGAIN on snd_pcm_prepare after EPIPE on
	mmap_commit
Date: Thu, 23 Jul 2009 17:21:44 +0200
Message-ID: <494d907f0907230821ga09abcflb770b020b21b3735@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id E7AD824532
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 17:21:45 +0200 (CEST)
Received: by fxm26 with SMTP id 26so944950fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 08:21:45 -0700 (PDT)
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

Hello !
I am encountering some issues with pulseaudio : after some time and
for no evident reason PA stops routing the sound.
That's what I get with $pulseaudio -vvv :
http://pastebin.mandriva.com/13648 (got from a 2.6.29.6_mdv kernel)
running $pacmd list-sinks when stuck gives :
http://pastebin.mandriva.com/13649

Our pulseaudio integrator Colin Guthrie concluded :
"OK, so what is happening is that some alsa level problem is occurring
(due to mmap). Pulse tries to recover from this but cannot. The alsa
sink (and the whole card) is subsequently unloaded due to this fatal
error."
And now.. a quick paste from irc :
"[00:44:20] <coling> Jul 22 14:04:29 <mezcalero>     coling: driver
issue i am pretty sure
[00:44:20] <coling> Jul 22 14:04:33 <mezcalero>     i saw that before once
[00:44:20] <coling> Jul 22 14:04:55 <mezcalero>     coling: i.e.
EAGAIN on snd_pcm_prepare after EPIPE on mmap_commit
[00:44:23] <coling> Jul 22 14:05:08 <mezcalero>     coling: needs to
be brought to attention of alsa folks i guess
[00:44:30] <coling> That's what I was told."

I'm now on 2.6.30 and I can reproduce that bug, then I'm bringing that
to you ! :)

Thanks !
