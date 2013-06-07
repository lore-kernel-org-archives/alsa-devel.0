From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: WM8962: Set CLKREG_OVD if GP5_FN is
 not its reset value
Date: Fri, 7 Jun 2013 16:46:20 +0100
Message-ID: <20130607154620.GV31367@sirena.org.uk>
References: <1370607258-4750-1-git-send-email-b42378@freescale.com>
 <20130607143905.GT31367@sirena.org.uk>
 <E31481825E4C03459FC878EE97CB2EFD02FDA184@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3329078333210953649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B6A2656E3
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 17:46:23 +0200 (CEST)
In-Reply-To: <E31481825E4C03459FC878EE97CB2EFD02FDA184@039-SN2MPN1-023.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen Guangyu-B42378 <B42378@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============3329078333210953649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9+c39mRxyNdSGXq/"
Content-Disposition: inline


--9+c39mRxyNdSGXq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2013 at 03:33:31PM +0000, Chen Guangyu-B42378 wrote:
> On Fri, Jun 07, 2013,  Mark Brown wrote:

> > You're missing a whole batch of handling of device reset here - look at
> > how we handle things on power on.

> Are you talking about the initial code in wm8962_probe()?
> But after wm8962_runtime_resume(), register Clocking2 will be reset to its
> default value without OVD-setting and won't be recovered after regcache_sync()
> due to volatile_reg.

The point is that there's more work needed to recover the device state
here, you're only doing one of the several things that need to be done
after the device has been restored.

--9+c39mRxyNdSGXq/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsgBJAAoJELSic+t+oim97gMP/0QyEyYDRnEKWY+wYAfSdfF3
Ijln1+GCalUNSp+MRC0//HyBoEW3yo9qSScQzTynq70+P9kQTsheCstK9upiN88Z
nMp5eSElKn50CdEbIW+ZjvYEjkA0aeG0BCse7bSwtIHLgvLOgxkmWrJhk2I+D2sV
xUSlejIfpnu3Yl2ld96i2SaW86E4f4ZsYgAXh5aw5Klxz7eIcE4766KX1eI1oY7C
wd2iMlP/4UcwOnRRs9PQwgdU/2i4kr6wjKq+uRL1Y6/F68gdW6QeWw+AynJvXvfK
s+Zo6zUmawbFwRp2w7PlzdNbiN4FLMnx+DF/+uf/PoAvt8wK5u82DqV02V/QXvgX
42OXut5rLb8N+FN7Wp9HZU+4uIQ8cfORh4gjh0RUi+I2DSHPhOsp/GBYpoOBZBDo
R3TwA0c/W/dSr4JPp/yq/R7EPoNZMbzgUp1PktqZbWEowKqTT5b95VzN4RbiRkmS
qmMXQCZqgR+19BRfpqehd2RUw2swQzaortLcjlaY2msBa13FSN9wUS5o9u14IBQf
V4rtpub8gVHVgOXL3Mxqk9gJjvTc90/CO29Ud1u9MihHFYAqCVp1PlITK4FL05Mq
4oUC87TP7piyL58wPjh/cJuDCLARKDYRp5C7h0CVuANIJ6Oplf4Y+v4Ly1ZvHRYe
t1b3c+gvoFg2uRdYfGLO
=tVTq
-----END PGP SIGNATURE-----

--9+c39mRxyNdSGXq/--

--===============3329078333210953649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3329078333210953649==--
