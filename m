From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: dmaengine-pcm: Add support for
 querying stream position from DMA device
Date: Mon, 11 Jun 2012 22:57:42 +0800
Message-ID: <20120611145735.GU11439@opensource.wolfsonmicro.com>
References: <1339416253-4121-1-git-send-email-lars@metafoo.de>
	<1339416253-4121-2-git-send-email-lars@metafoo.de>
	<20120611132409.GG11168@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7654041450617914169=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 41CF524521
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 16:58:20 +0200 (CEST)
In-Reply-To: <20120611132409.GG11168@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7654041450617914169==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LtN0I0gXzHUftVCi"
Content-Disposition: inline


--LtN0I0gXzHUftVCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 02:24:09PM +0100, Russell King - ARM Linux wrote:

> What we need to do is to get rid of this idea that reporting the residue
> is optional for DMA engine drivers.  Let's make it absolutely required
> in order to support cyclic transfers.

I tend to agree, if we are going to let things not implement this we
need to provide an out of bounds way for them to signal that they don't
support it and make it an error to use the interface at all.  Otherwise
the interface complexity increases as you get into special cases and so
on.  We only need to fix the drivers that are used with ASoC immediately
and there's not so many of them which is easier than being forced to get
every driver upgraded at once.

--LtN0I0gXzHUftVCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1gcgAAoJEBus8iNuMP3dyMMP/RVqeNqbgn6Zi3Dr7+LRST6q
JMvM/uslSSZVOsIl6WTSPA0nwCwNEdK9im1hJM/irqolup/X/h5elwXJ/umRNvzk
erQvvp054vrcLzo/HK6LBGpQiwDpVNfnRpGozScISOpu/DJWh5BH/KrMX/frKncx
Z/lTpsunUE3vc60FqD3yA2DXeN2N7m82cavEYidhU7sQZJ7mM6LOl960AhRoe5BE
ukRR0uxOmOkZEPiBjA6rABKZIv27pDcQ9J7LZdRO5j2FO5QXNtw/lcGuLXCKM63+
gaTJcVx9UPV4itHO0rQf8Gps9wKU56aABoDUm502Dq5aEDnBWUiG5fpv4Ez+ISAc
NavsrmbyLMWdAPp8lkt5zuuyhlC9bt/+LDpr4ZPx0yDxWF6UUAxuaZ1KfWFcFqHN
OSXILOhf4C8DiUkKbfgqL5npcPacOodoobSbfPCegwLfaz2G2A+1Tc60bQ5DpB7V
SsRmxjvjFCNtf2lSxQ9Nm8hHWS1PlN2kce7NvCLeGYqPYa8A6zUIXp+oAt5FRa2x
IFkSINNfH9jguwOnooRXONQgfEO4frET69awc5EV4lyB5wBAaJQpZ1kCxAgqpHvz
VNcLFbWNl91sBM3ItgRs0CLYhE2poBoLRnr6vCrF5uOuUcaUjjfP4uz8TVmzt1pj
7dOz6hqN+P5nvGRPMyks
=Okfd
-----END PGP SIGNATURE-----

--LtN0I0gXzHUftVCi--

--===============7654041450617914169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7654041450617914169==--
