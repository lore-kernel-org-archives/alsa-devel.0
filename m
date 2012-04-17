From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
 codec ALSA driver
Date: Tue, 17 Apr 2012 20:43:43 +0100
Message-ID: <20120417194341.GX6652@opensource.wolfsonmicro.com>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<20120417170431.GT6652@opensource.wolfsonmicro.com>
	<s5h3982p71g.wl%tiwai@suse.de>
	<201204172015.14582.linux@rainbow-software.org>
	<20120417182204.GV6652@opensource.wolfsonmicro.com>
	<s5hwr5enpau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4234326981304862434=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15D8D1043DD
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 21:43:48 +0200 (CEST)
In-Reply-To: <s5hwr5enpau.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4234326981304862434==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y48FV0AvvvAm5Iyr"
Content-Disposition: inline


--Y48FV0AvvvAm5Iyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2012 at 09:14:49PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Can we make a sound/legacy-codec or something?  Or fix these drivers if
> > they're actively developed...

> sound/i2c are obvious components for such drivers.
> You don't have to react against each rare action.  There aren't so
> many hardware any longer, and will be less and less in future.

That's the case in the PC world but obviously this is exactly how
essentially all embedded systems are built up.  It needs to be very
clear that this is just legacy code for these old PC sound cards and
nothing else, nothing about either the directory naming or the changelog
here suggests that this is anything other than the standard way to add
support for new CODECs to ALSA.

We usually have to go through a loop of "you need to use the frameworks"
with new vendors, we need to make the process of figuring out what they
should do as simple as we can.

--Y48FV0AvvvAm5Iyr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjce+AAoJEBus8iNuMP3dEyUP/AhQQp6ie8bms7UAHYBtMjgC
0J5y4pfXN03/s3VJfESWB+InzZajSlPnar7cntXuYzXcUM5JZWhJgjRwHxvqcyFE
turJ+n07rANlaxp+cSz1/vxKkAyxHWQ7V2mhxWzjToFAOrdl8B81dpozmCMHANSk
EBHUHcF5iEJBdVyqRnRfDfjd3cjI//LKD4eA4l4beSTdDhPFCsa/Z63YHeT9H58D
OdksIutoRiOD1yB69z5No69wIQAXvKNecijuv+HqbgIvdTRaPAe7X+LLbK8XItCn
b0LTShl+KPdtjHkHNgeYQxyVt+h1dFhIa0A+cDELIq02OS4GMFmVYf++WM7Mb9QL
te+r2g5HOUJ5iINEzTl3taBnddbQLOhHzDunpAGQ0q6yPaPKsgMWJhxpi4M/FVF5
l+V8zBRfj0E+hHiPiCiF3SrtWy7bRoxE9Y98tECLcS0F5A2HRhCDXBH0KA2We5en
M53umVag3w4ezzSxGqcME1L2bS7Cp2qB8FkkdwOFITfAzHqhFnCJEzBonQU8njJD
oM8NfMC8rYXqaovSwIogQ9H/JrsX+7XUfaVOYBVGyaDZkd4SZHuqMVk5dTSpwcIr
4SxQ/OWtUE1Hr1QYPGkHKjTsMHyF2EDbTmrc4SnIAsA9olQXehhDT4ffRut+wcXI
aU+c9DxDniNGlsgKr42S
=uvH4
-----END PGP SIGNATURE-----

--Y48FV0AvvvAm5Iyr--

--===============4234326981304862434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4234326981304862434==--
