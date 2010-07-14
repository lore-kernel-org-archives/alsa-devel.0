From: melwyn lobo <linux.melwyn@gmail.com>
Subject: Re: XRUN handling
Date: Wed, 14 Jul 2010 15:47:12 +0530
Message-ID: <AANLkTintdXC7pwQAi8qc8OyHRZw9jL2C7JphkIAwLXIf@mail.gmail.com>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
	<AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
	<AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
	<alpine.LNX.2.00.1007062034050.15497@eeebox2.perex-int.cz>
	<AANLkTinwkbuyFBxGAABNKaY_CVxK4OedlPHnY2NOf8ck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CB0701037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 12:17:14 +0200 (CEST)
Received: by vws9 with SMTP id 9so7034589vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2010 03:17:12 -0700 (PDT)
In-Reply-To: <AANLkTinwkbuyFBxGAABNKaY_CVxK4OedlPHnY2NOf8ck@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Another query, if setting runtime parameters like:
runtime->silence_threshold = runtime->boundary;
runtime->silence_size = runtime->boundary;
runtime->stop_threshold = runtime->boundary;

Also to avoid the bug in snd_pcm_playback_silence()  i.e.,
snd_BUG_ON(frames > runtime->buffer_size),
I have added a tweak in the driver IRQ handler:

              if(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
                                    &&
snd_pcm_playback_hw_avail(runtime) == 0) {

                        /* Hardware is continously running so it is
                         * playing silence so that should be OK.
                         * And we played all valid samples, so no data
                         * is lost. Not stopping intentionally
                         */

                          runtime->control->appl_ptr += runtime->period_size;
                        if(runtime->control->appl_ptr >= runtime->boundary)
                                runtime->control->appl_ptr -= runtime->boundary;

                        offset = runtime->control->appl_ptr -
runtime->silence_start;
                        if (offset < 0)
                                offset += runtime->boundary;
                        if ((snd_pcm_uframes_t)offset < runtime->silence_filled)
                                runtime->silence_filled -= offset;
                        else
                                runtime->silence_filled = 0;

                        runtime->silence_start = runtime->control->appl_ptr;

This avoids the bug above, but aplay does not stop after reading all
the samples from the file. It plays silence infinitely.
Should not this condition be detected by the aplay and stop the stream
when EOF on the file happens.

Regards,
M.
