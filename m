From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
 codec ALSA driver
Date: Tue, 17 Apr 2012 19:22:05 +0100
Message-ID: <20120417182204.GV6652@opensource.wolfsonmicro.com>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<20120417170431.GT6652@opensource.wolfsonmicro.com>
	<s5h3982p71g.wl%tiwai@suse.de>
	<201204172015.14582.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3162966674233893242=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4179110439C
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 20:22:07 +0200 (CEST)
In-Reply-To: <201204172015.14582.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3162966674233893242==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NBQMqqtZQBFxm+aD"
Content-Disposition: inline


--NBQMqqtZQBFxm+aD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 08:15:06PM +0200, Ondrej Zary wrote:
> On Tuesday 17 April 2012 20:06:19 Takashi Iwai wrote:

> > Yeah, these stuff can be better put in pci/ice1712/ directory only
> > for ice1724 driver.  In that way, you can avoid unnecessary exported
> > symbols, too.

> Xonar (oxygen) has a private version of these drivers too. It could be=20
> converted to use common code instead.

Can we make a sound/legacy-codec or something?  Or fix these drivers if
they're actively developed...

--NBQMqqtZQBFxm+aD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjbSuAAoJEBus8iNuMP3dxEgP/jJQRq8WAj4cAGjedX4TTpfZ
VUvkHmI1HKIgB+va5RDWF/65HuerotczlpffydZss+LGkPqTYqQGJgHUvymfuinM
gIFbGkW/d6K1O7c7huCTUqbsH8SIAfxLAlXHLJTqzJ8uofc+HGqFP7gf5VcfYaFt
v0JAOWFOxh5rH09+x7iM4y8kDg4DK35UP5Xgl7TgbelFsh+I57XKKY04kOzzoMAU
qh1/3+MQkQ4JVxKxx9sf/BfRCMrbSlRqRtIgGg6WKVrtL8Gc9CNeTIxFL9sOHDYw
jqjc0bjheB9ZdExGc9FQuWsYlHTvmFnpHnuJB8D7fG7HIgY7qDSePLJjMXx6LNET
wMi4CplLwhGi2Gf0sbFAMCj19fJ45p/ML2ZqDuy0OMVmCppSija4GxaLQnYKWbxa
XPkoXka9NByJZLqkCycOFsifPQl4IWFsNCKwA10Vou5yevY5XAPpo1dAHivmRs14
d5LgCK+vq8sfzz68evDz/3cvdlM2laWeyvzhkTo0HYAihKqIuG9rxgcFcG7HJpap
C59ElVCbvsMN4+PR6L5kg6qden6SFy/xdx0ewvU2dDTPbd1kVkiqipLTCcajJhv9
OdQeh8qOSAcaTdHKVy0KMdV9hu+5FYxug03/zn7doXR0EcugkinHezXgMB6FdVUG
LM5aVQafzcZAXhobf/v5
=xGZI
-----END PGP SIGNATURE-----

--NBQMqqtZQBFxm+aD--

--===============3162966674233893242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3162966674233893242==--
