From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 18:11:35 +0100
Message-ID: <20120821171135.GA7995@opensource.wolfsonmicro.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com>
 <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <s5htxvw1eqz.wl%tiwai@suse.de> <5033AB7A.7050609@ladisch.de>
 <20120821162706.GU7995@opensource.wolfsonmicro.com>
 <s5hehn09nvv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0137886890467216479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DE18265FFF
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 19:11:35 +0200 (CEST)
In-Reply-To: <s5hehn09nvv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============0137886890467216479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2+IDmuKgu0wSQZlt"
Content-Disposition: inline


--2+IDmuKgu0wSQZlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 07:05:24PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> >  The idea was
> > purely to punt the description of the outputs attached to the stream to
> > somewhere we already need to use to describe the outputs rather than
> > having to map the two formats together.

> Yeah, passing more info is fine.  But if it isn't compatible, it
> doesn't have to be the same controller elements as channel map.
> Or, we may put a flag in the query TLV to indicate it's not standard,
> etc...

So, I guess a lot of my concern here is that this is in line with what
we're doing for control names and obviously that information is basic to
the point of being unhelpful for any non-trivial hardware.  If we're
adding something I'd rather it were able to cope with the complicated
cases too; multi-channel audio is a big deal with embedded things but
usually not for 5.1.

--2+IDmuKgu0wSQZlt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM8FAAAoJEFJkBDiqVpZ4QT8P+wZorS1RCdGObWGNCEgmGyTP
4kUA9wgIgYEpX4PgBp2aDaMdpJ9uaFdpY2M50sh7PzaXif/OKrvLB9+COP9g4rPq
7VXA/t6hAeyGs+V5Mqa20Sero9hbrdKAnTdf8nkT0eqdnLwAw7p8yfMGMb0esimo
h9jXpoI4m613hytmOaYiOT0HAqYZ+LdZGvbrz1HJ2Sk0JuEYJ+SBdmiBJ9XT4ZeN
tRGM54b066ur+M/SzDuqssW7coaRTepTrfTnuqw3VT5V3VtTBQJWgU03fUNTDmVJ
ATrCTLze5WPy2eM6lvHC/PFZzBIukSbSczoXL+XKm4265Np6cBRxJWjHhVr7ONKG
vQnRvalQSsZIgfGrpKqwBoscBrSgEYG3z49tYVb7Fl7K7xLIi/X/EG6h/wOR7fVW
Uuf+sx0d7PrehYrgJWdFDVT6tSiCmnumgQpO1NeCazomzG3p5EusjUWohJ/l96ho
gNx9JQrAozx5reBxQy78wKyOhRkWYpuk32becd1z/9XVeYVDykHWGLFRjRp2zslv
SEsV9Kbn34uN9N10QiZgKJ6h3JKP+0AH59N3sFHyfAuflB1d/LEFoSVIGO1zT9Di
6sY4HU0pmJEhtsU9O8Zk57TPJWPCICMvkeSCxU3oG9jKCXecx82i5u+hPXJH45zx
cFK72E5Nw4mhsFd9BGUD
=OY+A
-----END PGP SIGNATURE-----

--2+IDmuKgu0wSQZlt--

--===============0137886890467216479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0137886890467216479==--
