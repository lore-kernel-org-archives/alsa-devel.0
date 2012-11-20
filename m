From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: firmware: Add support for FW
	based widgets.
Date: Tue, 20 Nov 2012 11:16:14 +0900
Message-ID: <20121120021613.GA4483@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6857248009929575837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D4AC264F6A
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 03:16:22 +0100 (CET)
In-Reply-To: <1353348765-6238-2-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6857248009929575837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1G2Bc0EDIhoSmEt"
Content-Disposition: inline


--k1G2Bc0EDIhoSmEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 06:12:43PM +0000, Liam Girdwood wrote:
> This patch adds initial support for firmware based widgets by allowing
> soc-dapm.h to be included by userspace firmware generation tools and assigns
> IDs to the standard ASoC widgets kcontrol types using the kcontrol_new
> index and IDs to kcontrol get/put/info functions.

Applied,t hanks.

--k1G2Bc0EDIhoSmEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqufmAAoJELSic+t+oim9lwYP+wZsgSc5qfMwbCjMRPZYRRCw
bqAnC3z9XCXgBNYD5EfTFKEsPehPU10fJRMlyMqWZDJkspH4jlxAa58c3EVFAoYv
WkCGxeleTakSIzZxBU0wwEZS6Hjc2Kv2yFZebGkfILZLud5pJAg6szVYCaNqTEz3
OM/ug1iEhj3aMLoLCx7P639amNtCvrFbteLL15tFC2JkW3OEoyG7z0Ay9I0eLhLW
y/sPRkmHUD0EpetVoCwp4et8C8YkaST4YWtz76vSz2dCpfkOgNooFKTFcGT/TrRD
nskwFs2SNPCxo8DjMfvnMwASIJuRstC+Kp0LU82g6o3F8Rky9dF5zV9Dldj7OKyc
XatgeegmYv+QJbRLl7qlcvEta4jSa2lBAWUHoHixQNSGqyqUXDQQti8fsZ30wMql
FzNlJXeXBhIF8tu7EzoqBic/RN7Asu8JX3aZFleEA3vgxH7sX//b8FccqwuQDR9o
35RMd5GXUb6EP+VR5O8GDYgt/5DKxfNoWn6QeJUrxkOb+cLNF/knsYi4QSVVCvvE
sK5OHYxlcDdbJNxCIfsuNKLG2MmJPO8iU+/QMZKKVWepjpkaVFnv71LKtSin6NfL
DuLkujWtX9cICxz8NNhN2ye35q8eh9zXw8UXDDoRoWOTwnSXs1DiCwx7ftoNGcOw
dtzIqAfmI0qVe8lhDhNn
=iGmm
-----END PGP SIGNATURE-----

--k1G2Bc0EDIhoSmEt--

--===============6857248009929575837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6857248009929575837==--
