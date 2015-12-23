From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm_adsp: Add a handler for
 the compressed IRQ
Date: Wed, 23 Dec 2015 00:19:07 +0000
Message-ID: <20151223001907.GI16023@sirena.org.uk>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7496654358677895462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DF5B265DCD
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:19:17 +0100 (CET)
In-Reply-To: <1450178989-8749-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============7496654358677895462==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 11:29:48AM +0000, Charles Keepax wrote:

> +static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
> +{
> +	struct wm5110_priv *florida = data;
> +
> +	wm_adsp_compr_handle_irq(&florida->core.adsp[2]);
> +
> +	return IRQ_HANDLED;
> +}

We unconditionally handle the IRQ...

> +int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
> +{
> +	struct wm_adsp_compr_buf *buf = dsp->buffer;
> +	int ret = 0;
> +
> +	mutex_lock(&dsp->pwr_lock);
> +
> +	if (!buf) {
> +		adsp_err(dsp, "Spurious buffer IRQ\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}

...though we even have code to handle spurious IRQs.  I'd expect
IRQ_NONE if the interrupt wasn't handled, allowing genirq's error
handling and diagnostics to take effect.

> +static int wm_adsp_buffer_ack_irq(struct wm_adsp_compr_buf *buf)
> +{
> +	if (buf->irq_ack & 0x01)
> +		return 0;
> +
> +	adsp_dbg(buf->dsp, "Acking buffer IRQ(0x%x)\n", buf->irq_ack);
> +
> +	buf->irq_ack |= 0x01;
> +
> +	return wm_adsp_buffer_write(buf, HOST_BUFFER_FIELD(irq_ack),
> +				    buf->irq_ack);
> +}

This is confusing, this isn't actually in the interrupt path...

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeeh6AAoJECTWi3JdVIfQIXAH/1Q55R8KrxYmcbWXI5TDDiEg
74Hrze56ugUFsewIjGH1Nns5n1zUlmfz7BPdKVivLGpVGvvMFY8c/xr/PdpGF4O5
NE3WFzQGP3ASbKE2p7W8ZdjCCMZnPqZ7KyO0mGvjZbdYhqpHBEYKI11awnfieQNG
OVob0wcaK0vhU911wl2o+bshj2Z+OLzEsLz6B02l8Ps9LRAcpegY/tE4toTTjebC
ItvE6DVRn/eDVsbnBXlzet7fFwUIdbQkNUsAiqDbWedxT6sBOI37a8HGTTIjm+fx
TProb0S8Tu7yygXoE/SKUApy3Yq/DaMEmHIvDqj9Eulnh8LPGfTc9DLEj+ucERs=
=9x0Y
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--

--===============7496654358677895462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7496654358677895462==--
