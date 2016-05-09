From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: da7219: Convert driver to use
 generic device/fwnode functions
Date: Mon, 9 May 2016 15:56:00 +0100
Message-ID: <20160509145600.GA3458@sirena.org.uk>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <4783487c3caa1d66f0a1d5b25c9b341aee1118e4.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <20160506122643.GS6292@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D463C2EF@SW-EX-MBX01.diasemi.com>
 <20160506160536.GU6292@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D463C6A3@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3626901647279966034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 904242654D4
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 16:56:15 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D463C6A3@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3626901647279966034==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2016 at 12:05:56PM +0000, Opensource [Adam Thomson] wrote:
> On May 06, 2016, 17:06, Mark Brown wrote:

> > No, not really - your DT is fairly unusual in how it's done and the lack
> > of ACPI helpers is not a good sign on that side.  The _DSD things are
> > really only supposed to work for simple properties on devices.

> It's unusual in that there's a child node ("da7219_aad") of the device node, to
> encapsulate AAD specific information. The properties inside though are data only
> and simple. Actually, as I read it this is exactly the kind of thing that the
> 'Hierarchical Data Extension UUID For _DSD' is for.

If it's something that's supposed to be done I'd expect the code to be
cleaner and less driver specific.

> > > The intention was to just match against DT or ACPI and nothing else, so that
> > > didn't feel generic enough to be pushed into the fwnode framework. However
> > > I will take another look.

> > That's currently the entire set of things that fwnode supports so...

> I believe there's the FWNODE_PDATA type as well so 3 things, although I assume
> that this is to be used longer term instead of the old fashioned platform
> data mechanism, for built-in properties. Right now though I don't see much
> actual usage of this.

Well, if you do that you don't need to check if data has been provided
at all.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMKT+AAoJECTWi3JdVIfQI48H/0stE9jxY3bkSmMtewMG//eQ
jUtL8OzZu79SGMSQrf5zk4PGdCu6QxH0dYtuN+QtBOvQh81x/5lPtrGJmIWDtoYF
Z4bXIJB55cx5HB7YgXNnYNHZmIC4If2MdVvxOR4nOn0VCfNugCGtiUPM+0nWUri0
7jLvIqcSlK9jy/5uDVUC/l3uuxQ7IaRfHR5Bzt5T9ZhCEM25RVMqZ8Vu+mgPa+0t
F5kCAx+VCAOCld1Cb5dkyHnNZdY3OoFimufxSXURWVmVExwRhAFoWBpZ6IDdnUgO
FpAmV3UA59T9GlbZm9wJYmTgEAx64sC7iDu2CIu8eYmjgamL7FspCVcl+/pAFJM=
=K6WS
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--===============3626901647279966034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3626901647279966034==--
