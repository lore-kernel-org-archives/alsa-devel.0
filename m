From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: img: Add driver for Pistachio
 internal DAC
Date: Wed, 25 Nov 2015 12:47:28 +0000
Message-ID: <20151125124728.GT1929@sirena.org.uk>
References: <1448299499-18435-1-git-send-email-Damien.Horsley@imgtec.com>
 <1448299499-18435-3-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2758737422100958047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02A3826058D
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:47:38 +0100 (CET)
In-Reply-To: <1448299499-18435-3-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============2758737422100958047==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iiZKCn1f/U0ES2iY"
Content-Disposition: inline


--iiZKCn1f/U0ES2iY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2015 at 05:24:59PM +0000, Damien Horsley wrote:

> +	/* The mute state as set by alsa using the digital_mute callback */
> +	bool alsa_mute_state;
> +	/* The mute state as set by the userspace mute control */
> +	bool control_mute_state;
> +	/* The actual mute state is equal to an OR of the above */

Does the device *need* the digital mute to avoid noise?  If there's no
strong need for it then just don't bother which simplifies the code a
lot.

Otherwise this looks good.

--iiZKCn1f/U0ES2iY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVa3gAAoJECTWi3JdVIfQ+cgH/0pRLEspJsaHeAVICGG5LWsW
gKixF5k1ih6dXEIbDeFkdacOy7IoMOVaQ0ni0HMLimZl+jO/ncFGrAunsHALwjIk
yzaiVa3IuXWfb+hf34jLfCxJILvT+4v6+JoYWfpAYBzaJZ09M2C6HrBCjKyNjwbG
JLFGeM3FA3YU8RdKKXBNE02v92EFQtUJ3zIiGZShB6+j+jFgCzGlrKWDx2xwL4rO
RDqnP5Sd+HG8yjPz3DtySqAmkdJ739XLXVZfI+SoRLvA7JKcV9B3Lj/l8Dlzr+J7
9i0Ky0uS0VkHMNZOQOWWJvkVt5C2tMGhzAy+s2KDOqIO3bKzmXpuJqDxruEfOaQ=
=mecr
-----END PGP SIGNATURE-----

--iiZKCn1f/U0ES2iY--

--===============2758737422100958047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2758737422100958047==--
