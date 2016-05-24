From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4 v7] ASoC: dwc: Add PIO PCM extension
Date: Tue, 24 May 2016 18:51:44 +0100
Message-ID: <20160524175144.GO8206@sirena.org.uk>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
 <20160524164151.GM8206@sirena.org.uk>
 <57448A42.9050606@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8540459773616940714=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74601265353
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 19:51:57 +0200 (CEST)
In-Reply-To: <57448A42.9050606@synopsys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8540459773616940714==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e4annfiqlsPm5rKd"
Content-Disposition: inline


--e4annfiqlsPm5rKd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 24, 2016 at 06:07:14PM +0100, Jose Abreu wrote:
> On 24-05-2016 17:41, Mark Brown wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> >>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> >>  		i2s_write_reg(dev->i2s_base, ITER, 1);

> > That seems wrong, or at least something that should be separate?
> > Previously we needed interrupts for DMA operation but now we enable
> > interrupts only if we don't use DMA.  It feels like we want to make the
> > change for DMA separately if only to make it clear for bisection, are we
> > 100% sure that masking the interrupt won't also mask the DMA request
> > signals?

> Indeed I thought about this and the interrupts must also be enabled when in DMA
> mode. Although there is no interrupt handler in the original driver (without
> this patches) in some setups the interrupt line may be connected to the DMA
> controller. I will drop this change and always enable interrupts. Please note
> that I don't have a setup with DMA support so I can only test using the PIO mode.

Presumably you can talk to your hardware colleagues and get them to make
you a FPGA with a DMA IP available?

> > This also seems wrong.  We're forcing PIO if an interrupt is provided
> > rather than based on DMA being configured which means that if the
> > interrupt is wired up and happens to be described in DT we'll get worse

> How should I then determine which mode to use?
>     - Check if DMA parameters are declared in DT, or
>     - Check if snd_dmaengine_pcm_register() fails, or
>     - Assume PIO mode will be used when compiling with PIO PCM, or
>     - Something else ?

You could either unconditionally register the PIO driver and only
actually start using it if the driver is instantiated or you could check
to see if the registration function works (handling deferred probe - if
the DMA driver just didn't load yet you should wait for it).

--e4annfiqlsPm5rKd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRJSuAAoJECTWi3JdVIfQpvcH+gN1sSN56xpO+uJP/BdBnT9b
5fBAce+i5r4N7oxJVemTw9LG2sBTtgcXGd28xlPWCSqASSMLxBHaz7lRz5wOeiZV
HClxoM7BuSZOYMiMivzq7CTxrp8Nnbikkq5D/OCeKVH14aK8/0fuPBMZDc4MMxkJ
9TKCIifQcsYl92i2G2T7CKL5dUZPGuXmZUwYomEs9S4+ZGnwMBhRUkSb1hE0fqyj
jYssUuZFiFMu7v7UcuhFy4Gi63eMxdgPW6CGx5NGYlWb497elU0e69rofhG7EkP2
+s1NhOI4QLJFlBel5GXfQYf0OF/mfi9O9jCtY0m6h/VNMPpcrQJzr+H1XAovUT0=
=jw38
-----END PGP SIGNATURE-----

--e4annfiqlsPm5rKd--

--===============8540459773616940714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8540459773616940714==--
