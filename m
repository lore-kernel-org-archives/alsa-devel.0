From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Fix memory leak in
	wm_adsp_setup_algs
Date: Tue, 18 Nov 2014 17:15:55 +0000
Message-ID: <20141118171555.GT22111@sirena.org.uk>
References: <1416328152-8713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3787044484935294493=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F255826047F
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 18:16:13 +0100 (CET)
In-Reply-To: <1416328152-8713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, aitdark.park@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============3787044484935294493==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
Content-Disposition: inline


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 04:29:12PM +0000, Charles Keepax wrote:
> From: JS Park <aitdark.park@samsung.com>
>=20
> If we fail to allocate memory for one of the memory regions whilst
> parsing the DSP firmware, we will leak the buffer holding the algorithm
> information. This patch ensures that this buffer is freed on all error
> paths.

I already applied this, this was a request for future patches.

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa37KAAoJECTWi3JdVIfQLuQH/1fkwqcSxODZu285su+sH7Lk
G8GHwupNV8iyEfc1xGETn+PDI3tOwGA595QoZuSEKBbcORqGH7TmRilfbk0wYZYC
luRNkpsXbV6LCLa7cS1k+x5jmb9NcZqvRCcBEjv3i/TLywbQa+Q9VaM/ipXMkllw
ZkjAPFOZbiH/+5l1Oh99YzEpIVW0pg5WDyhtuH+tPNKuuGC+qNdQh7okuZ7+zUj/
eM9qFtJzNAlYTGVSc5QyidzsaMNdQhZ/ssFnR6tb0L5nX/GQAs0ntrq5kS0b7Vwq
vDSCRsG11ZVTslVa7yZbNGjZIyndCIB3vD1pp16Goi+6ULt+6WRswf9k7O7PkXw=
=gk5b
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--

--===============3787044484935294493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3787044484935294493==--
