From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] audio: sai: Add Power Management support
Date: Thu, 30 Oct 2014 11:22:43 +0000
Message-ID: <20141030112243.GV18557@sirena.org.uk>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>
 <20141029113634.GF18557@sirena.org.uk>
 <718ee124537a4f4091bdf5242d256705@BY2PR0301MB0613.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6656645474849296566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B68E26060B
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:23:16 +0100 (CET)
In-Reply-To: <718ee124537a4f4091bdf5242d256705@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Huan Wang <alison.wang@freescale.com>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============6656645474849296566==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qVfNuiS7HlVt3T7n"
Content-Disposition: inline


--qVfNuiS7HlVt3T7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 03:30:40AM +0000, Li.Xiubo@freescale.com wrote:

> One more thing, if the device is not performance critical, then shouldn't we
> Take care of the cache memory consumption to determine using flat or rbtree
> Type ?

Yes, it's always fine to use a rbtree if it makes sense - it was just an
unusual choice for a device like this that didn't seem to be discussed.

Depending on the register map a flat cache can actually be more memory
efficient sometimes since there's some overhead for the rbtree data
structures, if you've just got one block of registers with no gaps a
flat cache is going to be a win there.

--qVfNuiS7HlVt3T7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUh+DAAoJECTWi3JdVIfQh2MH/jdbvpitCAym6GZEz+uOSx2C
GT2ucOcRELRheT5iNiUhxMz5Q8pkjn81JU44gUsWr3bbtSeaiFLiA5T5If/WASWo
1Qd0HnLjZyFQUJwx0b4nFiH+d3+Y7WPSD/ADplGTEVDedUkXcuU8iKWXpXfRigKv
AGwHvADzJOAkyxmI4DqCo9wALrgpBv3qzxTG7BHNi5fbI/1VHAceNnc/DYN9S+Ev
22rv4/nnOZ+fZwRihP8+W3YZFU1cMp27W3S8wUDSLumGH/MXuZV7CeTB8lJM2jTF
1OSuL15SDBqDHqxqOaC1moYaWmgK//1St938tiohHXCTwQeFsM4c9LSCNX7Zrg4=
=NKTJ
-----END PGP SIGNATURE-----

--qVfNuiS7HlVt3T7n--

--===============6656645474849296566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6656645474849296566==--
