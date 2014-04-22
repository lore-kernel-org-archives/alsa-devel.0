From: Mark Brown <broonie@kernel.org>
Subject: Re: Disabling DAPM from ASoC framework
Date: Tue, 22 Apr 2014 13:20:50 +0100
Message-ID: <20140422122050.GU12304@sirena.org.uk>
References: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
 <20140421223914.GI12304@sirena.org.uk>
 <CAGziFAAj3kL8TqGGChiuW-msMQxnLibjWP2OUyq_uNG5AUWq2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8025854609346515017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B53F62625CF
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 14:21:01 +0200 (CEST)
In-Reply-To: <CAGziFAAj3kL8TqGGChiuW-msMQxnLibjWP2OUyq_uNG5AUWq2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Santhosh N M <santo4ul@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8025854609346515017==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zWWGd3gJbt88x8Gq"
Content-Disposition: inline


--zWWGd3gJbt88x8Gq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:17:35AM +0530, Santhosh N M wrote:

> >>>>>Why do you not want to do power management?

> It is because of the following reasons,

> 1) Due the complication in hardware (where codec is inbuilt to the SoC) and
> the software architecture, we decided to leave all the AMPs, DIFFINs and
> SINGINs ON always. All the MUXs are pre-configured (in codec driver) to
> route audio to the right path. So there is no real need to switch OFF any
> of the power components on the device!

That doesn't sound like a generic upstreamable driver that'll work on
other systems...

> 2) The device is AC powered and power consumption is not a problem here
> (unlike battery operated devices)

This isn't done purely for power reasons, it's also done so that an idle
device doesn't end up playing the noise floor which generally is audible
and so that changing use cases can be done without generating noise.

> This approach worked when I tested quickly. However, I'm slightly worried
> when you say " it's likely things will break". Not sure if there could lead
> to some memory leak in the long run.

Not memory leaks particularly, but the framework does assume that DAPM
is there and may fail to do things like start the audio streams.  If
it's holding together for you it'll probably not break but I'd expect
you'll run into trouble if you try to move forward to a new kernel
version, and possibly if you change what you're doing on your current
one.

> Do you have any recommendation to achieve this in the right way?

If you really want the audio stream up all the time I'd just play audio
all the time from your sound server.

--zWWGd3gJbt88x8Gq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVl6fAAoJELSic+t+oim9Z6sQAI0so8Vzi/ESBmUrsbPdG93Q
p4BFHE3sSddzveD9yhDs+GdWouIU16uJ/WEDmD+L/PWFiEY6uwPWNHAASjD7pIwr
KAz9eIQhrkDFPIUPSPLeSYtjSpYkfb6Nxawcg5wLF2AGxEyJs1HnGh8Ib6FC9Tbz
04LcfPYGING4KhZrPhUDZHGtAONviTHSU5JddemNdt4uJFOE7M/sCxooNHmFCUTo
6OCinhrtS4xN6/CbJhxGZzTbtmDLy8jPxWwtXbM0kWcFKul6DBFNqCSiS5NWDCDO
LvUHOqTlXKhaDSnIJfKwDuEUg0mzu7HXTYkbAlEfQ1muXJ6Mr/N+9Vnhdb6TnCv5
MA0D3P+530ITP9t8LurlPS2knrapgw9fjHslN8KU+pI22jMMUpW9Y5cpfaAALC1a
l0gxgI1k6x8Xg16TDPoWi5a84OnVBvmsESYnG+BsEHAhJMH0M6wUJc3VdnQZjoxR
TIJGhdh2VIWkfhcmxxreMYPZcNXW1t2dndYYlwXlMdFXrpRVv3YygJUY6WcDj9jj
3g8ygBjQc1vgs9ZHw+Q9TkzTMEFugJEAnpfWTCfSFTK1PJkHwPTJ+BeuE4Fyvz63
rK099bbILY5haYmtNDDDkPIFYX9umGjDY16fiJEIWs0vuHHqgehukImrAzEPa29Q
QqVF5cNRkJYl1b22xDZf
=4jP/
-----END PGP SIGNATURE-----

--zWWGd3gJbt88x8Gq--

--===============8025854609346515017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8025854609346515017==--
