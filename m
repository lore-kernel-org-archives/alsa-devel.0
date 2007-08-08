From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Possible problems with alsa soc
Date: Wed, 8 Aug 2007 11:12:59 +0530
Message-ID: <8d6898730708072242tcfd14cre5fd6abde06c1101@mail.gmail.com>
References: <8d6898730708060649q6163f65u76259c9d6e6840e1@mail.gmail.com>
	<8d6898730708070142v5097c4fdo8c997936774fb318@mail.gmail.com>
	<1186478835.3078.289.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 393D910388B
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 07:43:01 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so74773wag
	for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2007 22:42:59 -0700 (PDT)
In-Reply-To: <1186478835.3078.289.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Sudhanshu Saxena <sudhanshu.saxena@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

        Since the stream is in SNDRV_CTL_POWER_D3hot state, all
widgets are switched off. since the pop_wait is set ,
soc_pcm_prepare() will not turn on the widgets (or it will not change
the stream state to SNDRV_CTL_POWER_D0). So actual sound will not come
out.

Thanks
Nobin Mathew

On 8/7/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> On Tue, 2007-08-07 at 14:12 +0530, Nobin Mathew wrote:
> > Any way calling close() before open() is not possible, i will restate
> > it as calling close() before prepare().
> >
> > Thanks
> > Nobin Mathew
> >
> > On 8/6/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > > Hi Liam,
> > >
> > > There are some players which will call snd-pcm_close() before any open
> > > call, i dont know why they are calling this. So in ASoC it will put
> > > the stream in SNDRV_CTL_POWER_D3hot and pop_wait equal to 1. This
> > > state will make problems in snd_pcm_prepare (i.e soc_pcm_prepare).
> > >
> > > Trouble creating players and libraries are mpg123 and gstreamer library.
>
> Can you give more detail about the problems. It's not obvious from your
> message. SNDRV_CTL_POWER_D3hot and pop_wait should not stop audio
> playback starting again.
>
> Thanks
>
> Liam
>
>
