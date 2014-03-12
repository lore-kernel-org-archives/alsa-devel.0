From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: simple-card: overwrite DAIFMT_MASTER of
 cpu_dai->fmt
Date: Wed, 12 Mar 2014 10:01:24 +0800
Message-ID: <20140312020123.GC1177@MrMyself>
References: <1394542472-16580-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140311132553.GR28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140311132553.GR28112@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, Li.Xiubo@freescale.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 11, 2014 at 01:25:53PM +0000, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 08:54:32PM +0800, Nicolin Chen wrote:
> 
> Adding Jyri who's been looking at this as well but not added anyone else
> working on simple-card so you might've missed his mails.
> 
> > It's pretty fair to do it for DAIFMT_INV since two dais might have differnt
> > definitions in their drivers even though it'd be better to keep it same if
> > we could.
> 
> No, that's not at all OK - anything that requires this is broken.  The
> same DAI format should be usable by both ends of the link unless the
> board itself is inverting one of the signals or something.

That makes sense to me. Okay, I'll overwrite them all...

> 
> > Thus this patch fixes it by overwriting the DAIFMT_MASTER bit of cpu_dai->fmt
> > with the one of codec_dai->fmt since we defined DAIFMT_MASTER basing on CODEC
> > at the first place.
> 
> This seems closer to what I'd expect for something like this but it does
> mean that any format settings on the CPU DAI will be ignored (rather
> than say warning or something).  I'm not sure this is a bad thing
> though, probably wants the binding documenting at least.

...along with the binding doc.
