From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH for-4.15] ASoC: rt5514: don't assume rt5514
 component was "attached"
Date: Tue, 19 Dec 2017 10:58:18 +0000
Message-ID: <20171219105818.GH8563@sirena.org.uk>
References: <20171216011230.107527-1-briannorris@chromium.org>
 <20171216031738.GA220575@google.com>
 <CAFv8Nw+qiWedqZeVsPn17WiSyc_zwOP3bEnxn2Wc-oQ3ntgq2g@mail.gmail.com>
 <20171218174235.GA113663@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0222313224140738456=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AEDC0266C72
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 11:58:28 +0100 (CET)
In-Reply-To: <20171218174235.GA113663@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Norris <briannorris@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>, Bard Liao <bardliao@realtek.com>, Cheng-yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============0222313224140738456==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 18, 2017 at 09:42:36AM -0800, Brian Norris wrote:
> On Mon, Dec 18, 2017 at 12:23:18PM +0800, Cheng-yi Chiang wrote:

> >    Hi Brian,
> >      Oder has posted the same fix : [1]https://patchwork.kernel.org/
> >    patch/10066257/ and it has been applied.

> >    Perhaps you can cherry-pick it to v4.15 ?

> I have no say in that; that would be up to Mark, I think. It's most
> certainly a regression in 4.15-rc1, so IMO it should be given a proper
> 'Fixes: e9c50aa6bd39 ("ASoC: rt5514-spi: check irq status to schedule
> data copy in resume function")' tag and sent for 4.15, not 4.16.

It's been applied as a fix for some time.

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo48MkACgkQJNaLcl1U
h9CrgQf+IsTiMtYnxPlq6jz/mox6voRxWTE4NpiOctD4HmGVbt4WVBQkiIl+xtd0
t6+EcxgKzrhfIBVUU7VXF8JeBEy5OgUqfA3D+T/ftHs2Xd0VeZ7h9CbwnQ4S4UCt
ZrG1w6L10ltzy2iolNhAjISYqR96Ad303HBIH+2d4g4zu9qGtrWbsckLvY2WZBdd
cuXr38LODZPtjpgA5k2msatUQ0UOfLTljb1Sw3Oz5zIQHmojWErK+kydfXV9HgoR
Y3QBa+XjeSHR6L+vi5pXFq2B4lQqbvfkVV5WcAiw/n71fo8Y/kUv+0cqMh0j02rI
FHqrQJTnUS0NNhCMLWiXK3e9QB5gaA==
=KMzf
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--

--===============0222313224140738456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0222313224140738456==--
