From: Borg Onion <borg.onion@gmail.com>
Subject: Re: PCM usage / seg fault in pcm_params.c
Date: Thu, 24 Nov 2011 12:29:14 -0800
Message-ID: <CAAs5ODsooDR6byLpiGyhjsG9yVdS3QbPr4THqf=zGpr-GLgyPA@mail.gmail.com>
References: <CAAs5ODsSYHW7GM8ia050=T0-HSQuGieCRUCnR-nB_t_yWXf9DA@mail.gmail.com>
	<4ECE48BB.4090600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C1ED1103A90
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 21:29:17 +0100 (CET)
Received: by ggnq2 with SMTP id q2so3050107ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 12:29:14 -0800 (PST)
In-Reply-To: <4ECE48BB.4090600@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> > Program terminated with signal 11, Segmentation fault.
> >
> > Sound card is opened, PCM device is opened,
>
> Is it?
>
> ...
> Found PCM device #1
> Playback=no, Capture=yes, Full Duplex=no
> Playback capabilities:
> Segmentation fault
>

You're right, my bad.  Fixed now.  Still, an assert() in the lib wouldn't
hurt.  They seem to be thoroughly applied for everything else.  That same
function in the lib asserts already, so here's my proposal to modify the
assert call:

int snd_pcm_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
{
        int res;
#ifdef REFINE_DEBUG
        snd_output_t *log;
        snd_output_stdio_attach(&log, stderr, 0);
#endif
        assert(pcm && pcm->ops && params);
#ifdef REFINE_DEBUG
        snd_output_printf(log, "REFINE called:\n");
        snd_pcm_hw_params_dump(params, log);
#endif
        res = pcm->ops->hw_refine(pcm->op_arg, params);
#ifdef REFINE_DEBUG
        snd_output_printf(log, "refine done - result = %i\n", res);
        snd_pcm_hw_params_dump(params, log);
        snd_output_close(log);
#endif
        return res;
}


--BO
