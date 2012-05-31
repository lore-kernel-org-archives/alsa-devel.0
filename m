From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
 for ML7213
Date: Thu, 31 May 2012 11:45:38 +0100
Message-ID: <20120531104538.GA2666@opensource.wolfsonmicro.com>
References: <CANKRQnhn=ALR0ucv5gnvwnxwxBQX4ajm9Jo5qC0fL-EFjDdoZg@mail.gmail.com>
	<20120523093857.GC4085@opensource.wolfsonmicro.com>
	<CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
	<20120524100742.GH5361@opensource.wolfsonmicro.com>
	<CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
	<1337941231.1580.19.camel@vkoul-udesk3>
	<20120527221956.GB25019@opensource.wolfsonmicro.com>
	<CANKRQnhwkhGUHi6WQhw-sRJuKari3SLcipCJXVp27OZ29=Vxkw@mail.gmail.com>
	<20120530121449.GI9947@opensource.wolfsonmicro.com>
	<CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2788439281644364226=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 654852433D
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 12:45:40 +0200 (CEST)
In-Reply-To: <CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2788439281644364226==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 31, 2012 at 02:38:30PM +0900, Tomoya MORINAGA wrote:
> On Wed, May 30, 2012 at 9:14 PM, Mark Brown

> > Please re-read what I wrote.

> Let me clarify.
> Do you say native DMA driver API like dmaengine_prep_slave_sg(),
> dmaengine_submit() shouldn't be used from ASoC driver, right ?

Your driver should be written in terms of the ASoC DMA framework.

> > No, all current mainline drivers using the library use cyclic DMA.

> I can't see any driver uses cyclic DMA. (I saw linux-next's tree from
> kernel.org.)
> Where is your saying "current mainline" ?

Linus' tree, or mine.  Have you even looked at the soc-dmaengine-pcm
code?  It uncondtionally requests a cyclic channel.

> However I think it seems difficult for supporting all devices.
> Because hardware dependency control code can't be added.
> For example, for ML7213, needs interrupt control both before/after DMA transfer.
> However,  in case of using soc-dmaengine, the control can't be done.
> Because the processing is in soc-dmaengine.

Please be more specific.  What are the concrete problems that you see?
Why is it not possible to address them within the framework?

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPx0vLAAoJEBus8iNuMP3daOUP/jeBkne9p6xpOBBMU/sT93mG
3sGyS/mgJewK6VMx5h4t8D6eXNhWxxu6wtdVGvLoK50iZv7FsMkFdM3WU+gtTuX5
4cFQ5XIAcUCkPUCpaI7261tAEJNT5UGKxx/8t6pxH6jKwDKde7KGmR4fGKLESbES
5jyJgOyn29ZVXzUJ4gKOw7kKtCHSylR0XzhVZDdvVVi/pNcUhdbLOqKy+KxFiJ3O
v86iftLLta2yIf9HVJnbntprWEtFjV5xT5WfYsV06Nkw3lrn9+aXYo9/XKIXklPh
6wNEnQ2GG9iNOazPbTuHXa775YsFoDN9xy8AC6sGc+AumpZgSYuzTmtFTIEvd2hU
9yxaoMAsiLktcbwhSIl9PEEibu68INjPsQF7dHG6kW9ySgG3zSKeikfDI6FUFrA8
pcwSt4UgGdwlG1krmNcYxVrfs9nD1gc2h+LiMxoIhv26LxjIGBDKpXTLVXVwOHVL
NOe13aZsWjST0mB8r/CrgavJvdd/rIo7yM7rcOP/u7vnt+baYLIZWRlh2mnd6Kj3
MgIzfNXMOlRkYir7MO+27d4MOp6qHzGwxGZIEJqdvt1DGR2mbfAV3vCHXleyrNcK
/YvtyeU+yqvX/uhYGscHc2nHUSxQ7egj2SPPvsdI03GXvpbD9Z0saFzarYFNDsAZ
GVByp+6fOfXy9uUR5J2Z
=jXl1
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

--===============2788439281644364226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2788439281644364226==--
