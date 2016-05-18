From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Wed, 18 May 2016 16:28:20 +0100
Message-ID: <20160518152820.GN8104@sirena.org.uk>
References: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
 <20160518150812.GK8104@sirena.org.uk>
 <209086304.1BTKYSBN0B@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0868938036878023469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F62F260647
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:28:32 +0200 (CEST)
In-Reply-To: <209086304.1BTKYSBN0B@ws-stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0868938036878023469==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Content-Disposition: inline


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 18, 2016 at 05:18:41PM +0200, Alexander Stein wrote:

> Well, it's debatable if using dev_err() and then returning EPROBE_DEFER i=
s=20
> correct either. IMHO if there is an actual error, an error code has to be=
=20
> returned and not "well, can't continue now, probe me again later".
> At first glance those EPROBE_DEFER are correct as other dependent drivers=
 may=20
> be probed later, so printing an error in that case seems wrong to me.

Half the point with probe deferral is that it's transparent to anything
that isn't actually resolving a resource - if we have to add custom code
in to everywhere were we need to print an error in a probe path that's
not great either.  We also don't want to silently ignore probe deferral
all the time since then it becomes very hard to diagnose why something
is not instantiating.

--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPIoTAAoJECTWi3JdVIfQ3MwH/icMlQwTAMH/H6MQc4w47BHt
1oWia2AQgWIqmk3m8DtBVGEIWQL/50PQRJkdWmc0P8Xj2pE6Omog/NNgP6iIL3x6
tqB6KL3nOE+82xxvJ98JERkeBufba74x+aT5XMeWLoCUKFQU9I/Qh3ugq7+tyT0M
juKJrcqFRJyUyzuCmJh47s1GhhzUira5/wmkLkBm1XAmtuxqm2H62wTOrRfsSs9z
s7gMvpPCI/bax97nEOuG3NH+KTq34+um6G77qQsgxLuXDI8sjYbt8BgavJ7Pqa4D
JwezD7zQJjSqlJbxZJSjpWwcqkh1cTo1+pO9Nbskpd+6jDzgS8AwI0ZZlaHXOnQ=
=KBJH
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--

--===============0868938036878023469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0868938036878023469==--
