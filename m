From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8741: Fix (and refactor) volume
 controls
Date: Sat, 16 Jan 2016 16:49:39 +0000
Message-ID: <20160116164939.GE6588@sirena.org.uk>
References: <1452947129-11669-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2952924287462805423=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 365E22604D3
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2016 17:52:00 +0100 (CET)
In-Reply-To: <1452947129-11669-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, clemens@ladisch.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2952924287462805423==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XZCk0ClCHCY/sYOe"
Content-Disposition: inline


--XZCk0ClCHCY/sYOe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 16, 2016 at 01:25:29PM +0100, Sergej Sawazki wrote:

> +static unsigned int _wm8741_volume_get(struct snd_soc_codec *codec,
> +		struct soc_mixer_control *mc, unsigned int lsb_reg)

All the readback stuff looks entirely generic and should be using
generic functions.  If they don't exist add them to the core.

> +static int wm8741_volume_set(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{

Similarly for the set stuff, there's nothing visibly device specific
here.

--XZCk0ClCHCY/sYOe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWmnSiAAoJECTWi3JdVIfQL0QH/2pBMeYlCqae+sscgZRJ2eH+
h/RqjIUlt2Bk6XZUa3kRGQDPjYh+nS8daNBhie4wcRUtZ6iaXqb2579d7gpOvpol
IeEEvC2OC8opaZAliwvaIMB4aIOwAliO4GHdte5CvzE7bd9VQRx87enLvEwvdmyM
QxO/Yk+xxYh2miz3SLcN+IEsDpHoERZQSg8setg9ZG+nNS2jBTg4MgZUqQCSViUV
TVULPCN228IvxG7ULoy4/Wi4wKzA2MU1hTtFwQP0r+N2cjJvEpnQJKHYjSKeKl61
IBVBErhJscJPGa8F9ahdgya+RuHug3mfF74DYBnI82M+tkblfLEcrmTQc3uWnxo=
=uvhM
-----END PGP SIGNATURE-----

--XZCk0ClCHCY/sYOe--

--===============2952924287462805423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2952924287462805423==--
