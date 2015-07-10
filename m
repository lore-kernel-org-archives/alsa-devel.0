From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/9] ASoC: sti: Add CPU DAI driver for
	capture
Date: Fri, 10 Jul 2015 18:26:06 +0100
Message-ID: <20150710172606.GV11162@sirena.org.uk>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-5-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5283670208668295685=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46569266606
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 19:26:17 +0200 (CEST)
In-Reply-To: <1434983473-25092-5-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============5283670208668295685==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G/WKQfTgLd6RqXFs"
Content-Disposition: inline


--G/WKQfTgLd6RqXFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 04:31:08PM +0200, Arnaud Pouliquen wrote:

> +static int uni_reader_stop(struct uniperif *reader)
> +{
> +	/* The reader should not be in stopped state */
> +	if (reader->state == UNIPERIF_STATE_STOPPED) {
> +		dev_err(reader->dev, "%s: invalid reader state", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* Turn the reader off */
> +	SET_UNIPERIF_CTRL_OPERATION_OFF(reader);
> +
> +	/* Disable interrupts */
> +	SET_UNIPERIF_ITM_BCLR(reader, GET_UNIPERIF_ITM(reader));
> +	disable_irq_nosync(reader->irq);

Do you really need to disable interrupts with disable_irq()?  It's more
normal to just leave the interrupts registered and stop the hardware
generating them.

--G/WKQfTgLd6RqXFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVoAAtAAoJECTWi3JdVIfQacgH/irLhmUBC+nTIpQZuJLvjVup
oYJCgeYI7eogNI3iVhZeGUS7eCjbND6zgz8nTrc37D8jlZNJTSSmGxwa/7WlAP3W
RM4l0CgNFO1bTSq5NWVPTQJJbpo3CEIJ0Mi/Hzak97sNJi90U04maEfuwBQ2yRsd
QfjGU8I1utCLLfzuh0i+4jccRHBXkJEp3oCbB+nJaq8NzYxaNTR7P7Jjjf3lwCts
ZLjg9aTAhilnf8l5aWAH61YY45YnbWgIwD78LT7YPCvard6Gw9o7icsvDtmEWkL+
o7Po+L3btHnN7/upA1Ih7x/f8RTMkIznVI/aBo1B+Wks5wRfu4ug9Wh99rQGJxU=
=sW0d
-----END PGP SIGNATURE-----

--G/WKQfTgLd6RqXFs--

--===============5283670208668295685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5283670208668295685==--
