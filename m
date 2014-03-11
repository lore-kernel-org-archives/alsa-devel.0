From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ak4642: show error if register write fails
Date: Tue, 11 Mar 2014 11:21:12 +0000
Message-ID: <20140311112112.GP28112@sirena.org.uk>
References: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140310234038.GE28112@sirena.org.uk>
 <531EF106.3020809@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3477973573290130013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34532261698
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 12:21:20 +0100 (CET)
In-Reply-To: <531EF106.3020809@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============3477973573290130013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D0XhK/yWCeLEMOFm"
Content-Disposition: inline


--D0XhK/yWCeLEMOFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 11:18:30AM +0000, Ben Dooks wrote:
> On 10/03/14 23:40, Mark Brown wrote:

> >Two things here.  One is that this should be a dev_err() and the other
> >is that if this is worth doing shouldn't it just be in the core - I see
> >nothing driver specific here?

> Sorry, didn't see a device in "struct snd_soc_codec *codec" so I went
> for a printk (although it was pr_info instead of pr_err).

codec->dev.

> If you think that changing the two snd_soc calls to print errors
> when anything bad happens then that would also be a good idea then
> I can send a patch for that.

That would be better, yes.

--D0XhK/yWCeLEMOFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHvGlAAoJELSic+t+oim9FXQP/1crCNw7yIRdLrf6CjwcwF2Y
k9AIMxrpPQKiRAM8wCvNdkufhm8FgTJZmWvPKCYuvA+SU4GA0Ux+7SRCXMKaueGs
uK0YxBNF9Y7SQHR6x3Avqz55LbE9h7sWoVmhWg93fRhQNIeBL/ERaLmgZkQgseR9
xr3aZMb9DP/vcu9FJchAR+8ceYhsCj+7GPltnqSzU8vRlxnYZt2LkvZuJg9UZ2Qq
7loR2D/xdhTrquh5OuExo7LsXYXxxYSYaeHuT7A2+U5XpzRju+ztKCFQAqqyS7My
S6YCPaeemJ/m4msqjEQaqC2tkjnVQOZHvLrHjpZ22aNpLbRTQDTkh5Atgqxi58Bv
CBmpJpm9buWllPt3+E/5fDCWhKUHnoZgaGBWrcJvtGcpO+QHnxXGGRqgXoQTD6gw
1v/fJugBqZEn4gC2q7rsYDckifeoy00NcQpX0py6me1pD6LcGaU1DzixqwRdcJjT
WaoGJxxD2ZKq80MsfpfpVT9z3lraRSWnSuoHcCiwc4UZLNin/ELFzJ+VwjzHYRz2
qp/ecMbACXhQKJqC8jxXmecPC9aYUUFNd/odmlcg8ONCa+VgP0W8LpfFXW8m2A0h
InFHtC6LU4sUiApU9XeoQvep0uoC+n+nFV+6D99zwZ0F26qtnn4G6nFuJbUs3r1O
heZ33DrucWc1iwAgBPiq
=9hNG
-----END PGP SIGNATURE-----

--D0XhK/yWCeLEMOFm--

--===============3477973573290130013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3477973573290130013==--
