From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 07/11] ASoC: topology: Add support to
 configure existing physical DAI links
Date: Fri, 4 Nov 2016 11:22:21 -0600
Message-ID: <20161104172221.wrqkh24nkih6rihm@sirena.org.uk>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
 <6bc394d703dcaf3afbb8bf35c8dc983360fc7cd0.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5692864588369524280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CAAD2674C0
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:22:34 +0100 (CET)
In-Reply-To: <6bc394d703dcaf3afbb8bf35c8dc983360fc7cd0.1478071138.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5692864588369524280==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iwiytekcfwv7xt7"
Content-Disposition: inline


--2iwiytekcfwv7xt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 03, 2016 at 01:04:27AM +0800, mengdong.lin@linux.intel.com wrote:

> +	name = strlen(cfg->name) ? cfg->name : NULL;
> +	stream_name = strlen(cfg->stream_name) ? cfg->stream_name : NULL;

Please replace these with normal if statements.  Also, are we sure that
we've sufficiently audited the input paths to ensure that the strings
are always terminated?

--2iwiytekcfwv7xt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHMPMAAoJECTWi3JdVIfQabAH/iDJ4+vt0i2oyhPkEgbXeO9j
+iC4k5LQ/8bZwYrxbMuaH7XGA1ObnhiJCuQ01hyUDuZQcq27o1TsZgouDFCBLSOU
//j4xVitwv8BS9+R8K/0GiDzDNkAa9l2yaNM2d6GvNsWscQaieixNNJqlj8hlQVY
PoDDucv38ZZX2G7EMbdRzgPZLqEQDpIag2unfDYTP8932Tk+iEZQ3E2b1yvJ+oHG
4nNvxwYidqGFcjVu3VvFwhz1WWD5z+i86GDj/HnEuS1c6g6obsxWwsNrm/U0T9DC
uZird8aRsUDFK+GekMFo3iTATtBhWH9wwbPx42u5xjhKZowm0oAQ8A1rqCewQe4=
=eogo
-----END PGP SIGNATURE-----

--2iwiytekcfwv7xt7--

--===============5692864588369524280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5692864588369524280==--
