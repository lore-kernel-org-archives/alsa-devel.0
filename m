From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] ASoC: constification and random
	cleanups
Date: Tue, 31 Mar 2015 19:10:48 +0100
Message-ID: <20150331181048.GV2869@sirena.org.uk>
References: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150331161924.GT2869@sirena.org.uk>
 <20150331174309.GK17728@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5689965154169937532=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF3C2264F0A
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 20:10:59 +0200 (CEST)
In-Reply-To: <20150331174309.GK17728@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5689965154169937532==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PLQVj6KKQ8ndgLWn"
Content-Disposition: inline


--PLQVj6KKQ8ndgLWn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2015 at 07:43:09PM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Mar 31, 2015 at 05:19:24PM +0100, Mark Brown wrote:

> > > Patch 4 applied just fine to next, so this is just a resend.

> > This patch appears to be unrelated to the rest of the series :(

> From my point of view it is related. Initially this series was a single
> patch that made all of_device_ids const for ASoC. Then I split out the
> fsi changes because they were too heavy for a multi-driver patch. While
> doing this I noticed the license mismatch.

What I'm seeing here is a random patch series for fsi plus a big splat
over the entire subsystem.

> I assume I shouldn't resend patch 4 separately :-)

Indeed.

--PLQVj6KKQ8ndgLWn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGuMnAAoJECTWi3JdVIfQDMkH/2w/CtDG3GqmFIALN5AFNFbq
90bTAzFjgaTtWubFr9orBdiToQHRKGjCtJLquNJda8pmb68FHFVzGOjmeMPZ6NxT
qvfCquTk26EdUs9cnxQ2oKXyfPKtfNZh4dFENZX2EuWrTLEHm/AhsDNe+0ag0xXx
IPk/JPL/sII0OU9qIcKJO1s5MdbTon9FBB80QFsJfuCfN7CfhMv75PXgXlBnxG+C
9jF/wk1Vc6WrqBkNW0hgvKuX5vole8wmC37z1OrJU41ab+gNe0cez4s6SvzZoLT1
J6Fqlw065RGznREt7vKGi2iyJIBnq/lFD8gzIUNCxiWqVs/OGcrREIqpn9YkcSY=
=fkYi
-----END PGP SIGNATURE-----

--PLQVj6KKQ8ndgLWn--

--===============5689965154169937532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5689965154169937532==--
