From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: DAPM: Return -ENOMEM in
 snd_soc_dapm_new_dai_widgets()
Date: Mon, 28 Oct 2013 09:35:56 -0700
Message-ID: <20131028163556.GI13643@sirena.org.uk>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
 <1382966510-13075-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2798274246470404598=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 533FD261A8F
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 17:36:06 +0100 (CET)
In-Reply-To: <1382966510-13075-6-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2798274246470404598==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Content-Disposition: inline


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 02:21:50PM +0100, Takashi Iwai wrote:
> ... instead of NULL dereferences.

Applied, thanks.

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbpJoAAoJELSic+t+oim9+XAP/0MhAAG2vjzIxil46sXbQqNA
mED0SZq5trgr+xpNT0DffvH7AJvFRoIoz3V78t/u0K2MHZyepBxnzjst4kTDWsS7
Z0SAF41intZJlApKrr15R5IZytV54Gz0gW/XsO0U4w1D71Oj2xv89ECagQckT1ZG
eqIU7CR1ot7sldokB+JyKLV/YfqeSjefZrJ2GDAgu9s4Gr05A8BwmOz/hNxIR43m
z4BdsFpr98sF4TSBPoY/4/Q8pqgKpFFC7nGPDlbxeJsxbTjrllgCHMbSOfy5Clbz
F/D8NMoUTlCwCzuhlpmPK7R0esPiSH2rQSRTMIFsfHrImNGnrAdwCfw0QXg1PWmv
HrDXBLPTf8bO/sa++G6oYE/Sx9ZaORFvRB59w1szWiadOg5PJprMFXqf+LMBcy1u
etPDa9rchuveNc7h+siQdDSmtZQMW7wZF8HGimwq0tbDGP89tZeksz9FBGQw5IyF
B754kDK2zYUeo/C7wsF0MG5R6EPKJ4zL5TroWt7IsFE667LpSLMWWtPZaRbchTF5
FHNim0dmLNFB1BmEnWdx/S+I3l7WcSgF4Fy5dWXiIzVEMXujvf458JgUcnz6FOI2
JnZI1mNBjFM+Rf4MfYwjNGM2Afmwo6523WvDiuZVyL6mxnBxXVKm3RTH/ebo/HUt
4ED8tiT2cVU0l01+DGdi
=OO1j
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--

--===============2798274246470404598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2798274246470404598==--
