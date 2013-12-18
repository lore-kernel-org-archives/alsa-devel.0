From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: fsl: imx-wm8962: Grant
 hw_params/free() permission to control FLL
Date: Wed, 18 Dec 2013 11:57:03 +0000
Message-ID: <20131218115703.GL28455@sirena.org.uk>
References: <1386842368-19951-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131217225002.GR28455@sirena.org.uk>
 <20131218051334.GA7648@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7015264372327188484=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A97B62615EC
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 12:57:06 +0100 (CET)
In-Reply-To: <20131218051334.GA7648@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7015264372327188484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9PdaoUq9e3y2fis"
Content-Disposition: inline


--/9PdaoUq9e3y2fis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 01:13:36PM +0800, Nicolin Chen wrote:
> On Tue, Dec 17, 2013 at 10:50:02PM +0000, Mark Brown wrote:

> > I do think refcounting from both here and the bias level changes is
> > going to be the most robust thing, that'd also avoid the need to peer
> > into the CODEC register map.

> I've tried count reference way to handle FLL enabler/disabler here before
> I sent this version. But the result shows the FLL would be never disabled
> in hw_free() because the refcount is accumulated to 2, one from hw_params()
> and the other from set_bias_level(PREPARE), which just made this patch
> meaningless to me.

Well, it gets the clocking configured early which was part of the goal I
thought to ensure smoother startup.

> So the reclocking with bypass checking seems to be the last resort I can
> figure out right here as the playback flow for 'aplay -Dhw:0 44k16bit.wav
> 48k24bit.wav' does need to reprogram the FLL during CODEC active.

That's the other bit.  It should be possible for the machine driver to
disable all outputs prior to reprogramming the FLL, though this will
obviously glitch bypass paths.  One way of doing it would be to have
something that does the reprogramming but only if there is actually a
change - that way the common case is unaffected.

--/9PdaoUq9e3y2fis
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsY2LAAoJELSic+t+oim9rtAQAJQ1r+1zUx0/qjDplNJhBW9v
2AEd13eG7K5/er/+JBBsRUCABd0ihE27f76U9MstBkGfWkN7E+/8vKTLul2dGQgj
s3Mj8FCI9TCBCofhsuiAmpBgx8Xi4sKCrV8wIvKccNbsz9CFU7PNFCFD9SlRpiNd
DgNPdcD6WIEh9DRXmSeYCHP4gL3EKykkAZdMuGwTNjmjN6xx1qJV6xYq5eNFEEcX
lbukFx+ujjqgwB/auboCBZ/TV/Oa9+9fYG9cLFHZcbcp9vql5FktF8cc62QKSoDi
5p8hqRuFtGbZYpPFKKmRnS3NVohd3cR3IO7wdr9MT4uHvIO90TKjeg1BvwD1ipv1
8IpJBLIuOQ5E62CA30bM7WU9OOYchbswiBBtnsTSLSh3s+JF1jP0UZbMjS/OP5iY
e08T9HVEHQ1Zp3VXeK+4jl4SXGBK84MBAdc2S4qzZcQdhqTD5cvNHERn3Wx+fYwk
+8aEZXOKoJ8I1bg2isQteVN/bQrbS6nv8N4M4BTAEBarXdp2OeK6PIolBxMq/jxi
QGlugIp4aahujPukOL4vBbRG5ceu297wQJ8lrD5iZUDaXov535hbduczabEGbqb6
rOhqj1WwUHZxjX/YT603UMOHUAcLfHMOLBFs6QjVFJfJK+9pWaSXBFbkEXbBjTZA
OUD26EUanF+b/H0OeJAr
=XTuF
-----END PGP SIGNATURE-----

--/9PdaoUq9e3y2fis--

--===============7015264372327188484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7015264372327188484==--
