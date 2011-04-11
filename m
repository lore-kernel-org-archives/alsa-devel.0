From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: emu10k1 44100Hz and pulseaudio
Date: Mon, 11 Apr 2011 09:53:24 +0800
Message-ID: <BANLkTinaP+OViAkxpatHwWimA8NkRMtxUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 605831037FF
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 03:53:27 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3788429fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2011 18:53:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

https://bugs.launchpad.net/ubuntu/+source/alsa-plugins/+bug/57089


It seem that emu10k1 has problem with 44100Hz

aplay -Dhw:0 udial.wav

The sound is distorted

but there is no distortion when use dmix at 48000Hz

defaults.pcm.dmix.rate 48000

aplay -Dplug:dmix:0 udial.wav

Does emu10k1 really support 44100Hz playback ?

or udial.wav is a special case
