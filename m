From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re:
	=?windows-1252?q?Warning/error_from_ALSA=92s_pcm=5Fm?=
	=?windows-1252?q?in=2Ec_example=2E_Possible_problem=3F?=
Date: Sun, 31 Jan 2010 12:43:48 +0800
Message-ID: <4f3252891001302043n3a404f1awdd8a7bef9769eb5a@mail.gmail.com>
References: <30c82f5f1001301151r6de4761fh9453829c1af85e15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 432DD24471
	for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2010 05:43:50 +0100 (CET)
Received: by pzk36 with SMTP id 36so3907972pzk.5
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 20:43:48 -0800 (PST)
In-Reply-To: <30c82f5f1001301151r6de4761fh9453829c1af85e15@mail.gmail.com>
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

2010/1/31 Louise Hoffman <louise.hoffman@gmail.com>

> Dear ALSA developers,
>
> When I compile ALSA's pcm_min.c[0] example with
>
> gcc -Wall -lasound pcm_min.c -o pcm_min
>
> Everything is fine, but running it, I get the white noise as expected,
> but I also get this warning/error:
>
> Short write (expected 16384, wrote 7616)
>
> Which comes from the last if-statement.
>
> One bug is in this line
>
>                frames = snd_pcm_writei(handle, buffer, sizeof(buffer));
>
> where "sizeof(buffer)" should be "number of frames in the buffer".
>
> But there are still some strange things going on. I still get those
> errors, and if I remove the for-loop, nothing is played.
>
> Here is my code. [1]
>
> Can someone see what's wrong?
>
> Hugs,
> Louise
>
>
> [0]
> http://www.google.com/codesearch/p?hl=en&sa=N&cd=1&ct=rc#4FSOSMZ6Pxc/distfiles/alsa-lib-1.0.14rc2.tar.bz2|ZScnKi-LryE/alsa-lib-1.0.14rc2/test/pcm_min.c&q=pcm_min.c<http://www.google.com/codesearch/p?hl=en&sa=N&cd=1&ct=rc#4FSOSMZ6Pxc/distfiles/alsa-lib-1.0.14rc2.tar.bz2%7CZScnKi-LryE/alsa-lib-1.0.14rc2/test/pcm_min.c&q=pcm_min.c>
>
> [1] http://pastebin.com/m2f28b578
>
> The correct way is to use snd_pcm_get_params() to get buffer_size and
period_size

*snd_pcm_set_params() has limitation

The most common sound card (e.g. HDA ) has the following constraints
on period bytes and buffer bytes

     snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
                                    128);
     snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
                                   128);
*

you cannot get exactly 0.5 second period time when rate is multiple of 3 (
e.g. 48000 Hz )
