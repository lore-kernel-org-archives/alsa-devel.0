From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix locking during codec
	shutdown
Date: Fri, 6 Jul 2012 18:20:29 +0100
Message-ID: <20120706172029.GI4017@opensource.wolfsonmicro.com>
References: <1341590225-20837-1-git-send-email-lrg@ti.com>
	<20120706160220.GG4017@opensource.wolfsonmicro.com>
	<1341592575.4963.7.camel@odin>
	<20120706164344.GH4017@opensource.wolfsonmicro.com>
	<1341594613.4963.11.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3686574428913442462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CB641045A2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 19:20:30 +0200 (CEST)
In-Reply-To: <1341594613.4963.11.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3686574428913442462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2012 at 06:10:13PM +0100, Liam Girdwood wrote:
> On Fri, 2012-07-06 at 17:43 +0100, Mark Brown wrote:

> > So how is suspend and resume safe, for example?  It's the same general
> > path through the PM core.

> suspend and resume are safe as they call stream_event() that holds the
> DAPM mutex.

So that's safe with regard to DAPM...  it's not the specific example
that's concerning me here so much as the fact that I don't think we're
doing anything else to make sure shutdown is safe with other things that
might be going on when shutdown is called.  There's probably a huge raft
of issues that might occur...

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9x5BAAoJEBus8iNuMP3dl0YP/j1ANL+HuU0h1AadUBUYTkMu
OYYvNUYJGAqXL2ks9idrNeZU8dimShQxkz+fkHtH0biKHyvJSd9Av0Gx2/wEPIFn
j9+MVMA8PKJyJPP1Yx2vlbspEkfuUUjpMXMWMAdOewyjU5r4IGZIu+zcgBoFHql+
nPo8LeLjaY8j1oeFmTZVjX9pAXa3hqf/ahqqmiNN111z0X2sBxChjj/S6pBZiM0G
ZOksbXT4zQOgCqkcr8iWw117N3aoPZf2rh+D2lpdcOKkak/rcSncUjOeRpNd4+DF
wjwUF9n1d65C4YAgW8aTBC8mi4qFJuPSoLqzR+v2iAkG638l6iTmITS/YxmPWEHl
4SFImGnaXcWX9F9Mibks4t39bQMUDBG9PhFHJ1ZlnfRHqXkFgRFB6VJa/BKo4xZv
fEVbDNCMesn+XTTEQD0JNB8riAtI/X5LxbbAMVQ4pk/RBEPvPl1BuWhsf0iQ8urz
yKmgW7Z6y2EvLcqLQAps1dfVtcnHanIhZqW30jgrjd8Dh45nP3vyPb5NlynD0pE7
V7CULzBnNL/YO+d8rUqgRzLebqvx6xjx7b7oeCV/C8HSYVybsKPQrtJHaLan/4uF
FLORIzzXLtB+xzt99kdQPJL7nuedPiSs1isXCNStMIa/yvAuweaKz45NeTStHIiS
KiMhqy9rL699mxHVr5HO
=/JPa
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--

--===============3686574428913442462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3686574428913442462==--
