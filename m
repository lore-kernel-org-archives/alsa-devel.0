From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Fri, 1 Feb 2019 08:39:55 -0800
Message-ID: <CACL=Q7w+xR+vZT+oMV-nbav8WP=c+6KetfFCyGW+b437U8QGug@mail.gmail.com>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
 <s5hsgx9ckrf.wl-tiwai@suse.de> <20190131122624.GA20797@sirena.org.uk>
 <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
 <CACL=Q7ykqDEsaJzcxVexaaNCukw4yiNNQSGZLON=fXbJ7AH-9g@mail.gmail.com>
 <CACL=Q7y==PFTdknurbg-yZPoBjYh6n5Lduyy32Us1HepeVU-bg@mail.gmail.com>
 <CAEiLdJb-QLmtp0vWxvCj6Kb3rmkEx8dKndmBovHvx7hk93pt_Q@mail.gmail.com>
 <s5h36p8d0v8.wl-tiwai@suse.de> <7d46e614-9291-a95a-6216-8abe9e6f1a5d@perex.cz>
 <20190201130117.GF20797@sirena.org.uk>
 <CACL=Q7wkh4h4YNrLUS8ihBqkc-t3-B1x2s1n_f9WP_B=oRyGJg@mail.gmail.com>
 <4901c6a6-605e-4f43-ff38-eb492495a3c9@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
 [209.85.166.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D5443267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 17:40:08 +0100 (CET)
Received: by mail-it1-f193.google.com with SMTP id g85so10030377ita.3
 for <alsa-devel@alsa-project.org>; Fri, 01 Feb 2019 08:40:08 -0800 (PST)
In-Reply-To: <4901c6a6-605e-4f43-ff38-eb492495a3c9@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, =?UTF-8?B?WmFjaCBSaWdnbGUg8J+Wlg==?= <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the clarification. I was thinking the anon_inode:snd-pcm FD
replaced the /dev/snd/pcm FD.

> fd1 - /dev/snd/pcm (HAL) - standard sound device inode (no restrictions)
> fd2 - anon_inode:snd-pcm-buffer (for the EXCLUSIVE access)

That sounds right.

Thanks again for this work. ALSA is very important for Android Audio.

Phil Burk


On Fri, Feb 1, 2019 at 8:28 AM Jaroslav Kysela <perex@perex.cz> wrote:

> Dne 1.2.2019 v 16:31 Phil Burk napsal(a):
> > Thank you all for sorting this out. It seems like we are moving in a
> > really good direction.
> >
> >> I agree. We can have just two modes for the beginning:
> >> a) full one (useful for testing)
> >> b) buffer only (allow just sound data mmap)
> >
> > The full one is would also be used by the HAL for querying the DSP
> position.
> >
> >>  if we should use different names (like anon_inode:snd-pcm and
> > anon_inode:snd-pcm-buffer)
> >
> > That would be helpful.
> >
> > I have attached a revised requirements doc. The original doc was more of
> > a HowTo for OEMs to create the "anon_inode:dmabuf" FD.. This clarifies
> > the requirements and allows for the use of "anon_inode:snd-pcm*". It
> > should match what we have arrived at by discussion. Let me know if it
> > makes sense.
>
> It looks fine, but the HAL will use probably the standard sound device
> open (/dev/snd/), doesn't? So:
>
> fd1 - /dev/snd/pcm (HAL) - standard sound device inode (no restrictions)
> fd2 - anon_inode:snd-pcm-buffer (for the EXCLUSIVE access)
>
> With modes, I talked about the anonymous dup ioctl parameter. If there's
> another resource manager above HAL, the situation might be:
>
> fd1 - /dev/snd/pcm (resource manager) - standard sound device inode
> fd2 - anon_inode:snd-pcm (access to the full pcm sound API using the
> anonymous inode)
> fd3 - anon_inode:snd-pcm-buffer (for the EXCLUSIVE access)
>
> Perhaps you have different layers in Android.
>
>                         Thanks,
>                                 Jaroslav
>
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>
