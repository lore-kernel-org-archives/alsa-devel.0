From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
Date: Thu, 7 Mar 2013 10:33:19 +0800
Message-ID: <20130307023316.GA22554@opensource.wolfsonmicro.com>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8761496378586179072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B67F7265CFB
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 03:33:48 +0100 (CET)
In-Reply-To: <20130306171333.GR17833@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Huang Shijie <b32955@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8761496378586179072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2013 at 05:13:33PM +0000, Russell King - ARM Linux wrote:

> This purpetuates the brain-dead behaviour of the existing ASoC DMA
> engine layer, which makes it unsuitable for platforms with special DMA
> memory requirements.

> The problem is that the DMA mask to be used for allocating DMA-able
> memory is the DMA engine struct device, not the struct device associated
> with the ASoC device.

> I got this right in my ASoC generic DMA engine layer.  Converting this
> layer is far from trivial though, and as my test platform has now become
> my entire network firewall, I'm not doing any testing on that anymore.

Could you go into more detail here please?  Looking at the code I'm not
seeing any allocations done by the library code at all, the allocations
are all done by the individual platform DMA drivers so I don't see
anything stopping them doing what they need.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRN/xMAAoJELSic+t+oim94/oP/1Q1tV6xTRwE3oe6K1vE0FQ3
MUBEMe6W1Ryu0KORFiFGt2Zs9RwtJ7+S6a1bp4x9LiMm5x0lfJRPLuz2u7Rg3btS
7+pLnPjVGVyKz+6IakBUCEbcBTIaJpXG/RU8cHLCn4T+h2xKOiMylwv2AQYCWVdr
tsgBEa2nY/zQS9wozZpukosjfgk/FKr0Qx9gf6ju0eyP2NtjxYEqFns0n8SprdEs
T/e76y9nrjXt42W6nO4IxjwWHM3uzIOQxKDW6Ed8pRPekYf8nldM4i5SYbXs6kml
Xj20lsV7sbDwdOMjyky+5XAOYg89il0zinynD/XI/HzWuDDxRDnA1T4F6vi/PuVs
qIqXsI3d3NgPS3aS64JS5otcd7X0fXiVjtiwdaZrR4DyZPt7X3+J0AyPN9aaIr1L
lXtlMJ6Zrk5Ef/SYtsvEp6ixN1WGVB34/6qVf4VTbTToTMo/JbDFmqP63YVwXdya
q/6d1t4esApZOPX+3kzfH5NKmXFiEchokSmUNa0CnsxTM+kgIbfX1igPjwQxV9+e
WAyqJzqEYKgdlBaYf34+thH7Bv+D0gfNMVhOzww8PwxVHSS2VKZ7sYsgeaSmcJ/2
RBNf/DhYZmktivXeyGVoetV3sAnO/66vjqsdN3pkAzJwdAkpzXRJVCSWXL2CG5zE
rUdghBWWKq1odpqpWLMX
=Opl8
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--===============8761496378586179072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8761496378586179072==--
