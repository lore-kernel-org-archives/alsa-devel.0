From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Clean up DAPM before the card
	debugfs
Date: Fri, 19 Aug 2016 18:50:03 +0100
Message-ID: <20160819175003.GE22076@sirena.org.uk>
References: <1471545449-29516-1-git-send-email-broonie@kernel.org>
 <20160818232642.GF1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6164057239760375128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 687D92665F9
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 19:50:16 +0200 (CEST)
In-Reply-To: <20160818232642.GF1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6164057239760375128==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2016 at 12:26:42AM +0100, Russell King - ARM Linux wrote:

> So this allows me to test a bit more... and there's more bad news.
> On re-inserting this module...

> Looks like removing and re-inserting these modules has never been
> tested. :(  And oh my...

> static int omap_mcpdm_probe(struct snd_soc_dai *dai)
> {
>         ret = devm_request_irq(mcpdm->dev, mcpdm->irq, omap_mcpdm_irq_handler,
>                                 0, "McPDM", (void *)mcpdm);

> static struct snd_soc_dai_driver omap_mcpdm_dai = {
>         .probe = omap_mcpdm_probe,
>         .remove = omap_mcpdm_remove,

> Using devm_* stuff in a context where it doesn't get automatically
> freed when the DAI driver is unbound, and nothing in omap_mcpdm_remove()
> to undo that request.

Yes, that's obviously bad - and in any case we should request resources
at the device model level regardless of that.

> I suspect that isn't the full story though, because of the regmap
> complaint (which I've not even looked at yet.)

Missed that one?

> Maybe we should have a test mode in the kernel where every device
> goes through a bind-unbind-rebind sequence during boot to test more
> of these paths...

That actually came up independently the other day during the Kernel
Summit discussions, Rob Herring gave it a bit of a go but I'm not sure
if he did it with a view to upstreaming or anything.  It's definitely a
good idea, as I said on that thread I think deferred probe has been one
of the best things to ever happen to kernel error handling and this
would just extend it.

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXt0bKAAoJECTWi3JdVIfQJwkH/Aw+GhwB9Bqnseym16JNLaAO
7E1ieKDX8d8fFRwGb+mPfgRdXPCnTVTViPs/mLx7u4ACtCoHPOpATG3myiSPFnjb
u5mzYti+FLCWb8nDcb/Q0Ks5E10RHTtzEGF57PBbBmMIQge2b+6eGx1mxW90XXDF
cKsoBWqE/FooUAPHXamHG9FrZCiIVjJernx20r7B2I2Xr50cEYj2HMIMAedMkSaG
iZ9qZssLZ3g+CycI4sbLcRXVBdXEib2iNIPxM4u73Vs+OneyTVjzlB1HJIPF4lBX
/ixKmg3Vz38YYjAjZmeEzqDh3eKWkhvc7fIY5U/ELwJDE/0AMLoVQTtlhFeR/ms=
=cXb2
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

--===============6164057239760375128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6164057239760375128==--
