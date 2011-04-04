From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: buffer_size return by
	snd_pcm_hw_params_get_buffer_size_max
Date: Mon, 4 Apr 2011 11:54:45 +0800
Message-ID: <BANLkTikFON0YKxv5iT6ECX+xMFfRMhYypA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EE0051037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 05:54:46 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4054192fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 03 Apr 2011 20:54:46 -0700 (PDT)
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

it seem that the value return by snd_pcm_hw_params_get_buffer_size_max()
depend on /proc/asound/Intel/pcm0p/sub0/prealloc

Is it a bug in alsa-lib or snd-hda-intel driver

refer to pulseaudio/src/modules/alsa/alsa-util.c

       if ((ret = snd_pcm_hw_params_get_buffer_size_max(hwparams,
&max_frames)) < 0)
            pa_log_warn("snd_pcm_hw_params_get_buffer_size_max() failed:
%s", pa_alsa_strerror(ret));
        else
            pa_log_debug("Maximum hw buffer size is %lu ms", (long unsigned)
(max_frames * PA_MSEC_PER_SEC / _ss.rate));



cat /proc/asound/Intel/pcm0p/sub0/prealloc
64

D: alsa-util.c: Checking for superset analog-stereo (front:%f)
D: alsa-util.c: Trying front:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open front:1
I: alsa-util.c: Trying to disable ALSA period wakeups, using timers only
D: alsa-util.c: Maximum hw buffer size is 371 ms
D: alsa-util.c: Set buffer size first (to 88200 samples), period size second
(to 88200 samples).
I: alsa-util.c: ALSA period wakeups disabled
I: alsa-source.c: Successfully opened device front:1.
I: alsa-source.c: Selected mapping 'Analog Stereo' (analog-stereo).
I: alsa-source.c: Successfully enabled mmap() mode.
I: alsa-source.c: Successfully enabled timer-based scheduling mode.


echo 32768 > /proc/asound/Intel/pcm0p/sub0/prealloc


D: alsa-util.c: Checking for superset analog-stereo (front:%f)
D: alsa-util.c: Trying front:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open front:1
I: alsa-util.c: Trying to disable ALSA period wakeups, using timers only
D: alsa-util.c: Maximum hw buffer size is 190217 ms
D: alsa-util.c: Set buffer size first (to 88200 samples), period size second
(to 88200 samples).
I: alsa-util.c: ALSA period wakeups disabled
I: alsa-sink.c: Successfully opened device front:1.
I: alsa-sink.c: Selected mapping 'Analog Stereo' (analog-stereo).
I: alsa-sink.c: Successfully enabled mmap() mode.
I: alsa-sink.c: Successfully enabled timer-based scheduling mode.
