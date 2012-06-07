From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: isabelle: using an uninitialized
	variable
Date: Fri, 8 Jun 2012 06:59:38 +0800
Message-ID: <20120607225937.GH14525@opensource.wolfsonmicro.com>
References: <20120607123837.GA7171@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8406243958722398730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C9351045BC
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 02:54:45 +0200 (CEST)
In-Reply-To: <20120607123837.GA7171@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8406243958722398730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2012 at 03:38:37PM +0300, Dan Carpenter wrote:
> We should set "isabelle_regmap" before using it.  GCC complains.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0TJNAAoJEBus8iNuMP3dsqsQAIPs+uMT770+Glu7qhIHmWbb
uCu/vg4XOW8n5hK8RFvQhs2u4EioHswKv8JHP4PyGHgpZ0/NrEARdoytv5fKhIME
B2hcHzPfhv3zX1F6hD48lbdRMKM4aaHd2x5YrvBOnhYWGYp/pmNynuog5tvPP9jz
mCk+BdnkTa4N8hMGmx2LaQMhxPFfHQDUVGWY8rd8z9yeKLhKarMGtJ6j43mzuQD0
/MEG4/DbvqnJTyCf9vudYXMnxBChUCI4SFDtk80/FwmFgR6bpy95ijY1s7UeR8Vx
ni6Dq9iyrV+xOSBnju6u1w7wiko7pdUEXQGNGy0l69pmAPjCkVrrfChGgYEaTpgz
aVcFwB+kEZMUS+PkZigVvFgrAYyeckyikI7z6opAG9hsynB9i5zPwL87ZsXgdcIU
77B4sa0EgBjbto3bE8PeKR2w8OzK6bzGSxrHU1n4FA7uslm869Bh8cDfESYDLJJ5
cMO+8AId1/t/mPJG3J0/Fm4Y0PZYBxlP/yUmf6KKeFuVU/jiFISB9Jy5m2Yu8Ca6
iwQuEPzNMJQpR58aADiPmwychEltAzJZQCH+pnvY6D0ytr9Hf+6TFP33aP6Uqvg0
nOn7l2ray41vmICIVU0R3GRmk0HPI5VwMe11Hp0JE3svWqTIAPcMk/NnFWpF272Q
btvRSMzFA0qUFH3L2wot
=dd5j
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--

--===============8406243958722398730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8406243958722398730==--
