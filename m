From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 2/8] ASoC: davinci-evm: Add device tree
	binding
Date: Thu, 12 Sep 2013 12:47:07 +0100
Message-ID: <20130912114707.GK29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <2f2fa45507656c464b413a9761c7dd2059f4590e.1378738436.git.jsarha@ti.com>
 <20130909152146.GK29403@sirena.org.uk>
 <7fd2aed6239e4bbb791a4f232c74881a@kapsi.fi>
 <20130911113533.GQ29403@sirena.org.uk>
 <26fb2b5213b7ea9c8bd9e2ef023614a3@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2159703271743840244=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0512B261675
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:47:14 +0200 (CEST)
In-Reply-To: <26fb2b5213b7ea9c8bd9e2ef023614a3@kapsi.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <oku@iki.fi>
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============2159703271743840244==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3sLite7U3kd5/6th"
Content-Disposition: inline


--3sLite7U3kd5/6th
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2013 at 09:02:06PM +0300, Jyri Sarha wrote:

> I can of course also add the list of pins to Documentation/devicetree/
> bindings/sound/tlv320aic3x.txt, if that was what you meant. It would
> make sense to have the pins there. However, I really can not find the

Yes, that is what I meant.

> list of pins from any of the Wolfson codec binding documents
> (Documentation/devicetree/bindings/sound/wm*.txt) for exmaple. Are you
> perhaps refering to some other document or is the convention changing
> for v3.12?

This is more to do with the fact that very few people have actually done
DT bindings for machines so nobody has been documenting the bindings
properly.  If you look you'll see some of the Wolfson devices do have
pin lists.

--3sLite7U3kd5/6th
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMam4AAoJELSic+t+oim9GXMP/R1KGPtz2sAjCVSZvFghGs6M
hnTLzpMTjmVQy/aeTw3dRgBoSZbGys/FiEe3CMUFgYoYTlXRbynRuy/Pu/o7BJfa
QupLI09x4CGy3FqSs2YEdswNlMfwQsndUT97aeFIU47voR89Sq2tfhyxkWQIrWDx
t30eYkC3SWGf6czMQynqH5zYXSCNBuVhYZw3K1CEYyvAQ4MZep6EVrkpCW/onHmZ
sLoqkBG3xkSv8E4pEdQEe4SjwdUtt3IWTeqBjFDwEoxBvFEiUZotVGhnsYI9dqBz
RqIP2xioqxLSIJyRL37Js0Xi4Jvp6jQNg+xZhNdzlmFs+fRrJUuac7GDN9tih97q
Jr3ZlanTYNbaFBuqmM60SLZRAT0CQTWx2QxzJEZxYKby0DCP0yvoqyQBO4iEVuTw
Ui0xLTLgsy6K3YokfnzOG8tzeL+KKWrqVZz91aQUyGqi+fAXlm1LDoqT8x0qGB10
A0tIg6SRDZrlVqF0fzJIovPo9UGpyC+FbhI9m0MXazxQltkXcDbO/otCyVFF7/0t
ug/VeOQBN5MeQhwRZ2zp+7mj7jJFjp8lZKwqRA6O5umpGmJA5yMtKxDyA8LafncL
dG6dLf7PM5pN5LBDDToIx7y/mtKrK+ssHkmDsW4DtGqM8btHhm/AOivYMRwoE9KE
5diCLv/9SJ20uCmh5jcH
=NU9R
-----END PGP SIGNATURE-----

--3sLite7U3kd5/6th--

--===============2159703271743840244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2159703271743840244==--
