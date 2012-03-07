From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Wed, 7 Mar 2012 20:00:19 +0000
Message-ID: <20120307200019.GK3107@opensource.wolfsonmicro.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<20120306200354.GB19635@opensource.wolfsonmicro.com>
	<1331115061.3829.11.camel@odin>
	<20120307105426.GA3107@opensource.wolfsonmicro.com>
	<1331118805.3829.18.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5467777499477764415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B89F10B95E
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 21:00:22 +0100 (CET)
In-Reply-To: <1331118805.3829.18.camel@odin>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5467777499477764415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pfJPkqu8nAxkAh8+"
Content-Disposition: inline


--pfJPkqu8nAxkAh8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 11:13:25AM +0000, Liam Girdwood wrote:
> On Wed, 2012-03-07 at 10:54 +0000, Mark Brown wrote:

> > Yes, we are but it's a simple comparison with integer so not the end of
> > the world.  I'd much rather have the check in the locking code so it's
> > clear what's expected instead of split between one of the call sites and
> > the locking function where it might easily get missed if someone adds a
> > new user.

> Ah, I'm thinking with a different perspective here ;-)

> My reasoning is that the widget lock will guarantee the component lock.
> With the regmap test we don't guarantee a component lock and subsequent
> new widget lock users may depend on this lock.

I don't understand what you mean by "component lock" here.  Do you mean
CODEC/platform lock or something else?  In any case it's stuff like the
above assumption which makes me want to be explicit here - either we
should take the lock in all paths or we always skip the lock in regmap
paths.  Either is fine for me, I'd just rather keep it straight in my
head.

Actually given the number of indirections here (there's similar "is it a
platform" stuff for the I/O too) we probably want to create some base
class object before we start adding more stuff anyway.

--pfJPkqu8nAxkAh8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV75MAAoJEBus8iNuMP3dijMP/06n1tLEY7Qpmuzl3Uqab1OY
MWUqXZbM/DkRR88uR7EYqlbzWkavsNFKAzmA9RUDRDQ0UbY4tsX3L/GIl9GtfCMu
YoxrP1xq7fx95qPR9nRT9BhHLXjSTNCrhbPe6XMqaeYpU05WO+4Ks9KgnyBZZv7m
NmePAIjoCHOCkcSufM8l2LizokO51B08heUZ3o4B/Z3jT7BaDWwQcyteyPSU6pxr
8BviNJKXciKk2EB1Ax0gCbLOdyHYmGJaSqDEW+q4PzpMUQs1W60c//OqUyffblXm
FoYDHMwL7WOCEfl91fN8cwV6ynl4RJMC5YJQfXae3K0xRJJbtVJwo4FUX2lFQWxz
wm1poRALlA7cUlpVN5O/ca0rKxAHrG12L9rfNbajGOxzTiLobxqZY5xuaLDBLVgC
22Kv7XnsgcW790m7Ip8sge40KHGeI6HqmA8ZiYpuZ9Goab2vqvHmONSeBcD7gUUP
Rc0sijbHjYhU6gNKKlxax3oO8aMmaSJLTzou1UMPlXekXxiZxzUN6Qc2Y5bKo+Sa
Rde9oMzhGHljk6anY7r0wifAIml0IYkVf0moS8G0kdeU16lynVZ2liRTpKoKt6K4
i5wa2T+DkXc7HcXCaSCYooOn0vOCy/OD1l/JnMqrF4SJD81u6vOz1IOJh5pkEZNB
kI+j9hF9xlvgWZsSosJ1
=aIup
-----END PGP SIGNATURE-----

--pfJPkqu8nAxkAh8+--

--===============5467777499477764415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5467777499477764415==--
