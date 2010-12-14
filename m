From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Calculated average playback latency
Date: Tue, 14 Dec 2010 23:30:23 +1100
Message-ID: <AANLkTikcrTA4hRp9AvOfZPGN0FrkKwYS3SaFq0W25NdE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 34C801038FF
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 13:30:28 +0100 (CET)
Received: by iye19 with SMTP id 19so314394iye.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 04:30:23 -0800 (PST)
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

Hi there.

I am involved in maintaining the mythtv audio code.

Today one of our user complained that he couldn't get any audio out ,
even though everything was properly configured on his side.

By default, Myth uses mmap access ; unless we found out that the audio
device doesn't allow mmap (e.g. snd_pcm_hw_params_set_access(handle,
params, SND_PCM_ACCESS_MMAP_INTERLEAVED) errored)

Problem, turned out his was using a USB audio device, and
snd_pcm_hw_params_set_access didn't return any error.

It's not the first time we're having such issues, so I decided to stop
using mmap and instead use snd_pcm_writei.

Now on my system, this has added quite a bit of latency and the A/V
sync isn't perfect anymore...

Is there an official way to calculate an average system latency
(doesn't need to be perfectly accurate).

I couldn't find obvious references on how to perform such task.

I find some references in program like mplayer or jack using
snd_pcm_status_get_trigger_tstamp

Would anyone be kind enough to point me to some documentation or
explain to me how I could calculate the average latency between the
time you start playback and the time sounds actually comes out.

Thank you in advance
Jean-Yves
