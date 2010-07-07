From: melwyn lobo <linux.melwyn@gmail.com>
Subject: Re: XRUN handling
Date: Wed, 7 Jul 2010 13:41:53 +0530
Message-ID: <AANLkTinwkbuyFBxGAABNKaY_CVxK4OedlPHnY2NOf8ck@mail.gmail.com>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
	<AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
	<AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
	<alpine.LNX.2.00.1007062034050.15497@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id AEB6C243C1
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 10:11:55 +0200 (CEST)
Received: by vws9 with SMTP id 9so5101939vws.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Jul 2010 01:11:54 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1007062034050.15497@eeebox2.perex-int.cz>
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

On Wed, Jul 7, 2010 at 12:09 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 6 Jul 2010, melwyn lobo wrote:
>
>> done away with by using silence_size and silence_threshold. And if the
>> application still does not get processor time for some reason, the
>> hw_ptr will overrun the appl_ptr by more than buffer_size and trigger
>> a bug in snd_pcm_playback_silence().
>
> Could you fix (send us a patch) or describe exactly this problem?

Yes. It occurs in a loaded system. The hardware runs continously and
eventually underruns (stop_threshold trigger does not
occur because of its large value).
Eventually due to silence_threshold, silence_size setting,
snd_pcm_playback_silence() attempts to continously append
silence.
The function snd_pcm_playback_hw_avail(runtime) returns negative
values. Now consider the code fragment;
noise_dist = snd_pcm_playback_hw_avail(runtime) + runtime->silence_filled;

                if (noise_dist >= (snd_pcm_sframes_t)
runtime->silence_threshold)
                        return;
                frames = runtime->silence_threshold - noise_dist;

which makes at some point frames > runtime->buffer_size and triggers

  if (snd_BUG_ON(frames > runtime->buffer_size))
                return;

This is my analysis as I can see the above statement getting executed.
For this, the solution implemented in the driver, is to eventually
stop the infinite DMA when appl_ptr <= hw_ptr.
>
>                                        Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>

Regards,
M.
Regards,
M.
