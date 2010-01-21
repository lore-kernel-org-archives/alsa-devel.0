From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_params_free() immediately after
	snd_pcm_hw_params() ???
Date: Thu, 21 Jan 2010 17:12:27 +0800
Message-ID: <4f3252891001210112j7ee41cdwb5b5a1f09061e003@mail.gmail.com>
References: <4f3252891001202032o59ff0bc1q79b023d80c6dcd17@mail.gmail.com>
	<s5h4omgc59e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 94A66103856
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 10:12:29 +0100 (CET)
Received: by pwi4 with SMTP id 4so10590029pwi.32
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 01:12:27 -0800 (PST)
In-Reply-To: <s5h4omgc59e.wl%tiwai@suse.de>
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

2010/1/21 Takashi Iwai <tiwai@suse.de>

>
>
> Confusingly, snd_pcm_hw_params_free() and snd_pcm_hw_free() are
> different.
>
> The former is just to free the malloced snd_pcm_hw_params struct
> while the latter corresponds to snd_xxx_hw_free().
>
>
> Takashi
>

Is there any flags in substream which can indicate snd_xxx_hw_params() was
called at first time since snd_xxx_hw_params() were called many times
during OSS emulation (probing the supported rates , channels , .... ) ?
