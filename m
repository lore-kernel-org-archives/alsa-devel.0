From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: SPEAr: Add dependency on
 dmaengine helpers
Date: Sat, 15 Jun 2013 13:33:50 +0100
Message-ID: <20130615123350.GU1403@sirena.org.uk>
References: <1371209418-32496-1-git-send-email-broonie@linaro.org>
 <CAOh2x==4nO0eBwvtXZ177fwN8ekNc0UaCwOdg5+bchj+qbUkgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9025476723324748869=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A90260896
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2013 14:33:55 +0200 (CEST)
In-Reply-To: <CAOh2x==4nO0eBwvtXZ177fwN8ekNc0UaCwOdg5+bchj+qbUkgQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9025476723324748869==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mW/Yq1p9Hn2AHmV6"
Content-Disposition: inline


--mW/Yq1p9Hn2AHmV6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 05:49:06PM +0530, Viresh Kumar wrote:
> On Fri, Jun 14, 2013 at 5:00 PM, Mark Brown <broonie@linaro.org> wrote:

> > I'd be very surprised if anyone has used the Kconfig...

> This might be selected directly by defconfig...

No, any select only options like that should be deselected automatically
during the build if they're not required any more.

--mW/Yq1p9Hn2AHmV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRvF8rAAoJELSic+t+oim9sewP/iaCxdjI+eQtJRgo+/Zraffv
O5JUdlBx/Me8sBzaVMGSs9PmVJCQJmge1Z3ivUSJAjmV1uz0NP0d9GXNnbpkUWi0
pYsJO1T8EQH8kMAcWQd/F0T9TIeK++IbfQAENKtNZPCDwY7dx9v2aOaMYw4xA3m+
XM3Qm9gIJl0BzuirF2+atupU3F/r7bkFWtl6LbkT/pfYVYZySvrW4AAflIRy3Cl7
yfP51WPN3boNiaSz+se9GYvMpUpq0kxgM7L3H9+tv13/iYV57TfyOlH8LD0G1eQK
pxexX3hwigihHckpIRvW3N2xRM8lBrmZscuJ86wCB8+CZCSHVeBtBlBzFjatHSkT
OMTmuaHZ3XGtp1PEIa02g0sqib/4hmAQ68zRaaNmqv0oOjFzLmv7zHe36K0I2YYV
DBni880sE5oSWEMVEoWCnRTX+tkc02y/EB/MPIOxd5LFGPc0NdTLXudXg4pJcarP
lgHRiOnUxPjiNITNZ3in3Vfxii0yAbGp4G7NtesIj91ztLIoda9o+tJDDfODpkYD
x0KnkKmFEpuJpb/SFAWjhUAwIcuo3cwvTlHfWGw5QAtRmlwVYhtJJLepfBXH2xVp
wJC2OzSGU1OVpEyh3AoER/JGbnAuNht7+qSe4ZV0O3Nf+R/PdyeiTrRqgyRyX67/
CRBtEdieVQkD72UkO1Bw
=dzKw
-----END PGP SIGNATURE-----

--mW/Yq1p9Hn2AHmV6--

--===============9025476723324748869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9025476723324748869==--
