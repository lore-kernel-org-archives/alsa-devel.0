From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoc: kirkwood: change the pcm/dma
 stream data pointer
Date: Thu, 25 Jul 2013 19:23:56 +0100
Message-ID: <20130725182356.GN9858@sirena.org.uk>
References: <20130725111314.66b811bc@armhf>
 <20130725093855.GB24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2748750920453673396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 30A7F26084C
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 20:24:07 +0200 (CEST)
In-Reply-To: <20130725093855.GB24642@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org


--===============2748750920453673396==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9KV7gQ2WEwhe+RIz"
Content-Disposition: inline


--9KV7gQ2WEwhe+RIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 10:38:55AM +0100, Russell King - ARM Linux wrote:

> There's a much better solution to this, which is to get rid of
> kirkwood_dma_priv entirely:

This does seem a lot nicer, can we either grab the relevant patch from
your tree or update this one to use the same approach?

--9KV7gQ2WEwhe+RIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8W05AAoJELSic+t+oim9Tc0P/3rtB+vcNvPnDvRurWTYd9R3
QVmCINpjOKEYxhjsiMpzMYIGF3UNzTpubzqtfcxTXtx/jWOHychBhMEPdibLhRjB
QZfU3QuNdUJ8ieZ1YZ2+ItPswQ4Bpd523C5AoxcOt2Xp92gpFlJiw8OzIruznydT
S3pNgYatAiWTe8LbSovS5u3IK/zGasGiyojCWNhCmx+eYstlJsxXmm1/HNc+Tv60
mqyqhCGS5XEOZNSx6zpUHKDl0lbiOYPlcgXr10vvQRx9Ckh2IG0Kg/LwI8xroG8Z
T4WBbA5uqfCULHpStIuwnR3HUKHkmYZSNNnQl+tYltuHhOA65McdA0VG3TV9FTz4
n1GV9h7q/IuASTLUPg4OCrc6/A2tipzO+jmq1ZPty6Z4GvofPPm3TKx5QLSbEcEj
Lea8irCuhLU691g0lbFMKwrlEV/7iPa71PtyhfuKSA42Pbbo/2kv9jwATnmExQed
At2W+wn6hgZsvi109PXfYdWqm2SebQAB69EgSXLc8cdIMO5jhyqR8c7E9mDxKUvV
iFaHePfJL+r5r3UQw9Vkp+zT88hU7kemkPw1TOIoA7YS571P1WJX2S3xYJ560+0B
3kBDZIuWXTLHP69xkGF26dJgEZZmSJ6FDKizOTxuCEZJQ5UIKNJQMdgityuip8Wf
QN/EIC6lq9DKTdUq3Pno
=YzPe
-----END PGP SIGNATURE-----

--9KV7gQ2WEwhe+RIz--

--===============2748750920453673396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2748750920453673396==--
