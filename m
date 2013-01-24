From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
Date: Thu, 24 Jan 2013 18:13:03 +0800
Message-ID: <20130124101301.GG4955@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB50DCF@DBDE01.ent.ti.com>
 <20130123154804.GB4565@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB52FD9@DBDE01.ent.ti.com>
 <20130124100252.GE4955@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB530BB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4518372647672506581=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8DB242615D2
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 11:13:09 +0100 (CET)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB530BB@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob@landley.net" <rob@landley.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4518372647672506581==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2013 at 10:06:42AM +0000, Hebbar, Gururaja wrote:

> What I meant was that by using this macro (SND_SOC_DAPM_POST_PMU &
> SND_SOC_DAPM_PRE_PMD) I can just save and restore existing voltage values inside
> the event. They will not be user configurable (available to user through some widget).

Well, you *could* add separate register control for that but it's not
really something that should obviously be exposed to users; usually
that'd be something that is fixed by the platform via platform data.

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAQicAAoJELSic+t+oim99coQAISOEaBbeJohOtAbx00ftRKE
2ro34bN6HTKuKR6tUmi95TcMSFziOpCotNN+UFhGNpTZ43PtxNh300C+Ei1bK7Tq
ZHgEcHBy0092h20xN7nHOQHqGhmtdHBEnW6yEoLhECgxymg+B87ueJArZ+SQgsnt
5XYiZ5fqC++xl1pNsvkQo1kkT4E/0yfqKKVri8d+d14w+DbXxPvWk33xu1/G5eFY
acuvbOfD/WBeEHQhUjDmliK4O5ImWfLwkuoJ7R8VEfp3s/fo58iTBNhCIqJHLihF
oo9S1mYeWb4cfnyilTOR90GLkRWHV1CC3dgbfa8h/xUr8Nwn8VqYbtHWWJ8489C8
Us2iKt7OFUVgsKLjHNYdUcicZfFQUCmXB7+UM25J7bpBsjVTOa71B+YDPC+DETI/
7uwnBqosG5QmhgzMrOl5t1Onu26tDSwLsV8/IW7gYmhlDHbA4c7X5AMI5ezxv/Sk
CulM6sVbBeRLSaotVujPBLr39QLJUIgpq6J+fFAvWyfFekLEFucktgaT44SHSNCm
ROBhJc2U3PDwkhadhcIdkuqvx0s15Mv48QUII+IeiaKx/5fzbR+yRsr7Jc3i4Ad9
HTjep//j3xgFPBjdRVGxt+z9qG9h1ZYmme2AZ3Z9+ezCJMEDkz29LWaEAsev4VBu
EJa7NVKLnAY6SuJwgw25
=iqdj
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--

--===============4518372647672506581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4518372647672506581==--
