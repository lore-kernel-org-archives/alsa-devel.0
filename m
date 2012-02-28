From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 7/7] ASoC: ep93xx-pcm: Use dmaengine PCM
 helper functions
Date: Tue, 28 Feb 2012 12:52:44 +0000
Message-ID: <20120228125244.GK3683@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-8-git-send-email-lars@metafoo.de>
	<20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>
	<4F4B442D.2050902@metafoo.de>
	<20120227190159.GC3868@mwesterb-mobl.ger.corp.intel.com>
	<4F4C94B6.4050508@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8295561339524008965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40136103EBD
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 13:52:47 +0100 (CET)
In-Reply-To: <4F4C94B6.4050508@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lrg@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Mika Westerberg <mika.westerberg@iki.fi>
List-Id: alsa-devel@alsa-project.org


--===============8295561339524008965==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="73fGQZLCrFzENemP"
Content-Disposition: inline


--73fGQZLCrFzENemP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 09:47:50AM +0100, Lars-Peter Clausen wrote:
> On 02/27/2012 08:01 PM, Mika Westerberg wrote:

> > However, I noticed that prtd->pos was never set to zero as it was in the
> > original ep93xx-pcm driver. With following addition to your patch, playback
> > works fine.

> Ah, nice :)

Looking good.  Can you please resend the series with this fix applied
and all the acks you've collected?

--73fGQZLCrFzENemP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTM4UAAoJEBus8iNuMP3d1JEP/26MvkWygOhM7BPJlkMSaQ9u
lpSZlfy9WbmZ2r8u4XCRGS1ZYwo8MPJtIiIqPf402RG1gM9wriqmom+S2g+nkmgz
Xadm9oF4PaH7S48JZrgjV3szAKxgJRduTq9lPcjEL2CvziL9Ivm+bH6Oyzy7Mszq
CSv5e8ORq5Ni4AqHPicjv0O+07vnJIBtMzu3hTeKBQUtFsRA7iKr1sMxiBO8K0sX
JlYHcaKpv6WcOumdd2vOFbFl1q5lJNn+ht2p+pKGMggJ+AFnGaw1Ip6Wg3L9H8xT
Ip5mcZVuz9U+jToSl0NQBITzJ043jb7tN9MVRNSXzn2aMotu4Rn0liNrHJTF6y5r
reOX9rB/gc3sku1Pg0F0mKFE5kCdZzo9dJjF2jonB/cbZuas3u6dEIHKI3Iu8boU
8mgfFQyaUJ0rKoYEBE1WCWkGsp1h+9zY0XjPTNLpACLrCnSFLFmLazUHSYXd+xl4
/hf6ZmlTs0+kF/xFnX9lBJzZVjzXzSxo6OOc1jSvxC0lCrQWUMcubgYv6urAJ6eS
D4TX0DUgwEHXSjvDDaStGX3tuXEKbuv8h2ceQaq3N3ly5bhnzZVMUgxdMFL77Ezg
3+PZWy53MoUly7SpiQDVj59O02PUeq1iGoewpFgsu+tlZHcETi83yGM16TWQp6Na
EkKRFyOL2cZzPZwEYzoJ
=dGlF
-----END PGP SIGNATURE-----

--73fGQZLCrFzENemP--

--===============8295561339524008965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8295561339524008965==--
