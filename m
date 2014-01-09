From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bcm: Remove obsoleted Kconfig
 dependency
Date: Thu, 9 Jan 2014 13:05:01 +0000
Message-ID: <20140109130501.GK31886@sirena.org.uk>
References: <1389173827-1554-1-git-send-email-tiwai@suse.de>
 <20140108195947.GZ31886@sirena.org.uk>
 <s5hbnzmp781.wl%tiwai@suse.de>
 <20140108201709.GA31886@sirena.org.uk>
 <s5h8uuppt1u.wl%tiwai@suse.de>
 <20140109103201.GC31886@sirena.org.uk>
 <s5hr48ho1xk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4669457118297037778=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09B80261AED
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 14:05:14 +0100 (CET)
In-Reply-To: <s5hr48ho1xk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Florian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org


--===============4669457118297037778==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZCG93/Yd6KYzvl"
Content-Disposition: inline


--juZCG93/Yd6KYzvl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 12:00:07PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > It's getting more common these days, companies want their address to end
> > up in git but it's not so good for upstream mail for whatever reason
> > (historically a lot of it has been Exchange related, though that's not
> > the case for me).  It's more noticable for people applying patches than
> > for people sending them.

> There is no general rule that MAINTAINERS address wins over others.
> Many developers use other addresses primarily than the old address on
> MAINTAINERS file.  Your case is rather rare, I'd say.

It seems the wider use get_maintianer.pl has changed that - people seem
more dilligent about updating their addresses now (especially if the one
that's there is a problem).  I do also have to say that this complaint
typically also comes along with people not CCing Liam which tends to
suggest that they didn't consult MAINTAINERS at all.

> > Sure, but if you're going to use one I'd expect the MAINTAINERS address
> > to win - I did have someone the other day using my Wolfson address still
> > since they were going off signoffs and the thing they were working on
> > wasn't that actively developed.

> MAINTAINERS file isn't always updated frequently enough, too.  So, at
> best, one would compare the time the address was used and decide which
> address has a higher chance to reach.

Well, in my case it's very rare that a mail from my linaro.org address
goes upstream...

--juZCG93/Yd6KYzvl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzp55AAoJELSic+t+oim9itIP/iyIO8BLs3tJH971pnF8UvBr
eLAdb3pCaRMNGobmT6HIiBb0UEJnq+d8qkLcV1WS6R9UC5uQFojFRKzGOduoxtGl
oDamj6Lr8ooCjDUnsCHHU9McGHJJme5VQkIf7tL6O14F1c7P6/iF1UVgP6jWERt5
1L7ZaAiM/r+Mvgcffpdbo2bycaM5wU0+BvN96FzNS+ekhBSSNH6NnhFSbrf5R3M7
D7ooQjfN+ZhPJmz86SDY7z8XyHFTlR811BojkijpKwBl9CiHPs1neqa3FxgNcwNf
p0h7vmEfpVBeR2biivPyN1QQEO6ssSz030RMaluMBdmzwJ+3umFlqewSi/adgj8+
adNr/wD5pRArf61mr/x1d3bKLM43jsHJLEgkr/TOWyuF4zSVA1+qYQknVVFcU2Cq
5ULig234V8UduwM/hnugQpgvGexW/Dl0zs1Z3MERB4ZdAwVTgN2x8NRRV0+0p01u
gObDCHc6/nghGRFOGEhvcKe5bhFBumQVg0RG9zASHgLrzrglNMCQM7OTzoAaxFDQ
QNtLwqYZO7H6LjuCU93jmWRrPYWzYbCp8RpYzoB6s5rsarbP6Zh1TG+Z1LkE71B2
e+rf+8mL/FwXJpsR/FH4eG93HqXfcliIDb7gJbpxzB1qEsKVDr8yTA6KWsFccjqz
/fAr1L+7+Yb0LoB1aJY4
=ters
-----END PGP SIGNATURE-----

--juZCG93/Yd6KYzvl--

--===============4669457118297037778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4669457118297037778==--
