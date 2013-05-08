From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: ux500: Use the first two AD
	slots for capture
Date: Wed, 8 May 2013 13:30:36 +0100
Message-ID: <20130508123036.GJ7478@sirena.org.uk>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-7-git-send-email-fabio.baltieri@linaro.org>
 <20130508105654.GC7478@sirena.org.uk>
 <20130508111253.GE3459@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2806435785662716953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A96B26109F
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 14:30:47 +0200 (CEST)
In-Reply-To: <20130508111253.GE3459@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2806435785662716953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b+chlBtRKJDCtqTb"
Content-Disposition: inline


--b+chlBtRKJDCtqTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 12:12:53PM +0100, Lee Jones wrote:
> On Wed, 08 May 2013, Mark Brown wrote:

> > If these are routing specific analogue inputs to specific timeslots then
> > this is routing that should be being exposed to DAPM as muxes, not hard
> > coded in the middle of TDM slot configuration (which is both obscure and
> > not what the TDM API is there for).  The TDM API should be purely about
> > placing the timeslots for the audio interface on the bus.

> Again, I think this patch is a valid bugfix. If the driver requires
> refactoring, it should be done by someone else. That's not the purpose
> of Fabio's role.

It's a configuraiton change not a bug fix as far as I can see.

--b+chlBtRKJDCtqTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRikVoAAoJELSic+t+oim9t68P/2SQ4WsZLe1MgEH5ke/HkNHA
S1jSYiAmvt/9zc+TiuZsv2/B+ygPrHU69bg8aZHeELv3gMxWVt9t6OEI064uHP6q
QhKjBNdGj/k3enBJddG4u0qQOyh8CQlXGbwj44tiyYHWIun2WLhyRQY9NPdflo9o
hyJPlbtoIf1ciiQpW0Rg/N7TXfLvYbpnLJPubS48RicfsX6NKav56mwbj4Yi96Ya
G+5QoSgf+Y+WaFr0A635tuU5qvEB3JcmkpbCNuRJ6lhidFR0DDcKlrmncxEHNymD
nJ/ewN4P2yJkP4WXM0+mUcneUrA9GAJZ1fUj67KxaHNjCbBProblfr6hsV+CZAb9
CFrDHDjOCNyY59smonSFSQDNIy1gir5dFwOS/EzniJzsyjbSQgNpM1MiHSxoVuMS
SbMv2yQjKewopzU/0Ad3CHqRVjyesXF3eX3vYR5oZN5FRJw+PZ3hzlOXWMA1i8Us
MZlW6rVlC5xd+vZkLL/qxhg9SXJe54vLJRicMq9NPvuJdtYFu+HEj9YB4CKtjJnh
TRvviBeppuZV9tnOHzIp79TBjgB3sF5v9uUsdSHOuyPmMwpglpYDtt/5sdrjvSLo
hQXEfRvRkRvg6L5lZi9/LvURR/9o5AoZm4zuQnFLyN2hX3SUPvqvo3LnZhUsiAY6
cWksrr9PKddmHVuTxKen
=NyK8
-----END PGP SIGNATURE-----

--b+chlBtRKJDCtqTb--

--===============2806435785662716953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2806435785662716953==--
