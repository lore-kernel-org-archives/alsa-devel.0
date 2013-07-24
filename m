From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/27] sound/soc/au1x: don't check resource
 with devm_ioremap_resource
Date: Wed, 24 Jul 2013 15:31:50 +0100
Message-ID: <20130724143150.GD9858@sirena.org.uk>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-22-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4419419030330340732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 694872652E9
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 16:32:03 +0200 (CEST)
In-Reply-To: <1374602524-3398-22-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4419419030330340732==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7/Z1yz1L7BOCEubH"
Content-Disposition: inline


--7/Z1yz1L7BOCEubH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 08:01:54PM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Appiled, thanks.

--7/Z1yz1L7BOCEubH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7+VTAAoJELSic+t+oim98ZgP/iZ1yY4fAHzjOiPOeUuZ7n1Y
QeoIbAZpZfwBPRyMyKafrUNy8LLXxYNHOrbEGGiFLpelFBTX5Jttl1mTQEB17S/7
j8x35gAGWz7B/FgsiY9faaDIdjfS7ofvMLtFd+XAK9coz5Zb0ohI+FwzeN8T6Vo4
bkjgAI5U5eVYhPMo09PvDHcT/dAXOA65UoBrRz2J3XOhVEflMVXReNkj35FsgpQA
5y6xf8f8D76vJhIJa0tBEstCMOGJR3RErPg5rR7y2KsTdrA4h0Cn2hnMjHUAKrrr
3mM/E8Sim3B9X4IMj/ynYY/yp+uWPPIgAQcylDmeKJpBKQHpEhRNvxeCtues/cBg
E5Z4+RKUVKVQRazrmp6BxkA1ZzqFlpG0EXkpyz2XNikX+7sQcURHx9Rx/J6/gWPj
UQsewfva30+ua/sHZixNdwYTmnZUeNdKleMWM93qjUtZe8uBUpHHJeTEr7VEMSqH
UDZV3zuDjips3y4n+vJVm0AdQd9CC+UNkQTC0L13GJZUJXl9sC6cYylz+f6/5dPA
ujEJ6S60nfYfk7pIqcICcrzwxm4HZpIMmWMzToiEQ31pZTN8dhbEEg5UG+m97rrH
A0pfqpX+d/cAuQpQck7aZ8b1imfN9R9UdKdh47sMO2okwKD5/MxhrdF7t27MhGbn
7EJ2X0+j3BIAiFbhLe4Q
=cAsn
-----END PGP SIGNATURE-----

--7/Z1yz1L7BOCEubH--

--===============4419419030330340732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4419419030330340732==--
