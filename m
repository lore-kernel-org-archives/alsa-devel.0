From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: mxs-saif: fix clock prepare and
 enable unbalance issue
Date: Tue, 24 Jul 2012 20:18:06 +0100
Message-ID: <20120724191806.GC3099@opensource.wolfsonmicro.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4201650151138788726=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7390126528A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 21:18:05 +0200 (CEST)
In-Reply-To: <1342776027-31758-2-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: shawn.guo@freescale.com, alsa-devel@alsa-project.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4201650151138788726==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2012 at 05:20:24PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
>=20
> Currently we directly call a clock_enable in trigger function without
> a clk_prepare as pair first.

Applied, thanks.

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDvTfAAoJEBus8iNuMP3dRa8P/2I9KmNwl2N3r1in/Mn1P75+
cMdqXNiNrlm6vJEVPZfoTXCX1MbI/tMODOSS7mppsID2KivpXLz7UdmyRDqjVMO/
6PFciO93S0OWrGmRu7NRBGYruFPF8677PcuH9ysDbjV4HliC0LfezclBsUIzwsK6
SOimwWWeJZ3hXrRUhIAsci+xfiQ6MqnbpDtrCgnpu0bS/+tepFfCNdN0PQxnf/to
Tk4ppQT6fsls/iGdJcmf+6Z4vt31BF8V3OHPd8Af8vb2yp6+ZJgmQGFeYxVZ5plg
elxTeUhLLlPyUoPzIralYXJZswW8Tw66XvjxbBBe/Dgr4X0Ly1heeNq86vjbCMcf
rLqKJH8rw9qMCC8xg0KICCNa+SyE7pUfY2572PVcTgWZbqlTQr/OvShxRJEjSYyV
kuWSIzkBl3LZXgMyZ82GMGDDQM5HQ7Te2ya6rDuY9vqyk6IWk7/zNTEKoxMAomd5
x2GrxyiGJJwtCvIlTW84pqpKMuaWtsGpl3BePnqGN7FnZousPrvfXeYEf+6Ak9ol
vK7zIXpL8fUW5kdjG6j8YH8DXBZgOjaN71zWD14w/EwtulSnRz2s7uA48Hv4Jb8Z
je6Yv1n54AMAQLgW0qLr40dL8/NDii1/jB48uXdnxjrym3WGYH7yAwhgZpYETFxG
NPiqtNEgJFaUB8HLuv4O
=iSyc
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

--===============4201650151138788726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4201650151138788726==--
