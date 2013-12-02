From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 07/10] ASoC: ux500: Store DMA data in the
 DAI differently in the pdata and DT case
Date: Mon, 2 Dec 2013 14:04:29 +0000
Message-ID: <20131202140429.GJ27568@sirena.org.uk>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
 <CAOesGMiu16f_L=cMWFCNZMjNB9tBK-2LXn02k-R7FhkkgR5-+g@mail.gmail.com>
 <20131202101256.GA29373@lee--X1>
 <20131202135452.GI27568@sirena.org.uk>
 <20131202140324.GH31626@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0697989121918146329=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131202140324.GH31626@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, LinusW <linus.walleij@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0697989121918146329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/f+qQFZOmBlWs/IF"
Content-Disposition: inline


--/f+qQFZOmBlWs/IF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 02:03:24PM +0000, Lee Jones wrote:

> I'm not aware of any dependencies on the ARM changes. I haven't tested
> the arch/arm and sound/soc adaptions orthogonally, but I _think_ the
> right decisions should be made depending on the information passed
> from platform/dt code.

OK, that sounds great thanks.

--/f+qQFZOmBlWs/IF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnJNqAAoJELSic+t+oim96g8P/A7ZT3s9/HvEg3cekG2FarKW
3Qs902vCDidEuqGm8ApMBCey89wWhwDEg1lxAZddGk0RTcruu21C5eY/Ny482c9i
E9HY8cAa+wPWfZxBaBomBaNes4OrWC30AVPSCSmNBOG44STtW+2fDUXZ0LMS6VNf
lRsW/3OF9m5hEeypqcoHh6HWpDMLv3oJ7SHExS2zOa75cTVMktHzhJbXOGzoyc8b
UQmT5Xxew2vVoo+YI/7djsV1ZwVQ9OQTTFb50X7/amVS7MKRxnkT0Ny9nX6Tq+sL
3MqAIPawes0+2jj0e96fheGDjrX2x7MuW0GPgBfo6yp50aCFY4iF9qeoGtLSqrIc
IivZFRXF8eRTTbdEHtxs1FS+755cdw8urZrvDm/XfwdqZICWst45CbmRHnwT2tJ/
0YbXOWFALxC0GjTg/7zx3d10Ug408uLr71HXSF+H7YiBXBs9aEsXZhO0siXU4t4l
vJZN4CDG1RzX4YfAJdVtFwqIRYyMgpn20lws28JQGlqBm4H80YXuwqIzdIedTaEC
8hoXfKL4qARSo0TKDz6NpTfIJI4QalVNFPN70ZDR8TJtJJtdILFeE+dHqEkerZYx
TZgL67Cb+TjsTEmSdRlEntEqQqyiE5Ldpg0SYzEn9UR6o6lxb0rWG+qhMT943D9G
K6+2H4MwRVjYcP4+p4Cw
=u850
-----END PGP SIGNATURE-----

--/f+qQFZOmBlWs/IF--


--===============0697989121918146329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0697989121918146329==--
