From: Taral <taral@taral.net>
Subject: Re: Oops when removing snd-timer
Date: Mon, 18 Nov 2002 09:27:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021118152748.GA8143@hatchling.taral.net>
References: <20021118080208.GA4945@hatchling.taral.net> <Pine.LNX.4.44.0211180347320.1538-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211180347320.1538-100000@montezuma.mastecende.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2002 at 04:07:17AM -0500, Zwane Mwaikambo wrote:
> Looks like you loaded ens137x.c and then that driver got unloaded leaving=
=20
> the callback still valid, then the core timer code decided to walk off a=
=20
> cliff using that pointer.

I don't have ens137x.c compiled, much less loaded. What makes you think
this?

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Pretty please with dollars on top?" -- Me

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE92Qb0oQQF8xCPwJQRAk8dAJ9kiIfMU9TrKOXgTMncVha0myWXBQCZAZQq
eR2VZ+5vMWIMgzH+82FkGEw=
=57Dt
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
