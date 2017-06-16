From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: dapm: Add new widget type
 snd_soc_dapm_dsp_component
Date: Fri, 16 Jun 2017 17:52:08 +0100
Message-ID: <20170616165208.gfi4vhevzdswqjgq@sirena.org.uk>
References: <1497555964-4862-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20170616110953.waxwojvnrgrnlc26@sirena.org.uk>
 <1497615984.2561.25.camel@loki> <1497621998.2561.32.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4290238451324773780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6713C266C99
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 18:52:25 +0200 (CEST)
In-Reply-To: <1497621998.2561.32.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4290238451324773780==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o4f4rd27qjxucyjy"
Content-Disposition: inline


--o4f4rd27qjxucyjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 16, 2017 at 03:06:38PM +0100, Liam Girdwood wrote:
> On Fri, 2017-06-16 at 13:26 +0100, Liam Girdwood wrote:

> > Ok, I can redo and use specific types, but there still is a problem of
> > how do we configure a pipeline (a collection of widgets, where several
> > pipelines can make a path from PCM to DAI). This configuration data is
> > not hw/sw params type data, but more DSP scheduling type data. My
> > original thought was the pipeline widget, as there is nothing else that
> > cleanly fits into the ABI and that the pipeline scheduling data is DAPM
> > widget/graph related anyway.

> > Another alternative is extending the topology ABI and introduce a
> > pipeline object that would be ignore by the core and just used by
> > certain drivers and firmwares ?

> I think I'm tending towards having a scheduler widget now (instead of a
> pipeline widget) and that would be a valid part of the graph and also
> discoverable via debugfs etc.

Ah, I see what you're going for with that now I think.  So something
that looks in DAPM terms a bit like a supply widget (in that it's not
really part of the path itself but provides things the path needs in
order to function)?  I think that makes sense to me now too.

--o4f4rd27qjxucyjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllEDLcACgkQJNaLcl1U
h9AOXwf7BPl4GnZo70CHUjlAsVlsDEHKJ6MW3gt71yF0JUNFCJSx3ChHwFaW/nRa
NE3rgMjMOpOIZds78qzk4w3vCF4A1C1FQESRJ9uHq/Mchqov7Z5HPIT/dVeaM9Av
jRCerI5EeZUdirPJz8Xwdyz3K7LN+LMONQPjpJj1s9z4oOqx9IIGS+NfG4Sg4KYh
Y1ziphx67SvjS1PC9g7/6yKa55O3844jfrWrpOce4qKHNjz3AW9bP1Rji+JRXrRM
pTr/4qjfroL1DMS1AMJQSWJFyDnAcqrUHNn3mcJfaZ0CgIwHG00Z7Za2coPkfXcj
DBv7znZqtM5F6SnqsjwHgC8PRoGxPw==
=5TeK
-----END PGP SIGNATURE-----

--o4f4rd27qjxucyjy--

--===============4290238451324773780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4290238451324773780==--
