From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dwc: disallow building
	designware_pcm as a module
Date: Tue, 18 Apr 2017 18:15:19 +0100
Message-ID: <20170418171519.csiftftd434psyn5@sirena.org.uk>
References: <20170418105954.23368-1-lkundrak@v3.sk>
 <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7089929338550507423=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D20E4266BC1
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 19:15:32 +0200 (CEST)
In-Reply-To: <1492532010.28092.12.camel@v3.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============7089929338550507423==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dk3hqasakxi55qak"
Content-Disposition: inline


--dk3hqasakxi55qak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 18, 2017 at 06:13:30PM +0200, Lubomir Rintel wrote:

> I don't think designware_pcm is a separate driver. It looks tightly
> coupled with designware_i2s: you can either disable designware_pcm
> altogether at build time or always load it together with
> designware_i2s.

Yes, they're closely coupled but we might still want them both as a
module.

--dk3hqasakxi55qak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj2SaYACgkQJNaLcl1U
h9BF5Qf/csQ3YSCJ7J56qZYYPSdpokbmobpYSw25qmGdIALSfxwvVKeKQCiouE54
VZN7nZwX7IjcWLnutLRNxIe8+PTtbH+H1gV6Lu14TpZbb3OzTdbx7LKJpUMbL1RF
mx665O3omLzPES7JhfNQayQJbCDr1cbRVWOA95SqqnSCTpxQKL3K3QmzifmHpa1r
IbaixHet/C2JjDQDVWPENFGy7Pn2VfXuzlXkVOfrzssIJFTNDzGDkHNdUMxRfzVq
U24fdgKyTLTxz/9R2fXC7b1bm+zYJ9/Pm+riwHHShr8NTUalNTJRdomvFjDT81BE
7d4JPcXFXqvvg9ZiR16yQ5/NxM3KCA==
=YXGw
-----END PGP SIGNATURE-----

--dk3hqasakxi55qak--

--===============7089929338550507423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7089929338550507423==--
