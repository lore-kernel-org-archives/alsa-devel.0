From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 18:57:56 +0100
Message-ID: <20120821175756.GB7995@opensource.wolfsonmicro.com>
References: <50337316.4080208@ladisch.de> <50339485.30500@canonical.com>
 <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <5033A0AD.2010403@canonical.com>
 <20120821150720.GS7995@opensource.wolfsonmicro.com>
 <5033AB74.8050201@canonical.com>
 <20120821163414.GV7995@opensource.wolfsonmicro.com>
 <s5hd32k9noz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6294241899599742384=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AF35266015
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 19:57:56 +0200 (CEST)
In-Reply-To: <s5hd32k9noz.wl%tiwai@suse.de>
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


--===============6294241899599742384==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsxFkDPDWfsXVt/M"
Content-Disposition: inline


--XsxFkDPDWfsXVt/M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 07:09:32PM +0200, Takashi Iwai wrote:

> The API itself doesn't restrict the boolean -- it's a control element
> after all.

The in kernel API takes a boolean as an argument for reporting values.

> The reason for ctljack API was stated many times: it came because of
> shortcomings of the jack API regarding the multiple items.  For
> example, when multiple pins with the same type exist (e.g. typical for
> HD-audio), no standard way to resolve that.  Or, if multiple cards
> provide the same name of jacks, we don't know which device is for
> which card.

Both of these things are totally orthogonal to the problem here - it's
the separate in kernel API that's causing issues (and TBH neither issue
is a big one for the ABI, if we'd discussed them we'd be fine) since
drivers need to support them all.  If all the ABIs sat behind a single
API in the kernel we'd not have any confusion here, userspace could just
pick what amuses it.

> But, it's basically irrelevant with the channel map API discussion.

Yeah, some drift here.

--XsxFkDPDWfsXVt/M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM8wdAAoJEFJkBDiqVpZ4MIsQAJizr69M/PhhcFw6LC6Obi+F
aOOz23DjmlBufigOjOd/l0ty2D2RPW884SyQYYo4j2q7Xo1JPMAsCmK0Q93vw3EM
T9qPM+TsWVPSO7El02nTeS80iDCqwCNis+SpnkYawalOUtwOWQ5XQjz/2Nwr+lXx
y5P+PZGR+SiRA+3GnpjNTp+jZz9g8X0eMomQM4yebMn2xrDjx8YNhIapRRW59F2j
WdiDU1rV6XyA9vcWb/iqeiG1+azqutv/YfDkRUWVaZOmPBlcPAIvrpocijG6PHgv
f/sCVpdiKI2bq/RdUK6EaVnilD7dSWZLLZJGBvT+uQPEzfnW0JRE9GUfCaMOIudr
q7TzwvO28LQJfxaw//fFrzYVw6fdoveaLvII+HfnJqD3ohkATerKyBWiHpyH+7yf
nx4/vvTPUG+XvpsCp0q9EqIeM0ywP8SbsEZ1wU9nBJUxc/NW3xt8dwIs0OEuRVLw
Gnc5jdBe0SHH/VtJYzgTABKC6LnH7hi36Ra2Rk7Un4l/2U2n7tJaR3LpF/ERGKgR
POcmRFzOYHIT+eFTAiydUJnBNwpuKznk7ZAwV0WIv7bKcR5bBY3S44QX3dk8Ygm/
jqRPQnINqumoMkOPD/8ez+2SVcaIMlOK0cUR1+h1XsiHSXl4wyfBJCNll6gU+dov
aw02RAdBADKLyJd2PeEX
=M/eY
-----END PGP SIGNATURE-----

--XsxFkDPDWfsXVt/M--

--===============6294241899599742384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6294241899599742384==--
