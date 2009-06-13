From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC
	codec:	SSM2602: assign last substream to the master when
	shutting down
Date: Sat, 13 Jun 2009 12:06:07 +0100
Message-ID: <20090613110607.GA8052@opensource.wolfsonmicro.com>
References: <20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
	<ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
	<20090613104435.GA4795@sirena.org.uk>
	<8bd0f97a0906130347x74973be2nf5c26641a09c5e24@mail.gmail.com>
	<20090613105911.GB4795@sirena.org.uk>
	<8bd0f97a0906130403k29956684j6caeae40e16b1e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B71524434
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 13:06:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0906130403k29956684j6caeae40e16b1e6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Karl Beldan <karl.beldan@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2009 at 07:03:12AM -0400, Mike Frysinger wrote:

> the first part conditionalized the constraints.  ignoring whitespace
> changes, this is the diff:
> +if (master_runtime->rate != 0)
>     snd_pcm_hw_constraint_minmax(substream->runtime,
>     ......
> +if (master_runtime->sample_bits != 0)
>     snd_pcm_hw_constraint_minmax(substream->runtime,
>     ......

> or maybe that is what you're saying and i dont know alsa

That's not a bad change - there's a thin race condition if you
simultaneously start up two applications where the primary substream
could be there but not yet configured since stream startup is separate
to the configuration of the stream.  It's hard but not impossible to
reproduce.
