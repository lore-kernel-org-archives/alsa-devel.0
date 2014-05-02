From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix allocated block list
 usage when adding blocks.
Date: Fri, 2 May 2014 09:53:15 -0700
Message-ID: <20140502165315.GK3245@sirena.org.uk>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1399046194-5544-3-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2894570195194261040=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E43F9265279
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:53:28 +0200 (CEST)
In-Reply-To: <1399046194-5544-3-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2894570195194261040==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WnHDDQh5pHvbcbhl"
Content-Disposition: inline


--WnHDDQh5pHvbcbhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 04:56:29PM +0100, Liam Girdwood wrote:
> Make sure we add the allocated blocks to the modules list of blocks.

Applied, thanks.

--WnHDDQh5pHvbcbhl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY814AAoJELSic+t+oim98NMP/39fE+jV2E/lDQbSZ1AwwMIA
1RdXQAgDe8zmcwt+7pacURqDlqlE1WQsDF6G6Gq4XW2VVEFWL8yoCsRYYhmkduj7
eHaE85Wg0J/fX6LiSskI1gizvm2DQ2i5/rI10PUTSXeeLM8sjgURUxbvfs/Ymll6
sk8co4h+1ezztFXzrcqKS2hpcQc5qjXuxzKSWGlzqejjFdoln522QM1qqEovxmwZ
TCcC/YSOvY/FNN2mOUrBJEEMYhdoMnwX2CWs6ZPN+zBnqRA5tDfJgvP6KmPejQ3c
EQpuiLk+J8obVydnzcysGrYEpx+ocHXTYaX7ikRvJr3lP2eLCQRPfDBD31qRgeQc
02TCwNUr6eELE6bJa/dKLBmWC+ILFq6LRjDaf6ulHRkZ2peEyWPyUxQpk5pqbVUE
lojkcm9N9OwftH6jiSonlBD5Qd26BXh76CehkU0WfZKEIp5dpFbtX2Wz+jRf2idZ
MrGIM5rxfmdUE36uI9yD/ueOH/WlD25Y/DFQI8vXyWyp/oh0LibTZ8ibNhXAkSeo
eGrmnneMhJJ+E1U7/N6YtnN0pWQRzXglpDGLv3D2lAeZe5MNVOh/DhB84iTTb0eg
+HRQcYlZq0yj3MsuT7+PbxxNfZlJsfgarC9bqjb33uivlatTYb1Tsfh5bW6fiBsB
DiO4omDvdVIj1e+/xNJt
=TQyz
-----END PGP SIGNATURE-----

--WnHDDQh5pHvbcbhl--

--===============2894570195194261040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2894570195194261040==--
