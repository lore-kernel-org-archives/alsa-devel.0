From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 23 Aug 2012 13:59:04 +0100
Message-ID: <20120823125903.GA7995@opensource.wolfsonmicro.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0997421103957869484=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 270842661E5
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 14:59:06 +0200 (CEST)
In-Reply-To: <20120823121936.GA1047@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: roger.xr.nilsson@stericsson.com, 'Linus Walleij' <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Ola Lilja <olalilja@yahoo.se>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0997421103957869484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K2zDyWOedq9OeiNe"
Content-Disposition: inline


--K2zDyWOedq9OeiNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 01:20:03PM +0100, Lee Jones wrote:
> > I say I don't understand the motivation for this change.  All the modern
> > DT bindings are perfectly happy handling this without an explicit shim
> > in the device tree to bodge things for Linux, adding them in seems like
> > it'd be a retrograde step.  What benefit do you believe this brings?

> How do the all the other DT:ed audio drivers handle the PCM then? More
> importantly, how would you like to see it handled? Ola has NACKed this
> patch and explained why:

They instantiate the PCM driver dynamically from the DAI when it's
probed which is pretty much what you're patch is doing.

> "I'm sorry but this patch is breaking the design of ASoC. The ASoC-
> platform is the DMA-block (in combination with the MSP-block), and
> there should be a platform-driver for the DMA/PCM. The platform-driver=20
> then has a DAI which is the MSP. The ASoC DAI-link-struct should have
> one driver for each of these, so the dummy-driver for PCM should be
> there."

> So I don't really know where to go with it. Any ideas?

I think Ola is suggesting probing the DMA driver from the machine which
will also work though I'm not 100% sure if I'm parsing the above
correctly.  The issue in DT terms is that if the DMA controller is
shared with a bunch of other IPs then it should have one node shared
between them all and not a bunch of shim nodes inserted in the middle
which only exists due to the way Linux instantiates stuff.

--K2zDyWOedq9OeiNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNijOAAoJEFJkBDiqVpZ4EK8P+wWshc+fXiAY6r/T9dVfQX20
75oB7ejh7nEAI+ejT1OR/KDrEqoyVbsn4fhY42EfvmQ0K+z7RN6894f2fMq3Yj9s
RT/SxDKaQA/GSeINwW6KqDsbP1j5NzrfgqZnylblR0zmYUiNCsLmCT+Q7V5JwsTY
QDHYz0qrCMsB7wzG+kMpDbW4vhgFKarUcwutKGkNBIVhOO8ydI+oYrM+FvSYP2Lw
FFcb7AAp/JT5s2j8sLSdstuNmwZB6juF2w4By4Dm87c9+7LCEl8uS82QsZcvcyzT
nBT9OEhtd2E8J32zGM15kQnAS6zHnYbOtfOGHpPZMCEjg0nkeg/cjo4H7k4egN3w
aizcXcwM4sYDV3SZSajZ9kEFbqClYKGcKXufwVeSIMdcJrH+AWiY2GzrTz6fCS/H
x29WIK2OG4XaUyrWWNE5HjVBd+iHiOIypEJK/TtclYOugMNVPdYnHvvogDeqwGp7
m5BtgvJdP8eLLn23YDBmM4SGBKbTRmmPglKppzLK3cVAbP8kmaqcSBUsYzvM26UJ
+/I90EPL5r9JQLAwIZ3PXCvjP/VjDun3egrD5hOEwWe+Pcb7F0gXXBDAarC9wXQI
OaOfXR6UyGDopUpMLZbiUBn5/rwbNsJVdtbWvkSoy/k1JXMxgw0tgmwxRrZhBGS4
iiZLujcGLdckuFU0ieSu
=bMcE
-----END PGP SIGNATURE-----

--K2zDyWOedq9OeiNe--

--===============0997421103957869484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0997421103957869484==--
