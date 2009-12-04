From: Achilles H <leehadji@gmail.com>
Subject: syslog says snd-usb-audio bug?
Date: Fri, 4 Dec 2009 17:33:43 +1100
Message-ID: <fb0a16ef0912032233s2de8a6acs6abe753fefb3c670@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191])
	by alsa0.perex.cz (Postfix) with ESMTP id CFF6A24504
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 07:33:44 +0100 (CET)
Received: by pzk29 with SMTP id 29so2070240pzk.17
	for <alsa-devel@alsa-project.org>; Thu, 03 Dec 2009 22:33:43 -0800 (PST)
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

Dec  4 00:16:21 susbwoy pulseaudio[1719]: alsa-sink.c: ALSA woke us up
to write new data to the device, but there was actually nothing to
write!
Dec  4 00:16:21 susbwoy pulseaudio[1719]: alsa-sink.c: Most likely
this is a bug in the ALSA driver 'snd_usb_audio'. Please report this
issue to the ALSA developers.
Dec  4 00:16:21 susbwoy pulseaudio[1719]: alsa-sink.c: We were woken
up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0
or another value < min_avail.


I am using Ubuntu 9.10 64bit with an Edirol UA-25 USB sound card. I
installed OpenArena, and tried to open it. Screen went black - Could
only get back to the desktop by killing X.


This is what happened in the terminal when OpenArena Died at Initializing sound

------ Initializing Sound ------
bt_audio_service_open: connect() failed: Connection refused (111)
bt_audio_service_open: connect() failed: Connection refused (111)
bt_audio_service_open: connect() failed: Connection refused (111)
bt_audio_service_open: connect() failed: Connection refused (111)
Allocated 96 sources.
OpenAL default capture device is 'ALSA Capture on default'
AL lib: alsa.c:675: set access failed: Invalid argument
AL lib: oss.c:307: Could not open /dev/dsp: No such file or directory
Killed


I have no issues with sound at all apart from trying to use
OpenAL.Warsow(another great game) will also refuse to run with OpenAL,
except it runs great in the default sound mode 'qf'.

What is going on here? thanks
