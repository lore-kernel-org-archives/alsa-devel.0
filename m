From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
 for ML7213
Date: Mon, 11 Jun 2012 16:54:05 +0800
Message-ID: <20120611085404.GB11439@opensource.wolfsonmicro.com>
References: <CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
	<1337941231.1580.19.camel@vkoul-udesk3>
	<20120527221956.GB25019@opensource.wolfsonmicro.com>
	<CANKRQnhwkhGUHi6WQhw-sRJuKari3SLcipCJXVp27OZ29=Vxkw@mail.gmail.com>
	<20120530121449.GI9947@opensource.wolfsonmicro.com>
	<CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
	<20120531104538.GA2666@opensource.wolfsonmicro.com>
	<CANKRQnjdiV+e=N+n_ZP04jmCAhxKjgZ+wab+anbgO+VJPNo=PQ@mail.gmail.com>
	<20120601083018.GH24139@opensource.wolfsonmicro.com>
	<CANKRQnjeYtBucmGoDUg7oTK82rvnkakWRB0Siezyz-kbhyPC+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0453561807557445421=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 717D81041E1
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 10:54:32 +0200 (CEST)
In-Reply-To: <CANKRQnjeYtBucmGoDUg7oTK82rvnkakWRB0Siezyz-kbhyPC+g@mail.gmail.com>
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


--===============0453561807557445421==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 04:05:56PM +0900, Tomoya MORINAGA wrote:

> That is to say, some drivers ASoC DMA framework. However some drivers
> don't use any ASoC DMA framework.

There are some drivers that predate the availibility of the dmaengine
framework.

> Why didn't you do porting to your saying "ASoC DMA framework"?

This, and the fact that the PCH driver uses dmaengine without using any
shared code, is the topic of the discussion.  It is entirely natural
that there are no open coded drivers using cyclic DMA via dmaengine,
they have all had that code factored out.

Please stop this and at least look at factoring this code out.  If it
turns out that there's some reason why it's a lot of work that's one
thing but it seems clear that you've not even looked yet.  It's like the
previous issues where you were sending patches which would clearly not
run successfully, it's not a very positive approach.

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1bIhAAoJEBus8iNuMP3ddVgQAJcrfdr+DY+i/KiFN+auDY6E
oL96PlUFpLsDZa4WpgDbJyx7NbDezHxNl+mQYiHZZmYqEY+rajfTYZ9TIZXZDutL
ccRLYWZ8bzqrsaagCLpBwaZa/SKm30k2rHvmKY1NbvEcXDin00RGm+JTw1NbQJCV
zWvOElaTDl+pCSZEK5FKhFfB52HNjYx+3IPCt0rFDeFodmZct4BTV9bWAMEXlJDl
L5+OFk3S9Kx8DZycymdYcYKIysHYSW48P7kWXKdMq9/Ef15R1Kd5pmnBtMKUd10W
TWWhZO+wbx6LewAenn3s9NHH1RzdFFMTuBoRofnHITPR38MjCo/2z5OTLvecJ1Gq
RIXrQ3CMDhFnzIWoXn93nKHDssyDcBciyfPzzwgdLzCzLFiqV5Guk4ufz6atodMJ
IxzPGF15StSv6iH3JMc0vgVZMbrlqBcb/6KEWkApgUcF7wiH5zLzCuHIClZreX4X
WLEzvNe4v0VNUFnEmTnXcXGJCZc2jDPbBh92aOMEPW6Jy+ds2XYER30cnnMVMyq+
F2+bTB+nQpcaf2OmNw1FkeAYo4v1+liAMVZC07TjUg2hYwBQtB0t/tT36H1YiDki
9oUsp7oA72D/aYcYiBIzdR7CLjiq59691i1Ob70d+uULCZ3gM5+1kPWAsN0UwFSN
tRW2Tgmc4yAVnK8kx8rf
=PjxK
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--

--===============0453561807557445421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0453561807557445421==--
