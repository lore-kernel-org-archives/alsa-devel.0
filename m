From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: About the buffer_time and period_time
Date: Tue, 16 Oct 2007 23:47:59 +0100
Message-ID: <1192574879.12060.697.camel@localhost.localdomain>
References: <fb7b9d8c0710160127u569d294v45693f69f51883ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id B53EF244C5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 00:48:01 +0200 (CEST)
In-Reply-To: <fb7b9d8c0710160127u569d294v45693f69f51883ad@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fengwei Yin <yfw.bsp@gmail.com>
Cc: alsa-devel@alsa-project.org, lea.li@marvell.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-10-16 at 16:27 +0800, Fengwei Yin wrote:
> Hi all,
> I met a problem about period_time/buffer_time on PXA with ASOC enabled.
> The kernel version is 2.6.21.
> 
> The Audio stream is 32k which is not supported by PXA ASOC driver. Please
> refer following
> RATES definition for PXA2xx.
> 
> #define PXA2XX_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
>                 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
> SNDRV_PCM_RATE_44100 | \
>                 SNDRV_PCM_RATE_48000)
> 

This may be a bug in the pxa AC97 driver as most AC97 codecs can run at
32k and hence drive the AC97 link at 32k. I assume your using the WM9713
and this will request from the pxa AC97 controller when it needs PCM
audio data in VRA mode. i.e. it will mark every 2 out of 3 AC97 frames
(slot 3 & 4) as valid.

Can you set SNDRV_PCM_RATE_32000 and give it a try, hopefully it should
work and wont require any sample rate conversion.

Liam 
