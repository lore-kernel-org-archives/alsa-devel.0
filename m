From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio mini conference 2014?
Date: Tue, 26 Aug 2014 09:42:20 +0100
Message-ID: <20140826084220.GA17528@sirena.org.uk>
References: <20140807140957.GI8181@intel.com>
 <alpine.DEB.2.00.1408121011200.10517@phandrigan-desktop>
 <53EA6165.3070902@zonque.org> <s5hbnropcvd.wl-tiwai@suse.de>
 <20140813165517.GB17528@sirena.org.uk>
 <20140817231021.GQ14537@sirena.org.uk>
 <s5hha1aw6we.wl-tiwai@suse.de> <53F1B892.5080109@metafoo.de>
 <53F1BA5B.6070400@zonque.org> <s5hbnr7u5xp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4641202534104017371=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CAF9261A57
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 10:42:53 +0200 (CEST)
In-Reply-To: <s5hbnr7u5xp.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: =?iso-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Tanu Kaskinen <tanu.kaskinen@linux.jf.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Paul Handrigan <paul.handrigan@cirrus.com>, David Henningsson <david.henningsson@canonical.com>, Arun Raghavan <arun@accosted.net>, Dylan Reid <dgreid@chromium.org>, Daniel Mack <daniel@zonque.org>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4641202534104017371==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D4n35dwmz6uXKtJE"
Content-Disposition: inline


--D4n35dwmz6uXKtJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 08:21:38AM +0200, Takashi Iwai wrote:

> So we've set the schedule?  Mark, did you get the final confirmation?

No confirmation yet but then it was LinuxCon all last week - I'm
expecting something this week.

> FWIW, below is topics (and comments) I gathered from the thread.  Just
> edit over it and repost if anyone has an idea, correction or
> suggestion.

I don't know if it's also worth talking about mapping channels through
DAI links in ASoC - I'm not sure anyone is intending to work on it in
the immediate term so I'd suggest putting it on the end of the list as
an "if we have time" kind of thing.

> - Code removals (Takashi)
>   There have been actions to remove the codes for old hardware
>   recently.  Which is acceptable?  Feature removals, too?

Linus was muttering about ISA sound card drivers.

> - tinyUCM (Mark?, Brian?)
>   The latest Google reference designs use something which is
>   essentially tinyucm - the configuration is mostly stored in an XML
>   configuration file which is read at runtime.  It's not consistent
>   with what anyone else uses.

>   (Brian) Those must be the qcom designs. They use a =E2=80=9Ctinyucm" th=
at is
>   xml based.

IIRC Manta was using it as well, I think it was the first device to do
so.

--D4n35dwmz6uXKtJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/EhpAAoJELSic+t+oim9stsP/ilZ/VPkn7c21rI8K0oIjBpu
FWhzUVNi69PbLSSpCbH36B05TYF2J4WvqfB7pi5adISwOmuj6l9ObIGdoL0lG3kW
KH9CqyimQFZTGNJNp7Kf4THRG9nzX8lQUCnlBq2QxcsQKVt7QBvkKICozX3lMosM
hlR/jvOH382Ao1pdOTazgJU3c6N+zyvYd4HVz/pUHL43hStiv6sWyiIj0A8mQh4b
ZbkGYtgXBQGrn4TBTsiTzwOsAQHeDQVcIHil0vHk0mZ4Y0AtYN9xa2xpv1jsddti
FepYyGiB7TxkWEABaDLu3XWl0ItN6hVWwgxIE5DPk0mo6hsCT9g2OlFFySiAFPH0
tukI6liA+9W2mIrsUoSeGj5ylgdXA04TIpTCRETidjQojkHdsCf7RA3WEoTDlyUE
yg04z0Xene3EAXdwoKhleob/t9JkJR6Jx3kQ4Zk6w+U8VrxNemWhu8EKJKmCWCv+
sz/TeYU4uXc7fooplvmgmYBv6WDbeqN2OPB7wPM8eVoQ74q/wiNB2Ct03L8+kpGu
SecxvLQNh6FzSzZoD0XegKu2iWti5542b6dGdwh4LvBQXtSjy4PRg7pLPdhcfRaN
X7SccFKCyVpmSZprpd2mYyIxQGtBQpFlRD56dj34XWUlQ+F2as7NI8twaQegAXT7
Ezm/0RB3/4bXOdWqDRPW
=fpwn
-----END PGP SIGNATURE-----

--D4n35dwmz6uXKtJE--

--===============4641202534104017371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4641202534104017371==--
