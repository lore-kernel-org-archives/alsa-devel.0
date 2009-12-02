From: vivek kaushik <vic.techlist@gmail.com>
Subject: Re: testing mic-in for tlv320aic33
Date: Wed, 2 Dec 2009 19:58:34 +0530
Message-ID: <1932e3c30912020628ue7bf3c0p4bc2c2ee7e41d0d1@mail.gmail.com>
References: <1932e3c30911301059s23ad8110rd5f106d44d331f71@mail.gmail.com>
	<20091201100904.b4f8f036.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f171.google.com (mail-vw0-f171.google.com
	[209.85.212.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 9208624590
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 15:28:36 +0100 (CET)
Received: by vws1 with SMTP id 1so90520vws.23
	for <alsa-devel@alsa-project.org>; Wed, 02 Dec 2009 06:28:34 -0800 (PST)
In-Reply-To: <20091201100904.b4f8f036.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Jarkko for the support.

I have applied the patch. I am kernel 2.6.29.

In my board CLKR and FSR are connected so I am calling functions as:
snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKR, 0,
SND_SOC_CLOCK_IN);
snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSR, 0,
SND_SOC_CLOCK_IN);

I checked pin muxing is also fine but still I am getting the same error.

Thanks and regards

Vivek

On 12/1/09, Jarkko Nikula <jhnikula@gmail.com> wrote:
>
> Hi
>
> On Tue, 1 Dec 2009 00:29:53 +0530
> vivek kaushik <vic.techlist@gmail.com> wrote:
>
> > Hi All,
> >
> > I am testing MIC IN on tlv320aic33. but getting the following error:
> > arecord: pcm_read:1338: read error: Input/output error
> >
> > On my custom board tlv320aic33 is connected mcbsp-1 of omap3530, i am
> > configuring tlv as mater and omap3530 as slave.aplay is working fine for
> me
> > but getting the above error in case of arecord.
> >
> > I am testing MIC IN with following command
> >
> > arecord -fdat record.wav
> >
> > when i probe signals I am getting proper MCLK, WCLK(48khz) and
> BCLK(1.5Mhz)
> > but there is no toggling on data line.
> >
> I believe the reason is that OMAP expects to get McBSP1 receiver clocks
> from its own CLKR and FSR pins. Does it work if you configure the McBP1
> receiver to use CLKX and FSX pins?
>
> You could look help from following commit and file in sound-2.6.git
> tree:
> commit d2c0bdaa9362c4b2ab7416420d034a0a2d1ec979
> sound/soc/omap/am3517evm.c
>
> --
> Jarkko
>
