From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: wm_adsp: Fix some subtle races
 on compressed stream
Date: Tue, 29 Mar 2016 10:10:25 -0700
Message-ID: <20160329171025.GX2350@sirena.org.uk>
References: <1459171764-29921-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1459171764-29921-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2448439519044484090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C19D2668DC
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 19:10:30 +0200 (CEST)
In-Reply-To: <1459171764-29921-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2448439519044484090==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3rzwkXnKuCXxoL5m"
Content-Disposition: inline


--3rzwkXnKuCXxoL5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 28, 2016 at 02:29:22PM +0100, Charles Keepax wrote:
> Firstly, we should be locking the pwr_lock when we initialise the
> compressed buffer. Secondly, fixup a couple of places when we should be
> pulling pointers only under the pwr_lock as they may be affected by
> operations that take that lock.

This looks like it's a bug fix, it should be at the start of the series
so it can be sent as a fix without depending on other changes.

--3rzwkXnKuCXxoL5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+rcAAAoJECTWi3JdVIfQzOkH/j8pPquSR4KUFqv9SOqYW48F
ZYxbsF1/s9tM0/oaoHJT1lWPhP5UgXges6cpNvQPCGSylBbEud1L1QIwvJ1pTRzU
J41RZ0VRGPPUp4+9HbKtqom36lYZnt6FCQMNmxMKA+1geU0rsCywK7jChZ1RFv6t
p8ZJVPs+cS76umKOxEDkVdnNNN3EPtdbhL2XJQeEbbu5bN3986R4NsWH396NuwPD
iiaKYS44in4xyMNxSW+IeS6RL84k3rqFQ/lx82L57UW7I8TiahbF2ZkNr5qkPUjQ
6fiRVn+272h2erDfhPSFdhGaJcdg5B3xv1yxSA3DCNfiLwrhUmvu/eKBeEmQH3A=
=QNz6
-----END PGP SIGNATURE-----

--3rzwkXnKuCXxoL5m--

--===============2448439519044484090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2448439519044484090==--
