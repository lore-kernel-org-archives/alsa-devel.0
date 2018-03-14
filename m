From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Wed, 14 Mar 2018 09:24:24 -0700
Message-ID: <20180314162424.GU2186@sirena.org.uk>
References: <1520836460-21809-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1520836460-21809-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180312182537.GO2186@sirena.org.uk>
 <284973fb-bcc9-19b9-2692-966e40129430@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5403267898456116769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A3E9D266EBE
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:24:28 +0100 (CET)
In-Reply-To: <284973fb-bcc9-19b9-2692-966e40129430@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Akshu Agrawal <akshu.agrawal@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============5403267898456116769==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l/3WCmqZNZ+BnHMk"
Content-Disposition: inline


--l/3WCmqZNZ+BnHMk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 04:06:15PM +0530, Mukunda,Vijendar wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> On Monday 12 March 2018 11:55 PM, Mark Brown wrote:

> > I'm still not thrilled about this.  If we're hard coding names they
> > should be explicitly assigned names so that there's less chance that
> > some other change in the subsystem will change things.

> AMD Gpu driver creates devices for Playback and capture devices for both =
the I2S Controller instances using MFD framework.
> Designware driver probe call gets invoked for every device creation with =
resource information and platform data provided by GPU driver.
> In runtime , it seems exporting the device resource name from dwc driver =
to acp dma driver is not possible.

This is not the case, if you are instantiating a platform device you can
pass platform data to it when you do so by initializing the dev.platform_da=
ta=20
field.

--l/3WCmqZNZ+BnHMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqpTLcACgkQJNaLcl1U
h9BR0Af/TpAHYFmCLxzBAyiu6FLs5sQ30Cr+AGVLT4M9DkA82uIcOPq0iVbvVW8p
vb6+XUvT+mVxss41kYGfnl8fHHewx+2InH8g+ZqpdJQaQj+wk7iigYvEQ5vSKAjQ
AF+TdA1HLRW49OkWat11h499UumQNVxVl5qP+eQUkP8O0ywgtfu98qoYUKiC2pX1
gOZgm5K9f8AI75W0DtpB5Vi5EeiOChLZsxq+8T0z49CndoJ/xvjv7LydGtNk73/s
M4czCLKUezcfVX+W9GdJB1uzvosC9fN0alSGJfZoFMSMlQnvDqiXg+ERWZYgW1IB
/2t9YlNohRZ/AJNh4001qVHFCvjhOA==
=pNnJ
-----END PGP SIGNATURE-----

--l/3WCmqZNZ+BnHMk--

--===============5403267898456116769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5403267898456116769==--
