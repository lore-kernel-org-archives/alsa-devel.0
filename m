From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 6/6] ASoC: sgtl5000: Don't disable
 regulators in SND_SOC_BIAS_OFF
Date: Fri, 6 Mar 2015 20:16:46 +0000
Message-ID: <20150306201646.GA21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-7-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2297488965628152342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA4E265FE4
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:16:52 +0100 (CET)
In-Reply-To: <1424991273-10081-7-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============2297488965628152342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xf7APsN6pwAFhtFV"
Content-Disposition: inline


--Xf7APsN6pwAFhtFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2015 at 03:54:33PM -0700, Eric Nelson wrote:
> Disabling the SGTL5000 through regulators would certainly save
> power than simply disabling the reference voltages as described
> in the data sheet, but won't properly restore things on resume.

Why not just fix the code, reinitializing the chip is usually pretty
trivial?

--Xf7APsN6pwAFhtFV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gsuAAoJECTWi3JdVIfQr0sH/i11btv61VvFI4DAF/k3JGjC
wfub+uzWI5Io5GYzOecC8xObxP8Qj7QUoVjZ0xANot+z4m2aowy8IiPFJvokh7x0
UIc/jJmlc0sZGydbNEOPqhL6eSTt2BWknYU3JReAb9kooqyry7tg2PtnHZrNmYFt
l2zO2Tn73/IxgjMT9VXydQvBp+Ktkx2wiErI3sYuYjVIBjOtVatV1JPmMcuWd9pM
KkfO59wl5ep2Bx6IKN9wnmJovkBpBNWMLulbkt8J5KVIvl4MML2w19vI7r6ywrMj
tAFc5dlCCdLFatdsDB93cqYbYfMcbVwAKEpPnjeExpyEI/9itl8+UiwTkBp/SNY=
=V+/4
-----END PGP SIGNATURE-----

--Xf7APsN6pwAFhtFV--

--===============2297488965628152342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2297488965628152342==--
