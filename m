From: "Fengwei Yin" <yfw.bsp@gmail.com>
Subject: Re: About the buffer_time and period_time
Date: Wed, 17 Oct 2007 09:05:28 +0800
Message-ID: <fb7b9d8c0710161805s230c9398g7fee5ebea647ab@mail.gmail.com>
References: <fb7b9d8c0710160127u569d294v45693f69f51883ad@mail.gmail.com>
	<1192574879.12060.697.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-2021.google.com (hs-out-0708.google.com [64.233.178.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 55067245B0
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 03:05:30 +0200 (CEST)
Received: by hs-out-2021.google.com with SMTP id l65so369491hsc
	for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2007 18:05:29 -0700 (PDT)
In-Reply-To: <1192574879.12060.697.camel@localhost.localdomain>
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
Cc: alsa-devel@alsa-project.org, lea.li@marvell.com
List-Id: alsa-devel@alsa-project.org

On 10/17/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
>
> On Tue, 2007-10-16 at 16:27 +0800, Fengwei Yin wrote:
> > Hi all,
> > I met a problem about period_time/buffer_time on PXA with ASOC enabled.
> > The kernel version is 2.6.21.
> >
> > The Audio stream is 32k which is not supported by PXA ASOC driver.
> Please
> > refer following
> > RATES definition for PXA2xx.
> >
> > #define PXA2XX_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> >                 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
> > SNDRV_PCM_RATE_44100 | \
> >                 SNDRV_PCM_RATE_48000)
> >
>
> This may be a bug in the pxa AC97 driver as most AC97 codecs can run at
> 32k and hence drive the AC97 link at 32k. I assume your using the WM9713
> and this will request from the pxa AC97 controller when it needs PCM
> audio data in VRA mode. i.e. it will mark every 2 out of 3 AC97 frames
> (slot 3 & 4) as valid.
>
> Can you set SNDRV_PCM_RATE_32000 and give it a try, hopefully it should
> work and wont require any sample rate conversion.
>
> Liam


I tried set SNDRV_PCM_RATE_32000, the audio playback works OK. And
SNDRV_PCM_RATE_32000 should be added because the drivers instead of ASOC
have this bit.

But my understand is the default samplerate conversion will convert the
sample
rate to one supported by hardware if I remove 32k support in driver.

My test show that there are some issues in samplerate conversion. And why
buffer_time can be change to 400000 successfully if I set period_time first?

Regards
Yin, Fengwei
