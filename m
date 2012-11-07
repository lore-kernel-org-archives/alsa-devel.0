From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: commit: dpcm: Allow FE to be opened without valid
	BE routes
Date: Wed, 7 Nov 2012 15:28:10 +0100
Message-ID: <20121107142809.GD20844@opensource.wolfsonmicro.com>
References: <mailman.495.1352127790.820.alsa-devel@alsa-project.org>
 <1352221394.4968.38.camel@anish-Inspiron-N5050>
 <20121107084856.GC12323@opensource.wolfsonmicro.com>
 <1352292999.1574.6.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4192309287256980724=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F11F826501A
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 15:28:15 +0100 (CET)
In-Reply-To: <1352292999.1574.6.camel@anish-Inspiron-N5050>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <anish198519851985@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4192309287256980724==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2012 at 09:56:39PM +0900, anish kumar wrote:
> On Wed, 2012-11-07 at 09:48 +0100, Mark Brown wrote:

> > You shouldn't be relying on parsing dmesg for anything, that's never
> > going to be robust as you've just found.  dmesg is for humans.=20

> Probably I couldn't explain the problem clearly.Problem is that in our
> case we get sometimes(very random) audio mute in android devices due to
> UCM commands from the platform not sent properly or sent in such a way
> that FE and BE don't get connected.
> This issues are very hard to reproduce and only gets reproduced randomly
> by the test engineer and when it does happen, test engineer takes crash
> dump and provides us the log.So it is almost impossible to know what
> caused this audio mute at that time and all we have is this very
> log(dev_warn(FE and BE not connected)) to let us know that this mute was
> due to platform and not codec or any other problem with the kernel.
> Anyway looks like this idea is not liked by the community so I won't
> push further.

This really just sounds like a basic debugging issue, you can either add
additional trace locally or work to improve the trace infrastructure -
for example, make sure there's tracepoints showing what DPCM does in the
same way there are tracepoints for DAPM.

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmm+2AAoJELSic+t+oim9DmIQAJen3XN3Uy7ivT0vQBjoN9c1
rc/uUpb08ttinAu6FBaVtR8Du1aVyrM+oBrc6PAe5/ZTsZZfteMQZbg6UQlaBlCT
05f76xEnADRYMxvyc5CYSnQB1yqW/cIbjQvf+gJyuwkoZPToiuhfTGpKGKMu1oo7
kmYtFpPX0591EBuejnnScsmkFzbscc2i9jCl6jafBJvRevb/3B7sDdIKQncXGjw5
CvBT2yymxNkiEflWUEotmU6jnR99C44KTuHAcpfzB2Yx8OECduQOJgr9OBGt1Fmy
jbuaWjxnQ7K0yMWOuh3ldZYyM1bkCMeTwghdLN1qa31Pi9haSjuB+TnNFzxBpmUe
DrkSieq96M+eVWX/g/njZUwYbQgYv7TqtWdLFPkt8a5/pGU/+LAYtNuwL1ErCsQL
7K1bFz9TcfGWAe1YuZBQ5XieLOdlUYPMWc7dVJOUonGnjSutQPZ1tXroMyXw5PsT
8HY08QsPfPjJHMprtmelsCdpVM3c7L2rTk/Zzyds4JTa3OczyGFDe7t021Ueb7KI
Ra/jzZPRc3+mWkFKB6uiLik2A8BTQiTGvygaiq0q1RDPxoNXOjegk0BGqVLNJtY8
dVrF0QLtKuoXCOQuVTy0OjScJKvXWkapFHT0xsFU5vvHg4kQy1gwgId+09WecQg/
fnEoZHvlkh85O0wUwUFF
=PU3R
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--

--===============4192309287256980724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4192309287256980724==--
