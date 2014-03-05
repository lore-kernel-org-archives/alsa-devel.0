From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4104: Remove superfluous
 codec->control_data initialization
Date: Wed, 5 Mar 2014 09:25:50 +0800
Message-ID: <20140305012550.GP13126@sirena.org.uk>
References: <1393921177-24294-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6408383668912531430=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 186CD265833
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 02:26:06 +0100 (CET)
In-Reply-To: <1393921177-24294-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6408383668912531430==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AwNVUpjOmSj7UnwZ"
Content-Disposition: inline


--AwNVUpjOmSj7UnwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 09:19:37AM +0100, Lars-Peter Clausen wrote:
> The driver uses automatic IO setup, which will also initialize the control_data
> field of the CODEC, no need to do it manually.

Applied, thanks.

--AwNVUpjOmSj7UnwZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFn0bAAoJELSic+t+oim9LMEP/1BowQCwCdhXOHxrZ2Lr+Wjk
b8F7RwpBT2y1dklAc33AKBB9N+dt2NzmqnDdqQ3wtlpxR+wkpR64LcjRk2qepsOY
1cAgrFIG4Kv1PisbRWRxLCQnMld3AFleXDIZb5WNH9fv+9hAskIdHUh05xhKVlLX
YKvVCZ4jJk2+KXwnxF/W5YdqszMRxzr5nG8VyiX/FopKoRoJdrDQv51Gcx5laai7
2tfew9aoj4PMNTHjm4IRzlkF/yZnEGZ3FHA9E4F3jr697dqz8LLVoQ2C75FkY8uc
W1IfdXUGG65dKD5R11u+EPjwilc1C01vtOra8S9tBI6s2r4jmu7IL5hu51va4s+4
iw8t+d3cSPBygt5xNZxABE4zbqdNntox94x3i3c88uZowEIH1bT5aM8r3OcnOcBl
/4w4S6br0O75MPg0ZI0tJm/9cayJoZ2W2gbwnA/z3adnqdzsX6ASXdSi3yVJ9wGU
AD57XuefQ7pNV79ksD4THANMIQ49qJgRVM5Fn4zgVDpQ7U8DsSlh+n9Z05RKbGCr
V9IaN9Ub1qJjBJF69KBx5HFRsc49pUwhPz4+9v6SYefJCTZz2u/AdZ8e+H7hdbve
mQhSYHmkrw1yyZNlkSHTqBH92DmwHheHK8v2lJNEqkt42ys/qpbSM1YU+Lbml9af
zN3GtExCjje3dnJ5/GOt
=PH/u
-----END PGP SIGNATURE-----

--AwNVUpjOmSj7UnwZ--

--===============6408383668912531430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6408383668912531430==--
