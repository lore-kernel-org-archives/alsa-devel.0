From: Mark Brown <broonie@kernel.org>
Subject: Re: Missing return check of of_property_read_*()
Date: Thu, 10 Sep 2015 19:19:41 +0100
Message-ID: <20150910181941.GJ20922@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <alpine.DEB.2.10.1509090954430.3157@heelroid>
 <s5hfv2nd45t.wl-tiwai@suse.de>
 <20150909155737.GB20922@sirena.org.uk>
 <s5hvbbjbmzx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2504250518492344729=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C61BD260672
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 20:19:52 +0200 (CEST)
In-Reply-To: <s5hvbbjbmzx.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2504250518492344729==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYo4Elh1vtcYNvbq"
Content-Disposition: inline


--zYo4Elh1vtcYNvbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2015 at 06:01:22PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It'll be because nobody is checking !OF ASoC configurations and paying
> > attention to warnings - with !OF the functions are inline in the header
> > and the compiler can tell nothing happens.

> Yes, but non-OF ASoC gets more popular on x86 nowadays, so this should
> be covered regularly, too.

We should start getting some coverage for this from kernelci.org soon
(and x86 allmodconfig with OF disabled).

--zYo4Elh1vtcYNvbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8cm8AAoJECTWi3JdVIfQRdUH/04WZ2VofJ6Lgqybo+jbSvze
wqFY2ssKQlSKltsWfutplFgz5AWTvBOI5X7GN088ePGKzdYfkOoX9dqIbpo+SRCl
jtBicKGwLwjMJ7dzRwpA+ax9uTjUT9hD24Km7uZZLlI8LN9XuUSsg23O578Alq58
uAWkJAbiCva0lLXeCYStTeDmgiwzNzS9sxRh9HMJAxG2WneiHkAx+NLbMa3QjfZp
IhREFGJ8lxqxhfOkRiISiQ5pARdNwqBHQF0Nf3qWiVGOz1KbZblEZ1fjt7z4Mfg/
KhGqubTWUvb8/i4fCrIQzwq47+ndBpZILUQzMos7/5IuRIhCVAZpAesgxI/PNMY=
=8ahD
-----END PGP SIGNATURE-----

--zYo4Elh1vtcYNvbq--

--===============2504250518492344729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2504250518492344729==--
