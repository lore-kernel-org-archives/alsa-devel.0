From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/5] ASoC: dapm: Simplify
 snd_soc_dapm_link_dai_widgets()
Date: Mon, 12 May 2014 21:37:09 +0100
Message-ID: <20140512203709.GM12304@sirena.org.uk>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
 <1399472428-11034-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6423342210445014917=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BCAE265134
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:37:23 +0200 (CEST)
In-Reply-To: <1399472428-11034-5-git-send-email-lars@metafoo.de>
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6423342210445014917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2C5Q0iHunA0/kEvg"
Content-Disposition: inline


--2C5Q0iHunA0/kEvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 04:20:28PM +0200, Lars-Peter Clausen wrote:
> If we find a widget who's stream name matches the name of a DAI widget then
> thats the one it should be connected to. Based on the widget id we can say in
> which direction the path should be. No need to go back to the DAI and check the
> stream names.

Applied, thanks.

--2C5Q0iHunA0/kEvg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTDyAAoJELSic+t+oim9fCkQAJAr2Wcxi+Jp4jvuJKLzBM0z
klfLcc7HU3saXqd6z68sS7pyPc15c7IgNEg+JDILsjodPTyB6gVhuZ216ENZSSqn
EF+YWQ8wiqnYikZm5sDIzm48rjf0jiQfUsnjBmghzpbi/CVG3PXnQsPoTIUTpm7T
q0405vF4OT4xqymuernpVlz7D+/1QoxR40SH6demJrhonrOJ4QLGEGle1ZO/WYl2
rH4Vp8iQsheSGpt7ueVfLrB3H4tq251YE5x3GNDbeyBT8Ga9pbM7VBxZp2/WI98I
uRTl8UZhls5cWe1Fy6oRgjZSatlfLnWoI9lD2LSCxsKypRJC2RclTPaFx+ia7QC6
lCjHfZScMuaU9Z37oecQJwuWWlS/K/po8qodHV8PIHyY5GjePEH1i9QXZ1y6/gxR
b4e214zlXHGjRcELSh/qWh6Eufwai+XY1x/Df88sVGczVE+52x6ICQwPj+7K4G1W
Jj79xOqIqTg6wt/gwwulxGLa4CSStP27UBxsKEO448JvNYtPT/D6dGxg+ZWK6/CE
2f4fM5hBcy7gtbF2/lbrlpoBpi47dk0PUs4jmR8LBC92LPNCoefEdtf52RqwnFIu
LTUHmuCbdO6q+GLdbSXrihY8E4sd1H0xsMXucL6yVdyPmG7j2O0F/kcgzHW5sUfC
EJ0hlLpdfI55Qmx/LLnv
=Crex
-----END PGP SIGNATURE-----

--2C5Q0iHunA0/kEvg--

--===============6423342210445014917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6423342210445014917==--
