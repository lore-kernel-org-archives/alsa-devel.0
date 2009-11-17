From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Delays with PulseAudio (normal)?
Date: Tue, 17 Nov 2009 15:37:16 +0800
Message-ID: <4f3252890911162337y280259fcp6427d0bdca62b251@mail.gmail.com>
References: <49793.77128.qm@web65407.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2648B24434
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 08:37:16 +0100 (CET)
Received: by pzk9 with SMTP id 9so4006841pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 23:37:16 -0800 (PST)
In-Reply-To: <49793.77128.qm@web65407.mail.ac4.yahoo.com>
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

2009/11/17 Tom Watson <sdc695@yahoo.com>

> I just did an fresh install of a Fedora 11, and it went well for the most
> part.  Then I tried some audio stuff, and it seems that pulseaudio (groan!)
> has a closing delay.
>
> In my case I want to issue a "beep" then make a recording.  This involves
> the equivalent of:
>
> $ aplay beep.wav
> $ arecord -d recordit.wav
>
> This used to work in a kernel of a few years ago, but in F11 there is a
> NOTICABLE delay from the end of the beep to the start of the recording.  It
> can even be seen if one does a simple aplay and waits for the shell prompt.
>  I was wondering if there was an option in a configuration file, or a hammer
> I can take to pulseaudio to solve this problem.
>
> An added bit of information:  The beep.wav file is about 0.1 second long
> (if that matters, which I believe it shouldn't).
>
> Any clues would be appreciated,
> Thanks.
>
>
> --
> Tom Watson
>
>
In theory,  minimum period bytes  is 128 bytes if your alsa application are
using alsa-pulse plugin


    err =
        snd_pcm_ioplug_set_param_minmax(io,
                        SND_PCM_IOPLUG_HW_BUFFER_BYTES,
                        1, 4 * 1024 * 1024);
    if (err < 0)
        return err;

    err =
        snd_pcm_ioplug_set_param_minmax(io,
                        SND_PCM_IOPLUG_HW_PERIOD_BYTES,
                        128, 2 * 1024 * 1024);
    if (err < 0)
        return err;
