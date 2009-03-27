From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 1/2] alsa: ASoC driver for s6000
	I2S	interface
Date: Fri, 27 Mar 2009 16:20:49 +0000
Message-ID: <20090327162048.GA7542@sirena.org.uk>
References: <1238074574-24734-1-git-send-email-dg@emlix.com>
	<20090326141503.GD3771@sirena.org.uk> <49CCFA24.3020203@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4232C103881
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 17:20:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49CCFA24.3020203@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 27, 2009 at 05:09:08PM +0100, Daniel Gl=F6ckner wrote:
> On 03/26/2009 03:15 PM, Mark Brown wrote:

> > I'm not seeing any hits on XTENSA_VARIANT_S6000 in next?  While that
> > shouldn't hurt immediately since it'll just never appear it'd be good to
> > make sure that the APIs this depends on are going into mainline in the
> > form they're in.  Do you know what the status is there?

> The patch introducing XTENSA_VARIANT_S6000 has already been reviewed by
> the architecture maintainer and there is hope that it will make it into
> 2.6.30. The dma api, which we posted four days ago to LKML, has not
> received any comments so far.

OK, might be worth nagging the architecture maintainer to get their tree
included in -next if it isn't already.

> >> +#define S6000_I2S_RATES	(SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_K=
NOT | \
> >> +			 SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000)
> > =

> > SND_PCM_RATE_KNOT doesn't work with ASoC (though it shouldn't do any
> > harm since it'll just get removed).

> Except for the maximum bit clock (50 MHz) the interface doesn't care about
> the sampling rate, so I put in all SNDRV_PCM_RATE_* constants.
> Shall I remove it?

Yes, please - this applies to almost all CPU side drivers, it's kind of
unfortunate but in practice it generally makes very little practical
difference since applications tend to use one of the standard audio
rates.

> > Any reason to expose these to users? =


> This was an attempt to avoid symbol exports..
> I'll move everything to s6000-i2s.c and export the three necessary
> functions.

Which functions are you exporting?  None of this looked like anything
that I'd expect to see used outside of the driver.
