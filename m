From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone
	channel switch
Date: Wed, 2 Mar 2016 19:35:35 +0900
Message-ID: <20160302103535.GH18327@sirena.org.uk>
References: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6920759791161216506=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EE74261566
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 11:35:38 +0100 (CET)
In-Reply-To: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, bardliao@realtek.com, zhengsq@rock-chips.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6920759791161216506==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gqm1jLeCp9Kqu8Dg"
Content-Disposition: inline


--Gqm1jLeCp9Kqu8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2016 at 05:18:40PM +0800, John Lin wrote:

>  	SOC_DOUBLE("HP Playback Switch", RT5616_HP_VOL,
>  		   RT5616_L_MUTE_SFT, RT5616_R_MUTE_SFT, 1, 1),
> +	SOC_DOUBLE("HP Channel Switch", RT5616_HP_VOL,
> +		   RT5616_VOL_L_SFT, RT5616_VOL_R_SFT, 1, 1),

What does "Channel Switch" mean?  It looks like this is a mute control
in which case it shoiuld be HP Playback Switch or similar like other
mute controls.

--Gqm1jLeCp9Kqu8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1sH1AAoJECTWi3JdVIfQB0wH/38iV29NvZSs21Di1GARbckX
UW3/E0UZSOoU3Rir157bRKdsYMWhpdS1c5WuzEgofFvdikW8ODFFuPJuQGBkFgBU
P2JO+gdlcK2CEeZLGx4aQBy7i75TxGB9kgO+mkhBRGcltZ861gBb0zS6hsTlnxf3
8vslKC2qFXhhiEHfvCYHntlwwDdgDizpq5WnJb20HH1qlsJgVQtKERrbiqD2+M06
ZynvXk5znOpQGoQ+gIwC8FPn9MZ/0LedRE6yjsH2aGMUZTxeCuhQAjMeyClTHDzG
yMROSvo6CNU/HEBk3aQaveNcpUmRtQOgPTMPMTwSFC+2YqCHFJgQxWXWDG6RVmM=
=5QWD
-----END PGP SIGNATURE-----

--Gqm1jLeCp9Kqu8Dg--

--===============6920759791161216506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6920759791161216506==--
