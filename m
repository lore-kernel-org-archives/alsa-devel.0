From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel
 constraint
Date: Tue, 26 Jun 2018 12:55:26 +0100
Message-ID: <20180626115526.GC1779@sirena.org.uk>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
 <1530008318.2900.44.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8375248840130747789=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A33152675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 14:04:01 +0200 (CEST)
In-Reply-To: <1530008318.2900.44.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jiada_wang@mentor.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============8375248840130747789==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 26, 2018 at 12:18:38PM +0200, Jerome Brunet wrote:
> On Wed, 2018-06-20 at 18:25 +0900, jiada_wang@mentor.com wrote:

> > +	/* DPCM used FE & BE merged channel */
> > +	unsigned int dpcm_merged_chan:1;

> Jiada, Mark,

> Do you think we could extend this flag to let the link choose whether the merge
> should be performed on the codec dais (as done here) or on the backend cpu dais
> ?

> I have more less the same need as Jiada but since my card uses multicodec links,
> merging on the codec dais does not work for me.

> Like in soc_pcm_init_runtime_hw(), we can't enforce channels min/max based on
> the codec when there is multiple codecs on the link.

Ugh, probably that'd work.  The ideal thing would be to remove DPCM but
we're stuck with it for the time being :(

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsyKa0ACgkQJNaLcl1U
h9B3ZQf/VDdH0OllOt1exYM3rc75dChu4BPa80cTKJP3QlUJEHbpn4Jzl8hdC4B9
dM6DDOQUlPcr8ak9WIbYX9JkYU8v04cSlEyJ5hC9g51Mosk9TvTZJE/yerq1dvYn
GRuN6eluPWnRo3fsDonNR0OjH/61LhDv32iRylqZl1nKqNXdeLYx1ftdcRJZGoSs
NTjImvM8Jt795nVMQ9hJMjfmv5kj6m7W01B2co75TEtGjkIk1Wl6zDWzf2USn6Cn
MMB7OS3qnTVQACCudOFDNqZJS8GKXx2gyiwQc+o+hzjhX7qKU2lF8vmPQnScYjgL
1hi7reNzeHQ00GovkyHlyViQnnsCfQ==
=9LN/
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

--===============8375248840130747789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8375248840130747789==--
