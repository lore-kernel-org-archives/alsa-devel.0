From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 16:52:57 +0000
Message-ID: <20181217165257.GD27909@sirena.org.uk>
References: <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5771828952354720529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B4D76267AF7
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 17:52:58 +0100 (CET)
In-Reply-To: <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5771828952354720529==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2018 at 06:23:43PM +0200, Dimitris Papavasiliou wrote:
> On 12/17/18 5:40 PM, Mark Brown wrote:
> > That's why I was suggesting that you should be configuring the power
> > down time.

> I've already tried your suggestion, but unfortunately it doesn't
> work in the general case, as it doesn't help when the hw_params
> callback is called while the device is opened (but not playing).

The device being open shouldn't have any impact on the power state?

> > Unfortunately none of this helps.  Although the chip is turned
> > off without delay, it's turned off only while the device is
> > closed.  As soon as the device is opened, it is turned on and
> > kept on during all subsequent hw_params calls, where clock
> > switching takes place.  The pops always get through.

I would expect the stream to be closed and reopened by most applications
in between reconfigurations like that, it certainly used to be the
common pattern.

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwX1GgACgkQJNaLcl1U
h9DQWwf/TomSBaT3175+gjJEYLQlCtuX6lo8frgMt8e05tkvdsZjPqdATgMQkizv
IKnlMWIL8UXkgfeo7QRehvJ44QsSs+NPefN+UUnUxvFRYPnc6Q+UcCtRR2hAZH7A
qJNgVa9QTlssC+suuUwaKIRMneouats/LCGrhsBxJ7chznqgR3XOwLfJDX88jjnD
OdHYtueT9/pP4pGPyurfbQW/wchDuvVYOVC6RiDF4AyQpwmA00QoAEp86z25P7mY
1hrSvg5UvuJ1d9xLjdSziLPlgpwdRQ95hxs5ZW49AtKLdFLR49/Hj68YDRlXyxaH
hKvbZBhfowVSmKAlw+EFhf9+TCqM+Q==
=6DYM
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--

--===============5771828952354720529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5771828952354720529==--
