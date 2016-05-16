From: Trent Reed <treed0803@gmail.com>
Subject: Re: Why is the bufs argument for snd_pcm_writen not
	const?
Date: Mon, 16 May 2016 00:19:29 -0700
Message-ID: <CAL6pMWon0UjW_-pZTW7EWv3htYjXbGiRhw9bdxxkcn_Uwbg_Eg@mail.gmail.com>
References: <CAL6pMWpkgzR+dYdNy5OwH=YsQBMhsXnukPHbDndu8WQ=Q9LUQQ@mail.gmail.com>
 <s5heg927alw.wl-tiwai@suse.de>
 <CAL6pMWrqhQ9+C4Q2G9-wtG4zQ0HUTQmj2pjXtYXLaHWazh9uXQ@mail.gmail.com>
 <s5h7feu79y8.wl-tiwai@suse.de>
 <CAL6pMWof=PPBE6GnHjgmaBUeO+K8uw-XAEuRw_bG9RMcSi-=xA@mail.gmail.com>
 <CAL6pMWocp13PuNHVg85WfmHqEzJ79Cz8kDMRnVJyfPoYDpZ89w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C55222617BB
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 09:19:30 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id x201so255969446oif.3
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 00:19:30 -0700 (PDT)
In-Reply-To: <CAL6pMWocp13PuNHVg85WfmHqEzJ79Cz8kDMRnVJyfPoYDpZ89w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Absolutely!

Sorry about that, I'm used to requesting changes and not being able to make
them myself. I'll ping the thread with the patch later this week. :)

Thanks,
- Trent Reed
On May 16, 2016 12:12 AM, "Takashi Iwai" <tiwai@suse.de> wrote:

On Mon, 16 May 2016 09:06:06 +0200,
Trent Reed wrote:
>
> Thanks Takashi,
>
> I wasn't able to find anything about this in the documentation. Perhaps if
> it isn't changed in the API, it could be added as a @note for Doxygen in
> the functions?

A patch is always welcome :)


Takashi

>
> - Trent Reed
> On May 15, 2016 11:58 PM, "Takashi Iwai" <tiwai@suse.de> wrote:
>
> > On Sun, 15 May 2016 05:05:49 +0200,
> > Trent Reed wrote:
> > >
> > > Hey All,
> > >
> > > Just wondering what the reasoning is behind snd_pcm_writen not having
> > > a constant variable for bufs. To me, this doesn't make sense. Does
> > > snd_pcm_writen make any alterations to bufs? I would expect one of the
> > > following declaration:
> > >
> > > // Better, but doesn't promise that the API won't change the channel
> > pointers.
> > > snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t* pcm, const void** bufs,
> > > snd_pcm_uframes_t size);
> > > // Best, promises ALSA won't change channel pointers, wont change
> > > underlying data.
> > > snd_pcm_sframes_t snd_pcm_writen(snd_pcm_t* pcm, const void*const*
> > > bufs, snd_pcm_uframes_t size);
> > >
> > > For now, is it safe to assume that snd_pcm_writen() doesn't alter any
> > > of the data in bufs passed into it? Any chance on seeing this patched
> > > or is there some reason for this?
> >
> > We never thought of modifying the data inside the writen API
> > function.  The lack of const is merely the laziness.
> >
> >
> > Takashi
> >
> [2  <text/html; UTF-8 (quoted-printable)>]
>
