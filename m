From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8993: amp control, amplifying pops.
Date: Tue, 11 May 2010 12:12:26 +0100
Message-ID: <20100511111226.GB30780@rakim.wolfsonmicro.main>
References: <v2jcf7b913c1005091910hf7b32843sc71b09b801b8649e@mail.gmail.com>
	<20100510102422.GD31804@rakim.wolfsonmicro.main>
	<AANLkTilrdLPRHI5_4K1C0NHDtonJQzelc6CwW97vuboM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57EC0247D6
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 13:12:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilrdLPRHI5_4K1C0NHDtonJQzelc6CwW97vuboM@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zhang JieJing <kzjeef@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 11:07:38AM +0800, Zhang JieJing wrote:
> 2010/5/10 Mark Brown <broonie@opensource.wolfsonmicro.com>

> Hi, Our kernel version is 2.6.28, but port the wm8993 driver to this
> version's kernel.

Normally in these situations I would recommend backporting the entire
ASoC subsystem - it's fairly well isolated from the rest of the kernel
so this tends to be reasonably straightforward.

> the amplifying pop is when system resume, the speaker will hear one
> short pop noise,
> also, this short pop noise will hear the first time driver is opened.

When exactly do you hear this noise?  The WM8993 driver will not power
up the speaker outputs unless they are in use and there are no audio
paths configured to the speakers by default.  Are you configuring an
audio path in the CODEC at system startup?  Which mode do you have the
WM8993 speaker drivers in - class D or class A/B?

It might be helpful to capture all the register writes done when
bringing up the WM8993.  Also, if you are configuring an audio path from
an analogue input you should check that there is no DC offset present in
the input signal - if there is one then the WM8993 will reproduce it
into the output path, which would result in an audible noise.

> In 53242c68333570631a15a69842851b458eca3d99,
> there was a line:
> 
> +		ret = wm8993_set_fll(codec->dai, 0, wm8993->fll_src,
> +				     fll_fref, fll_fout);
> +

> but in lastest version of wm8993 driver, wm8993_set_fll will do
> nothing we the second parameter(fll_id) is 0,  so, I don't know what
> this function want to do,
> Cound you give me some idea ?

This parameter specifies which of the FLLs/PLLs in the device to
configure.  Since the WM8993 has only one FLL it just ignores this
parameter, other devices with multiple FLLs such as the WM8994 need this
to select between the FLLs.
