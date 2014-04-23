From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix audio crash due to race
 condition in stream deletion
Date: Wed, 23 Apr 2014 12:19:48 +0100
Message-ID: <20140423111948.GS12304@sirena.org.uk>
References: <1398248970-13991-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6780825212102832313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67F96265146
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 13:19:59 +0200 (CEST)
In-Reply-To: <1398248970-13991-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Wenkai Du <wenkai.du@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6780825212102832313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="stZQFPZ4/fPI7QSY"
Content-Disposition: inline


--stZQFPZ4/fPI7QSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2014 at 01:29:30PM +0300, Jarkko Nikula wrote:
> From: Wenkai Du <wenkai.du@intel.com>
>=20
> There is a race between sst_byt_stream_free() and sst_byt_get_stream()
> if sst_byt_get_stream() called from sst_byt_irq_thread() context is
> accessing the byt->stream_list while a stream is deleted from the list.

Applied, thanks.

--stZQFPZ4/fPI7QSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV6HRAAoJELSic+t+oim98ucP/AtA+yjIfTDYVCIbj1YYpx4C
z5t4Q4f8E8W3Lc80hZO/963awViGQtEHMwFUQtCq/nY0ZGBIlNTouzNkSmTMe5qB
QeyNAnSU9wX6ViNwx4a5bhezL6cw+THrgy8Gy6cjssZ0nz+SQp9ZZ04oRm0BRLVj
k2zrJboFcz0nD+4Q+kTg18rYTXWfNXPwGAIvzMkT7MPFCYnJQvoc09VnCIGlgYWy
9Eu28t6vUwzu4MxXVxPAIU7BfCYb3QIYi5BwR09G+7gZf5VkyDE2getxV6+YXk58
iMk81TJLTtGrgMckmqpqAVyh1beonjPcYkLrA4P03gYtye/LMcIzoQ9w8EFJZFcS
HvD3aKA1giaZIK2BE+rSdG30rtUdwsDyc86HqP4iIGQNgA7eKn9nKunXfgx4pIjW
BDFG871uh9OXz0JLjFCuhyCiVEnTO3wIFRaAieqmcVadnaNNlnQI1X18zEJSDY5s
FgpgopErkZ1+G22Henu5L1U2RgZkXV5gTv3vi3cbfcUCJ93YNaDe0wrzep/dc/K1
8FhY741mBG0n4coFz+IbNbN5yfCMzSihNpdBwID6DtFM1WgwFzCJzGorhlOdLmFc
z9MYi29bjGOzrVtHe+AMHanM/xEWGd5nEXjqZQXexwyJlwyz75CUx8zMHutl0P4y
RUprf6Wn9SKIC3EdkNyP
=NcnM
-----END PGP SIGNATURE-----

--stZQFPZ4/fPI7QSY--

--===============6780825212102832313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6780825212102832313==--
