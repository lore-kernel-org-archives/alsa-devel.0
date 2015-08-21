From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V5 3/3] ASoC: AMD: add AMD ASoC ACP-I2S
 driver
Date: Fri, 21 Aug 2015 09:17:16 -0700
Message-ID: <20150821161716.GD12027@sirena.org.uk>
References: <1440106594-29564-1-git-send-email-alexander.deucher@amd.com>
 <20150820231848.GX12027@sirena.org.uk>
 <CANv6ZMb9f-kaAUfcUka9T-0XLdG_0eNMVD8YvJNbN=fHEGMRPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3394800455951747927=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98A712604EB
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 18:17:30 +0200 (CEST)
In-Reply-To: <CANv6ZMb9f-kaAUfcUka9T-0XLdG_0eNMVD8YvJNbN=fHEGMRPw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3394800455951747927==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p1zxN+PsucbyOM2v"
Content-Disposition: inline


--p1zxN+PsucbyOM2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2015 at 05:21:07PM +0530, maruthi srinivas wrote:
> On Fri, Aug 21, 2015 at 4:48 AM, Mark Brown <broonie@kernel.org> wrote:

> > We already have a driver for the DesignWare I2S controller.  To repeat
> > the concern I raised in a slightly different bit of the code last time:

> > | This doesn't appear to be a designware-i2s driver, we already have one
> > | of those?

> Our IP block includes few AMD IPs along with DesignWare I2S IP.  I have reused
> code from Designware I2S controller from
> sound/soc/dwc/designware_i2s.c and because
> of the way IPs are coupled together, I couldn't use existing
> Designware I2S driver as is.

Could you be more specific about the way in which the IPs are coupled
and the problems this causes please?

> I have given credit to the original author in DRM patch copyright
> header, where register I2S read/writes
> are made. Do I need to add the same header in ASoC driver too ?

What I'm looking for is actual code sharing where we use the same code
for the I2S controller block or a clear and documented understanding of
why it is not possible to share things.

> Oh! I freed  in dma_close(), that were  allocated in dma_open(). Rest
> of them  used devm_*

OK.

> > > +             /* Now configure DMA to transfer only first half of System RAM
> > > +              * buffer before playback is triggered. This will overwrite
> > > +              * zero-ed second half of SRAM buffer */
> > > +             acp_dev->config_dma_channel(acp_dev, SYSRAM_TO_ACP_CH_NUM,
> > > +                                     PLAYBACK_START_DMA_DESCR_CH12,
> > > +                                     1, 0);
> >
> > | Why?  The comments describe what's happening but it's not clear why it's
> > | happening.

> The reason for doing this is :  When C completes rendering, calls
> period_elapsed() and informs
> ALSA core there is free space to fill new data to system memory. In
> the same irq handler, B is
> DMA'ed to C to be ready by the time D completes rendering with
> prefetched data (in trigger()).
> when D completes rendering, new data fetched by ALSA core can be
> DMA'ed  from A to D and
> rendering is continued with C. This is done cyclically.

My point here is that the internal documentation in the driver should be
improved so that someone reading the code can tell why this is being
done.  It doesn't need to be this full explanation but at least enough
for people to be aware of the general issue.

> > > +static struct snd_soc_dai_driver i2s_dai_driver = {
> > > +     .playback = {
> > > +                  .stream_name = "I2S Playback",
> > > +                  .channels_min = 2,
> > > +                  .channels_max = 2,

> > Elsewhere support for 8 channels was declared and handled.

> The board for which driver is developed, doesn't support more than 2 channels.

This is a driver for the IP, not for the board - you may not be able to
test everything but code should try to be as general as it can be.

--p1zxN+PsucbyOM2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV108IAAoJECTWi3JdVIfQD5kH/0EAbdsNykOv1XvdbKRDLOO5
LrUXKSTORE0oeGnp1pAEUUY85yUJ4kIeoZlFUV7lm9UUaBWXtqPRtmI1aq0iVCgv
Ud3dypam42fMP8VOsEbODZxLFgFHEt/zzp0s2YaBGd2dC1eXyeVtmDCie66IYNUV
HARYGa9Tm+m0vcIRAUeSQstrUNpIwkKodBssQ8fZrXGsSXyaB0iQ/pUXRimaqryS
2Ma2TiVKlG5Eg0TA+6gXHHi8PV3LKfYXr6rYRVCJ+dWA7PzlQIwU5b3lRVBFUrT6
r3TnlX6ZEskrvkLqy9QZ87dW03MbXWbVZDi78A0rtyjm/CQ9xDGyS4KzwNgk88A=
=eMmc
-----END PGP SIGNATURE-----

--p1zxN+PsucbyOM2v--

--===============3394800455951747927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3394800455951747927==--
