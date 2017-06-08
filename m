From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/topology 1/4]
 sound/soc/soc-topology.c:352:42: error: 'struct snd_soc_tplg_ops' has no
 member named 'widget_ready'
Date: Thu, 8 Jun 2017 17:45:04 +0100
Message-ID: <20170608164504.wjcozt5xk6qm4ywy@sirena.org.uk>
References: <201706082300.rsQ3Mduh%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6644822472428283988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F2A626725C
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 18:45:19 +0200 (CEST)
In-Reply-To: <201706082300.rsQ3Mduh%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============6644822472428283988==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6lmiuevulakakvlm"
Content-Disposition: inline


--6lmiuevulakakvlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2017 at 11:35:04PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/topology
> head:   294de6e372673229432dc8bcd80964223bc1589d
> commit: c8597af855f3e34aaebaff0e5c3dbd07611c87f1 [1/4] ASoC: topology: Allow bespoke configuration post widget creation

I've reverted this for now.

--6lmiuevulakakvlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk5fw8ACgkQJNaLcl1U
h9B7XQf9FjNwpUt1MCW6JdS66rdV9uGNwQQpcWEkdc6RPwpOP/czMDgSKmW+z2Q+
LppNf03+cNy8Ib/H3MHBnlMVnzHQAvpxSovrD/Pm6AFPpH105Mum83TtAQ3HsPbN
v+bqgLBhh/F9h2teHhOipuJJ9mnwxSYIPnwWgGOwwSfr9LNcGwhM6cmePi2LeaVQ
84MQeyegCG6mHB1WQKyU44KkL76PRYT97SndYMymBT+f+rci4ur/aMxGUeL9JL7t
dlPlb/zd6Y2IvHl6s73PfumXdja6P3IUuQrhUK1ScLgI6MRxNYgze8X1mhK5XKWS
nA/kNn10YCnPVpalE5EeavF0p5ejeQ==
=ZZil
-----END PGP SIGNATURE-----

--6lmiuevulakakvlm--

--===============6644822472428283988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6644822472428283988==--
