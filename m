From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND] ASoC: omap-abe-twl6040: Add device tree
	support
Date: Thu, 26 Jul 2012 10:52:39 +0100
Message-ID: <20120726095238.GR3099@opensource.wolfsonmicro.com>
References: <1343221751-29863-1-git-send-email-peter.ujfalusi@ti.com>
 <20120725131507.GM3099@opensource.wolfsonmicro.com>
 <500FF709.9060205@ti.com>
 <20120725214837.GQ3099@opensource.wolfsonmicro.com>
 <5010F73D.6020904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3054714904094333121=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD914264F1B
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 12:01:24 +0200 (CEST)
In-Reply-To: <5010F73D.6020904@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3054714904094333121==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rKoHqF+aPLVth8b2"
Content-Disposition: inline


--rKoHqF+aPLVth8b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 10:52:29AM +0300, Peter Ujfalusi wrote:
> On 07/26/2012 12:48 AM, Mark Brown wrote:

> > Please just send the build fix with a followup adding the DT bindings
> > and then we can get the DT bindings in for 3.7.

> We do not have build breakage as of now since the DT bindings are not in.
> The build breakage happened on my local tree when I have rebased it on
> mainline yesterday. Stephen can not update the DT part of the omap-abe-twl6040
> when he did the snd_soc_dai_link cleanup, obviously.

Ah, sorry - I misread what you were saying and thought that there was a
build break in the current code.

> > Though obviously it's not even been compiled in mainline :/

> Sure it has not been compiled in mainline. It was/is compiled on top of
> mainline during my daily work.

Right, that was me thinking there was a build break with the currently
merged code.

--rKoHqF+aPLVth8b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQERNSAAoJEBus8iNuMP3dafIQAIrIgJ8+us4U7M7fEsuqzdW4
wlMgCl2P3ZpgzQIKNaUjBp7Wdq9MhZVmNreC8eNDji61htAirOhnGgjXJPKeMkE5
KIcCnNb0p8C/s4NrP9J8PJ/XXbQpzfXvq2UmaFpxs/5W3ZdO2JwlrSmMzz4p+Bd5
a4ApcBmQyDW7gUkfpyaguKpO1mcYVR2h9nKyuDh/OIy811EMBHVqUQQG2Tenpt0/
nnZBa9istrOsYPqTo6zoL73J267NLxa7oAVOlxZeYsqaJIXID5NsUhOJW2h1+Ekr
j8KVj3V/cQ1qxiqsPHesohaz2PDXRYOhY/uZVKoB07PhRj6ZJlVVlMXKkMo24O4P
DlvuLPfUH7UYEnM6LMYQztapoGJ0hgvGapn8kzDvJgkPVfyMUMpFEzxcrdC9qywJ
PI4dyt+tI5oL4IjCtodtmqfDhsobI0K/qGsmUEZdqtQJ2hC2POz12Hnx4KnQsQd4
n3X7/CraDTcozbjGA75BVMsN3e5u/xHC04OqgFW3MIcd6yrcBtP8ygxHJVhJJBgx
GyfZH0ffxXVuIcqvzutBkXkZKQZ9ytb3XbDgs2CB7UoyeYO8GFun1xf3NOtdjinL
l+PVpHeYe9Duf6NOT40I0GPchZgpS2MlP+Tf53WqLBREbq/q9eC6h2ekz9lGuKqH
EPamvqN8SG6TwaWJ5Y2J
=/hHo
-----END PGP SIGNATURE-----

--rKoHqF+aPLVth8b2--

--===============3054714904094333121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3054714904094333121==--
