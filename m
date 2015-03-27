From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 14/15] ASoC: rockchip/rockchip-hdmi-audio: add sound
 driver for hdmi audio
Date: Thu, 26 Mar 2015 18:19:14 -0700
Message-ID: <20150327011914.GA1743@sirena.org.uk>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>
 <1425179070-2736-1-git-send-email-ykk@rock-chips.com>
 <20150326181620.GZ3572@sirena.org.uk>
 <5514AF61.2050909@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4757691448138663492=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5514AF61.2050909-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: yakir <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel@pengut>
List-Id: alsa-devel@alsa-project.org


--===============4757691448138663492==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 09:16:17AM +0800, yakir wrote:
> On 2015=E5=B9=B403=E6=9C=8827=E6=97=A5 02:16, Mark Brown wrote:

> >>+free_cpu_of_node:
> >>+	hdmi_audio_dai.cpu_of_node =3D NULL;
> >>+	hdmi_audio_dai.platform_of_node =3D NULL;
> >>+free_priv_data:
> >>+	snd_soc_card_set_drvdata(card, NULL);
> >>+	platform_set_drvdata(pdev, NULL);
> >>+	card->dev =3D NULL;

> >If any of these assignments is doing anything there's a problem with the
> >code.


> Yes, when probe failed, program will goto this code.

You're missing the point, these don't do anything useful.

> >>+{
> >>+	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> >>+
> >>+	snd_soc_unregister_card(card);

> >devm_snd_soc_register_card() and you can remove this function entirely.

> do you mean that when I take devm_snd_soc_register_card() to register car=
d,
> then I do not need unregister card any more(destroy with device) ?

Yes, that is the whole point of the devm_ APIs.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFLAMAAoJECTWi3JdVIfQrikH/AgjFgaZRAKWgLL0td8JRqV7
j40bEsSqarnegkjO6wzGZnE2PqqkoGb3V6cCFey1z9YlY/5SytRTwYs/kQ3Fg8aU
k5/7VmmFp7qE/fpTagPnlxr0f2Fpit2h7oBCIfBFYotiYBftFKfcBSOiIVkC22ML
+iIwbWnM5GyWVghmMjvHjgNUlQC8gE5G73RwsRC1MkKV6Ob8G868e7IkRe+MjGv7
STElmVwoaRH/ScH1rB6aWRyJs4yd2ljXeiJ4XWdH4QYAvK/zryMC8ezlmXfESckg
+VPZ0nzCnwt+0zZSJkPdYAjzKCEqsPN5fKyTtxXA7vhvgkTztDlM5BQ3OFe4Gwk=
=6dCg
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--


--===============4757691448138663492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============4757691448138663492==--
