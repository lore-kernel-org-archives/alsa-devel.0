From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Wed, 7 Aug 2013 14:05:40 +0100
Message-ID: <20130807130540.GZ6427@sirena.org.uk>
References: <1121E117AD4ECE49880A389A396215BB935C692E62@rtitmbs7.realtek.com.tw>
 <5200CD0D.7030007@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
 <5200DE78.5060409@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692F72@rtitmbs7.realtek.com.tw>
 <5201FB09.1080105@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692FD9@rtitmbs7.realtek.com.tw>
 <520204BB.9080603@metafoo.de> <20130807093629.GU6427@sirena.org.uk>
 <520225B4.5050208@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8678219367290775574=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3051D265491
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 15:05:46 +0200 (CEST)
In-Reply-To: <520225B4.5050208@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8678219367290775574==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ysXqiu0yoUmUNJB"
Content-Disposition: inline


--6ysXqiu0yoUmUNJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2013 at 12:47:16PM +0200, Lars-Peter Clausen wrote:
> On 08/07/2013 11:36 AM, Mark Brown wrote:

> >Adding an event callback shouldn't be hard?

> But tricky. The widget of course can have a event callback, but
> since the widget is created by the DAPM layer and not the codec
> driver there is currently no way to setup the callback. And then
> there is of course the question when do you want to run the
> callback, only if DAPM unmutes the control, if the user unmutes the
> control or both.

I'd expect to run any time we actually interact with the hardware.

> One thing that could work is to setup SND_SOC_DAPM_{PRE,POST}_REG
> events for the SWITCH widget. This callback gets called whenever
> user changes the control (and it is not disabled by DAPM). The next
> step then would be to set up an internal event callback for kcontrol
> widgets which then again calls the event callbacks for the
> kcontrol's widgets like we do in dapm_widget_update(). But I'm not
> convinced that this is the best way to solve this. I think it makes
> things more complicated than they need to be. I think having a
> OUTDRV widget along the path that runs the mute and unmute sequence
> might be a better option. And then have virtual switch control to
> let userspace disconnect the path, so that it is still possbile to
> manually mute it.

This only works for mute and unmute, it won't work for things like fun
sequences to do volume changes.

--6ysXqiu0yoUmUNJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAkYgAAoJELSic+t+oim9kC0P/1znXzXx2k6J+LGbwlcUZ0uQ
/42iUIgQw6vnQNRfwdGyuBxfN0E1EpGpMOq0oxxnP0++wKrcTfs8m+DmZ2zM6xlW
58DA4fWS1E+iRcs6PJKCu3rhmiP1tqP3BF5iprIQokVvYJq73R4sO9MX33ZSWG2W
VcAJ9J1DH7Z+7zpThnR+B+bzK+Ola4OpQP838p2f9zyKY4sUZU2s2Syfu861bPTB
fjcxi/oZZxGXxde7RJSRIbVgNQx9yQHj3jI9lOyx/ibpM5dJNiMKe8JtY/XcvXCD
wP7euX+sDZdr8eRMSwVvncDnVXgXFg9H51tOmlwSLpB24vzXfEmQNkMvKqvsLIhp
jKDNnQiFxo8CLcJsfRbSVrIWKShrRLWa8aEyq5YXaWmqOns59KLjTEBJLwtnPh3y
DfvaZS298QVG1H4ucvCPe/nDEArtvhLL/5F9cXUZz7Ba0r36xAGgWSCfpVhaVRXD
j5ig104AAfPcpD+SZ/KFTE8MkzXYfrnhENXWyjEKVtXCYqcLUgf2nHSyejnBvcLS
lI2eMahtklJbjBolNqaCTcm12hNpnKGfhvNccrK0bTTuGGw9viwPx3fvajyV6yop
CdXw4It7i71F8ANxnriU2/YzBCm2JENsfg7ngV0+bTG4um4eP6ktLDkp+Nm2rIVR
s6lT6Nw0dDOZZ64WpZfs
=rqBm
-----END PGP SIGNATURE-----

--6ysXqiu0yoUmUNJB--

--===============8678219367290775574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8678219367290775574==--
