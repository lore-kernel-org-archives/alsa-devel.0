From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] Introduce dmic mode switch delay
 parameter
Date: Wed, 24 Oct 2018 14:40:30 +0100
Message-ID: <20181024134030.GS2103@sirena.org.uk>
References: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
 <102a22bc-a054-b07d-23c8-95118d69450f@linux.intel.com>
 <108f2ff1-c000-31ba-0a36-e696a912c6e6@linux.intel.com>
 <20ADAB092842284E95860F279283C564568C0050@BGSMSX104.gar.corp.intel.com>
 <a07a0b87-d9ee-f5f9-6a81-6ec2379e1a5f@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6312171710323283847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DD982678F7
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 15:40:35 +0200 (CEST)
In-Reply-To: <a07a0b87-d9ee-f5f9-6a81-6ec2379e1a5f@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Matthias Kaehlcke <mka@chromium.org>, "Tc, Jenny" <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6312171710323283847==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5G+Imvfxoe+o1e80"
Content-Disposition: inline


--5G+Imvfxoe+o1e80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2018 at 01:22:18PM -0500, Pierre-Louis Bossart wrote:

> ok, but not sure what to define. You don't want too many identifiers either,
> this generated lots of patches for no good reason. What are the needs here?
> You probably don't want to identify the DMIC vendor so this could be an
> Intel-defined ID. But I wonder if this might be reused on AMD platforms?

There's nothing stopping AMD systems using the Intel device IDs.  We
already get some of that with the other non-Intel components that have
been assigned Intel IDs due to their presence on Intel reference
systems.

> Changing the dailink to point to one device instead of another is not a good
> idea, the machine driver should be independent from all this, and be
> reusable between the SKL driver or SOF drivers. The last thing you want is a
> hack in there.

The firmware binding really ought to be OS neutral, never mind driver
neutral :(

> ok, makes sense. Do you think it'd be possible to use ACPI initrd overlays
> to add support for those parameters if they don't natively exist in the
> BIOS?

Don't know about that (I'm not familiar enough with how this stuff gets
shipped on x86 systems) but the traditionl solution for ACPI appears to
be to have DMI based quirks.

--5G+Imvfxoe+o1e80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQdk4ACgkQJNaLcl1U
h9CmVAf/bijeJHy1C/cPDV/iWVb+bwoEqO5t/jYDGbFfUN52tgqoW78NLq/TFP2L
TMvqXrHf+qacxEtfmjHovvBFhCJAIQxYleX9LVOX3GjXMp/ay03Erv/ldQlj7V22
OJup8bciNlrfTa602HVRGqn5Hgqw2ZB2M52a2hliK+XLZOn7m8vN0yFwDjlekw7e
XdpLYxwCdBLPM/iYOl92mKdX9nYnnlK4Asm5dJH1mJ3yCqA54ZPi2wCVvPq4qR8+
cQvs8B1ekvQLZqqd9tuR+inWYl1tmzJCjZF005tztIo8h0KIb7HjVIAEbb/XfDWm
O5fQKxTkqJiHlGD/pVlpm/VD9x34Jw==
=lsn9
-----END PGP SIGNATURE-----

--5G+Imvfxoe+o1e80--

--===============6312171710323283847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6312171710323283847==--
