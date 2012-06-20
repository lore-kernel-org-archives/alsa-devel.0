From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] dmaengine: Add wrapper for
 device_tx_status callback
Date: Wed, 20 Jun 2012 14:09:58 +0100
Message-ID: <20120620130958.GN3978@opensource.wolfsonmicro.com>
References: <1339438302-12417-1-git-send-email-lars@metafoo.de>
	<1340189662.1927.1648.camel@vkoul-udesk3>
	<4FE1BE79.5080903@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2802483584055523872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EA3424591
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 15:10:01 +0200 (CEST)
In-Reply-To: <4FE1BE79.5080903@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Mika Westerberg <mika.westerberg@iki.fi>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2802483584055523872==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zl+NncWK+U5aSfTo"
Content-Disposition: inline


--Zl+NncWK+U5aSfTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2012 at 02:13:45PM +0200, Lars-Peter Clausen wrote:

> There is a compile time dependency between the patches, so this patch should
> go through the ASoC tree as well, or we'll have to wait another release
> before the ASoC patches can be applied.

Yes, I was just going to say that - are you OK with me applying these
Vinod?

--Zl+NncWK+U5aSfTo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4cufAAoJEBus8iNuMP3dsZUQAIRovAp5ccVPcjy7vsY1PBMn
JgvIP6oBP1Zl7L+9c5NBBVyoMbOJgWbcxS/xXmA3A8SxFSxIYXOiJXpgtvjG6mZS
iktv816seJMXDVIRuV7ioUsJNWokkZ4NJdD+Dh4t9x4oZrabGbHVxxoWR+SZjoKR
ejtGhAq5tPi80fB9q/76SEwm5ru60EI7gQrkKWvfNwiKnBMdRhtlpJxhTN6QNRjb
Bd0unc1IBQRq2MQpCr6jPRBYbKjhIsbCFGVxPE38znmLYPfGdgMPsQ0A5NYQuFSf
AdcPIlQufS53QPd0VXL4fJFbGwaCytoEXQNmM+/bPN9qDG+Iv3DogulkyM/5+4JE
K+1joGc63jTLpkz8gkAodBAmrHuWhCxj/z18i76LUUCtQLqOWGZwE4oeXtw6rp+5
3AJRmI1t9zYN50soWNVmBtNljoCto6IoKnwU9ENZFBthAVOwiJm5wkkJ7YjhZkID
itNmB2kp2/hAO6Q3B5JBx3uEJZB1GX16lJ4zeL/x1Onh62TPVd2o0z1OKf3yrCmb
/IuDCSbriOIUWOtlVIUqWxoCWCXnEWk6WGssl5Ok7dc9sKxPQ8AezK2cu1xlRxwt
MJ0ApQXB1Eg1Q8mZlxRUg1JZYM0w0ysgKlqgKsRxI5l2GG/A+uHkPKQh7laUfiop
jQSLJjuq/PwWvoeR6QuF
=/4RR
-----END PGP SIGNATURE-----

--Zl+NncWK+U5aSfTo--

--===============2802483584055523872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2802483584055523872==--
