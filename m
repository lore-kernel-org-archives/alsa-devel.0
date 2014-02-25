From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: Intel: Add support for Baytrail
	SST DSP
Date: Tue, 25 Feb 2014 13:44:11 +0900
Message-ID: <20140225044411.GX25940@sirena.org.uk>
References: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8230790135189320450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B445C265572
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 05:44:13 +0100 (CET)
In-Reply-To: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8230790135189320450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="htOzmBcUdOH+AGHj"
Content-Disposition: inline


--htOzmBcUdOH+AGHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2014 at 05:26:55PM +0200, Jarkko Nikula wrote:
> This set adds support for Baytrail SST DSP with RT5640 based machine
> driver. Design is quite similar and is actually inherited from Intel
> Haswell SST DSP drivers that were posted recently. Reason for another
> implementation is that there are more differences than similarities
> between Haswell and Baytrail.

I've applied all these, thanks - please look at the machine driver
issues incrementally.

--htOzmBcUdOH+AGHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDB+YAAoJELSic+t+oim9NNkP/iW8/aHNEHGepvAW0JFVOzDn
cGSdRW/ppwyuRIw1eiUY8N7Bg92ZHo7hD6J7xmAQmauIzxdrkP90cSbCz1YvlCEA
Q+XWT3c60FkoNwtBfXxSFkWVmyD3eXZNBG6dxxL1JGHPMaH2DgmeY6FFCDJg/t7M
gHWSPVHzUpmUtqFBk2SC/sPpx8/2h4zhWRspj4GnW80mkoYslGkoLAle/TcrW1mM
VD7MIPc13BJ3b6aMZMiYCXc6NkQ0B0ii53vSUQl0InPZTPRw1yZ27Pu9OClN3GQJ
IFqCJ/N2RSx/mmBuh3BRjhUMj1M4Ij+44EQCgx4QnEX0Sf3SFnJwyYWmZcJFySs8
/agBeZ/YwjMJQBtNibvOO+vKohN2y+Lm81aJZSdHg0rteX7Z2ddZu9ztOuH83DtC
yBVhPW+tFKPQ1hnuTAYtevennWDfSwhYgfibi3rQxc9fKfTbCrsUp4OihrqE88O4
Q0WyaqlbBSxschyADNM13EfReWn8wVcel/Xkx0Q+j2A+YwfHyLlu86h0bT5ljIKk
h1ANdtQ9ZtkkMb7waUE2TFiKaqs5M2uNj28tHUAf9/vcZomB5HexB6roNzPObhDJ
3iL/fPtlM5U58IBlvrVGvSZByqCMlpupsliM7ixtrZ8ty50u6zIu0NCl5SUr4eYL
OtXaSHa9dmP+hgfc48Oz
=A40V
-----END PGP SIGNATURE-----

--htOzmBcUdOH+AGHj--

--===============8230790135189320450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8230790135189320450==--
