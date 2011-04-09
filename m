From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: emu10k1 and pulseaudio I: (alsa-lib)setup.c: Cannot
	lock ctl
Date: Sat, 9 Apr 2011 11:54:46 +0800
Message-ID: <BANLkTinnXE-oQdWQJ8UskJ6w6xtG-hTt7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C655010387B
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 05:54:49 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3072619fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 20:54:46 -0700 (PDT)
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

In debugging emu10k1 with pulseaudio by printing elem->id->name

                SNDERR("Cannot lock ctl elem %s", elem->id->name);

I discovered that sometime "EMU10K1 PCM Send Volume" is locked
Is this a bug in alsa-lib or pulseaudio ?


D: alsa-util.c: Checking for superset analog-stereo (front:%f)
D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open front:0
I: alsa-util.c: cannot disable ALSA period wakeups
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: (alsa-lib)setup.c: Cannot lock ctl elem EMU10K1 PCM Send Volume
I: (alsa-lib)setup.c: Cannot lock ctl elem EMU10K1 PCM Send Volume
I: (alsa-lib)setup.c: Cannot lock ctl elem EMU10K1 PCM Send Volume
I: (alsa-lib)setup.c: Cannot lock ctl elem EMU10K1 PCM Send Volume
D: alsa-util.c: Set neither period nor buffer size.
I: (alsa-lib)setup.c: Cannot lock ctl elem EMU10K1 PCM Send Volume
I: alsa-util.c: snd_pcm_hw_params failed: Device or resource busy
