From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: core: double free in
	snd_soc_add_platform()
Date: Mon, 22 Jul 2013 11:00:18 +0100
Message-ID: <20130722100018.GN9858@sirena.org.uk>
References: <20130722065654.GC14617@longonot.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3018151216132972195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 52AD8261A36
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 12:00:24 +0200 (CEST)
In-Reply-To: <20130722065654.GC14617@longonot.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3018151216132972195==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p5BJhDJf0owydRUK"
Content-Disposition: inline


--p5BJhDJf0owydRUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2013 at 09:56:54AM +0300, Dan Carpenter wrote:
> There are three callers for this function, and none of them want it to
> free platform for them.  It leads to a double free.

Applied, thanks.

--p5BJhDJf0owydRUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7QKvAAoJELSic+t+oim9woUP/A/YBClxti83BTcOQrmDTVIy
vfyJ9Ora0Pzi57ohvA0y+5QyMhng3chYPzf3lONWnO7qmAoV3lt565Z2/6UNJU43
HFye2yhm5KH44+ondrwmXkEf2hoKwzLl2uTW1sSZhNZ5XxkSJ+zKsj4PlZ7ZsnVt
fbgPLU1OrFmi6Z1e9ZPwVLIKn7O/4OqR3Fl6H+749dBa2nd0uVS3C32raOdYzift
xjmOP6j+Av0n6a0qxq5S0JfwvPKmYiD4lh6hbTYORq70+kYXQyme98HSuP5oxCSK
f1ma3se/o3FLbiZbZqVEJz7t4aiHoX724ydATuSTL2q4Y2Zb0m67HHiwXhDcTSqe
BGNhVspe1fv2JXRS1bdtSW774ol2Hjsn8KDd4Ci9A2ibNkKy/v5eVgQe+6nGy0EG
y5U/cbw2cPZDXHWZwLZ8s9vHZ9fFnQeqtPo0Eupi7auBL0/9AiZH2hZhXzA2NfW9
gyZEtS1z8SFhUQXuOrXQRvVFoJyE62J61ZfunUOyzxiXuiLMwVJ0CQO+DDumWN2o
TM87oDy3jEuuSBeXpS6VCQT5ZdEIELqIaVgYOZY53Mst7opIdFQTQupKyETvTDDG
KkXM061GqGyvQpaiBTc1PKV6nASaCmnQcbjSa4OqNo8QGCsQhURa8cR/3ebvfRBL
m57+cRDCYwGO3ovJJoEM
=QA6p
-----END PGP SIGNATURE-----

--p5BJhDJf0owydRUK--

--===============3018151216132972195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3018151216132972195==--
