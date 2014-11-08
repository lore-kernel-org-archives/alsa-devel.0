From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm9712/wm9713: Replace virtual
 registers with custom put/get callbacks
Date: Sat, 8 Nov 2014 09:45:18 +0000
Message-ID: <20141108094518.GE2722@sirena.org.uk>
References: <1415039583-4858-1-git-send-email-lars@metafoo.de>
 <1415039583-4858-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6239454146671979918=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A74226045C
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 10:45:47 +0100 (CET)
In-Reply-To: <1415039583-4858-3-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6239454146671979918==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 07:33:03PM +0100, Lars-Peter Clausen wrote:
> The wm9712/wm9713 has separate mixers for the left and the right channel,
> but the inputs to the mixers are enabled/disabled by the same control.
> Currently this is implemented by the driver by registering two virtual
> controls for each physical control, one for the left mixer and one for the
> right mixer.

Applied, thanks.  One patch per driver please unless there's a reason -
I usually have a branch per driver, there was no branch this applied to.

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXeYtAAoJECTWi3JdVIfQaoYH+wURd4TpiMSFK1qZjuJAmGEu
oIpxjCLPwcaoZVLdhgcKiFvEjR2WhwSZj2OsXla28gbx9nWF22eO9H3RXrCPUSDi
AU0XtOPepeMZyIegmR36k4xXIUtK5xPGrz+54hG486yJn6dE+4hIO+OlEfRMIsEX
F+UaS+CExBzE1syy4wPv642kz4GuY3US0QdTF/uvcmrLKd1AJxt+bojRFlGho/U4
0bhZVCzZirC7CCx/Z5Nc+cLk+zghJ9NToboVH/jLvA+9tOXLN7KbaP3SAk+iGFqq
CbeNHaCtHy3/WAyPU9D+XaHHiFPESi+ZvC8oreUmcqxs4tYpzvnmiRBbRmStAlw=
=6MUY
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--

--===============6239454146671979918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6239454146671979918==--
