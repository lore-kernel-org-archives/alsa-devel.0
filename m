From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Possible problems with alsa soc
Date: Tue, 07 Aug 2007 10:27:15 +0100
Message-ID: <1186478835.3078.289.camel@localhost.localdomain>
References: <8d6898730708060649q6163f65u76259c9d6e6840e1@mail.gmail.com>
	<8d6898730708070142v5097c4fdo8c997936774fb318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 00272103867
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Aug 2007 11:27:16 +0200 (CEST)
In-Reply-To: <8d6898730708070142v5097c4fdo8c997936774fb318@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Sudhanshu Saxena <sudhanshu.saxena@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-08-07 at 14:12 +0530, Nobin Mathew wrote:
> Any way calling close() before open() is not possible, i will restate
> it as calling close() before prepare().
> 
> Thanks
> Nobin Mathew
> 
> On 8/6/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > Hi Liam,
> >
> > There are some players which will call snd-pcm_close() before any open
> > call, i dont know why they are calling this. So in ASoC it will put
> > the stream in SNDRV_CTL_POWER_D3hot and pop_wait equal to 1. This
> > state will make problems in snd_pcm_prepare (i.e soc_pcm_prepare).
> >
> > Trouble creating players and libraries are mpg123 and gstreamer library.

Can you give more detail about the problems. It's not obvious from your
message. SNDRV_CTL_POWER_D3hot and pop_wait should not stop audio
playback starting again. 

Thanks

Liam
