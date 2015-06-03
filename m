From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Avoid recursive locking in
 the DEADLOCK detector
Date: Wed, 3 Jun 2015 17:44:53 +0100
Message-ID: <20150603164453.GP14071@sirena.org.uk>
References: <1433346797-1908-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4974154439931936295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DE10265AEF
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 18:44:59 +0200 (CEST)
In-Reply-To: <1433346797-1908-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4974154439931936295==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2DMJGKatbWMtT1aQ"
Content-Disposition: inline


--2DMJGKatbWMtT1aQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 11:53:17PM +0800, Oder Chiou wrote:

> The patch is for to avoid recursive locking in the DEADLOCK detector.
> In the driver, it encountered the warnning message of the recursive locking
> in the function "regmap_lock_mutex".

Could you be more specific about the deadlock you're seeing?  This isn't
really enough to understand either what the problem is or why this fixes
it.  Converting all the per-regmap mutexes into a single global mutex
isn't an immediately obvious step.

--2DMJGKatbWMtT1aQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVby8EAAoJECTWi3JdVIfQvzkH/1robYBiyty3RBdqyN5XXZiG
FHTYmt1Y8CBJQc87NAqVxGIect/IQNnAjDerRC1O4DacinlrUTz00r+uNt3cpXa5
LmyFKyXRgDvAEU3VezM1ov9gu0yqp1QGfQ1j2JPSfqpzzsJ0gKNbQtn+vhNREwSe
q5AhazNwkb8JqyVHceYVP/jgpgRI3TXuKGK7UU5Hf263PkcX9GpY5CXX87t0ALO6
IEQtsCZ8JfVCZervSYbaRA0IfX3+9Zd1BnpUHA5jfbvpVvxibqk/DVNzAcew9eVj
k0v+3NP5qOxoIlOB4QUmkF6Q9WGNIfX8WX5Y2wougWjTmMgwxMUjZBdJsWgMXzo=
=Jkoo
-----END PGP SIGNATURE-----

--2DMJGKatbWMtT1aQ--

--===============4974154439931936295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4974154439931936295==--
