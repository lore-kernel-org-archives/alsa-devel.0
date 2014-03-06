From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: Handle ignore_pmdown_time for
 CODEC to CODEC links
Date: Thu, 6 Mar 2014 17:10:31 +0800
Message-ID: <20140306091031.GJ13126@sirena.org.uk>
References: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7576496283967906875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EB342658D0
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 10:10:48 +0100 (CET)
In-Reply-To: <1394021868-11860-1-git-send-email-lars@metafoo.de>
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7576496283967906875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aeRBb0cVhgYNXOrs"
Content-Disposition: inline


--aeRBb0cVhgYNXOrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 01:17:42PM +0100, Lars-Peter Clausen wrote:
> For CODEC to CODEC links we should only immediately power down if both CODECs
> are configured to ignore the power down delay. Factor the logic for this
> into a helper function that can be used for both compressed and normal PCMs.

Applied all, thanks.

--aeRBb0cVhgYNXOrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGDt4AAoJELSic+t+oim9vv4P/jmT6KUE60DNaKILtkwNkGBw
sqkQ5KeDtWE3GfSuXwA4KQ1fOIz9nIPfxmabhMzy6o0WXd6mJMMXHx7KugW8niyQ
61dCKV2N6dwG4NAKdd8ryOp2wxpYYEUweZYVNdBf8iUG46+wvYNqJoaw/1E2Dh4U
ztHkrBYsJ9nSZ6VzrpKoiUCZud6l5kMqgIX6H8HyyxK3w+HvZcoW1k67+wrArafL
BbIGoqg4XmgNKsC8FL2F5Cz2MyPRy/iiXZC8F9ms4DHZhuksMMr27uvp2Xsdft6B
7UvNp4+sprWMWwzB6XAvxeBjjlusTNZaFUm21q3yY5croIkZysxD9R5P/PRQ3KY5
6i3AuEqqNgtgw8V2ORTCr5FBN9fWm3DZ203brM4FJZxUE/SqxK+KlD7w6ZLZxDuo
53wePBHEO1NZOUZJJIB3i8q2L3RaCCgkTjYJAlOpTUYAg/dR1arf03j0MHcbimSI
SJp86fsMp5yK/CJ7qC9KjCWgJy8IrVWYWWyR2Za8HaHdJ7fpeB1goTaW3iE7jybx
aeIa4CLCFl4YlEQV9sZ5ON/WKO5ZxGg0kMa/3m00e1nsWOqY0DbbPTTfmafkO6A6
r9oGqOivzBnk9Mw/6squkiDB+NB7Mc/9tdydnYuCzM7RO2nNPGkhZRYgdYm+Ft5V
UjCHUlnJPWp2sMlNjAEF
=ZrXC
-----END PGP SIGNATURE-----

--aeRBb0cVhgYNXOrs--

--===============7576496283967906875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7576496283967906875==--
