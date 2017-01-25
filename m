From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8540: new codec driver
Date: Wed, 25 Jan 2017 12:50:49 +0000
Message-ID: <20170125125049.aml35ei6oc4kwguu@sirena.org.uk>
References: <1483597244-9761-1-git-send-email-KCHSU0@nuvoton.com>
 <20170109200052.szyldvyxnki2jggj@sirena.org.uk>
 <58881F56.3080007@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4168567188738693911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEC02667C5
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2017 13:50:57 +0100 (CET)
In-Reply-To: <58881F56.3080007@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4168567188738693911==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rrvmdslc3wxtd77s"
Content-Disposition: inline


--rrvmdslc3wxtd77s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2017 at 11:45:26AM +0800, John Hsu wrote:
> On 1/10/2017 4:00 AM, Mark Brown wrote:
> > On Thu, Jan 05, 2017 at 02:20:44PM +0800, John Hsu wrote:

> > Does this sequence need to be done as part of resume as well?

> These initiation just only need to do once when the codec boots.
> I think it's better to do it when driver module is loaded.

Why not on resume?  While it won't always happen system suspend does
frequently mean that the device will have lost power so anything done on
boot will have been lost.

--rrvmdslc3wxtd77s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliInygACgkQJNaLcl1U
h9C3QQf+LywTSlEL+yeW88GZQOAaOoche+BqfTMM13DuNdO/Og9f9rvgtawK7/wP
T64BlTljlPUYFkfC9MuvpjZD19X5bEkpN1RzxohhjdnxkwxKHKkZHn7oDOPxwuQc
XF6RFRlgHQ65aYknfPEJjOaTKcy868KlHcj7PyJAvFFFvxHiXDP7D7IWTCpGr+de
oEBgUgllM71pQ2YYfNm6VdTWnzeXYXEmMJjxVu/KtkM7tljSsTiMQJdEUZAsyHtu
xVqiiCrLYEMTt4CCb+roTN8T+pHdgOZOG+YkX7KmXiWFOxlp1gTYVm+HBvxdahSr
9TMkehODUbxP1osSg8U1M5pL4/MsDQ==
=Mc5j
-----END PGP SIGNATURE-----

--rrvmdslc3wxtd77s--

--===============4168567188738693911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4168567188738693911==--
