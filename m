From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/14] ASoC: hisilicon: constify
 snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 13:20:34 +0100
Message-ID: <20170818122034.3x3ot52vxn6yqmzm@sirena.org.uk>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1503057971-16033-6-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4935531332081362398=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F002677F5
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 14:20:37 +0200 (CEST)
In-Reply-To: <1503057971-16033-6-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, timur@tabi.org, linux-kernel@vger.kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4935531332081362398==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="esgwqgbzrpcwyiii"
Content-Disposition: inline


--esgwqgbzrpcwyiii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 05:36:02PM +0530, Arvind Yadav wrote:
> snd_soc_dai_ops are not supposed to change at runtime. All functions
> working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
> const snd_soc_dai_ops. So mark the non-const structs as const.

...and this.  I'll not reply to any of the others in the series but I'm
guessing there'll be a bunch of others.

--esgwqgbzrpcwyiii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW25EACgkQJNaLcl1U
h9Bu+gf8CJUzENfA7MwWlxqkjsp3E7pAodSgUjmaX+zsEpCXqVighMyrOzJCs+yZ
svqBOtNw007AC3gTw8Y2XDO3ThkoC4DXK+/2c8Uc4QiYQgpLsDS80192ioYpmnrL
NDi8VD8G/md+ypWUJ6qHtp45Y0lPuuQraB7XP7a+JdtxLoVMir1Hygtg2ZqlA2Qy
PpB/E8oD+o10y3AeRhSvujNFr47QqoYd5jUYPN6GrYE5cxzAj2G+gg2HKWdz0LbD
tWhKMxGGFmzEAzlgrJIOvX84+WiKovfVEx2dfHsIsM3KDB9k1+ZwVTT15fGpOA0E
lRbQxm3G24eLTvUxhv1sLmi/olfpog==
=jNIA
-----END PGP SIGNATURE-----

--esgwqgbzrpcwyiii--

--===============4935531332081362398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4935531332081362398==--
