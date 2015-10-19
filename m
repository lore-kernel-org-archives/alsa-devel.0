From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 06/10] ASoC: img: Add driver for
 parallel output controller
Date: Mon, 19 Oct 2015 19:07:57 +0100
Message-ID: <20151019180757.GJ32054@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-7-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2441072393446120635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25630265B4F
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 20:08:10 +0200 (CEST)
In-Reply-To: <1444653637-14711-7-git-send-email-Damien.Horsley@imgtec.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, James Hartley <James.Hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--===============2441072393446120635==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="07FIeBX8hApXX6Bi"
Content-Disposition: inline


--07FIeBX8hApXX6Bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 01:40:33PM +0100, Damien Horsley wrote:

> +	spin_lock_irqsave(&prl->lock, flags);
> +	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
> +	ucontrol->value.integer.value[0] = !!(reg & IMG_PRL_OUT_CTL_EDGE_MASK);
> +	spin_unlock_irqrestore(&prl->lock, flags);

Do you need to lock a single register read?

> +static struct snd_kcontrol_new img_prl_out_controls[] = {
> +	{
> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> +		.name = "Parallel Out Edge Falling",
> +		.info = img_prl_out_edge_info,
> +		.get = img_prl_out_get_edge,
> +		.put = img_prl_out_set_edge
> +	}
> +};

If this is a boolean control (it looked like one) it should be called
Switch but it's not clear to me what exactly is being controlled here or
why it's something that should be exposed to userspace.

> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
> +		reg |= IMG_PRL_OUT_CTL_ME_MASK;
> +		img_prl_out_writel(prl, reg, IMG_PRL_OUT_CTL);
> +		prl->active = true;
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		img_prl_out_reset(prl);
> +		prl->active = false;
> +		break;

No need for locking on the reset (and doesn't this mean that the control
state is going to be changed underneath userspace)?

--07FIeBX8hApXX6Bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJTF8AAoJECTWi3JdVIfQ+k0H/1ZJ5Xzxm4Ay4fUY8Epnr0o8
t5ZYKMUQ15VUQCVFc3gCfd81eeHH4DX+WwWRFMmqyugWyqAq+aV/cjP3l2yb+QyA
fyc/KB08oyghZ8xf64oUYGghjbIZb9NJIMM9W6AmwKcDzCUVSwXkCZwbcQgAzUyh
UTSXMsGHERnC6POXAO51KqwcwFfR0ClPfK01XAdDazyVNDStUvkh1IvCEHpDj2iY
YwBYeFKerm8DXamyrfxSqtHHGWzXTPKuROZWcJISrOWgaGveJjJ9hTMhuglI6azd
A8gpk7NTk6W4smDxYbWKXTBffuc/I2qRIdyiCxi6Qs5scO/Lp4w2lcBiWviCN+o=
=g+p1
-----END PGP SIGNATURE-----

--07FIeBX8hApXX6Bi--

--===============2441072393446120635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2441072393446120635==--
