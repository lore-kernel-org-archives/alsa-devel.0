From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/6] ASoC: Intel: Add Skylake IPC library
Date: Wed, 8 Jul 2015 19:46:27 +0100
Message-ID: <20150708184627.GB11162@sirena.org.uk>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7945493188118867970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 024962650AF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:46:32 +0200 (CEST)
In-Reply-To: <1435919647-14049-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7945493188118867970==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2Ze1fp8mKggy7lw"
Content-Disposition: inline


--w2Ze1fp8mKggy7lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2015 at 04:04:06PM +0530, Vinod Koul wrote:

Mostly looks good - a few small things here, nothing too major:

> +static struct ipc_message *skl_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
> +		u64 ipc_header)
> +{
> +	struct ipc_message *msg = NULL;
> +	struct skl_ipc_header *header = (struct skl_ipc_header *)(&ipc_header);
> +
> +	if (list_empty(&ipc->rx_list)) {
> +		dev_err(ipc->dev, "ipc: rx list is empty but received 0x%x\n",
> +			header->primary);
> +		goto out;
> +	}
> +
> +	msg = list_first_entry(&ipc->rx_list, struct ipc_message, list);

This says it finds the message but it appears to just return the head of
the list without reference to the supplied header other than casting it
to skl_ipc_header and possibly using it in an error print?

> +irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
> +{
> +	struct sst_dsp *dsp = (struct sst_dsp *)context;
> +	struct skl_sst *skl = sst_dsp_get_thread_context(dsp);
> +	struct sst_generic_ipc *ipc = &skl->ipc;
> +	struct skl_ipc_header header = {0};
> +	u32 hipcie, hipct, hipcte;
> +	int ipc_irq = 0;
> +
> +	/* Here we handle IPC interrupts only */
> +	if (!(dsp->intr_status & SKL_ADSPIS_IPC))
> +		return IRQ_HANDLED;

Shouldn't we be returning IRQ_NONE if we didn't handle the interrupt?

> +		if (IPC_GLB_NOTIFY_RSP_TYPE(header.primary)) {
> +			/* Handle Immediate reply from DSP Core */
> +			skl_ipc_process_reply(ipc, header);
> +		} else {
> +			trace_printk("IPC irq: Notification from firmware\n");
> +			skl_ipc_process_notification(ipc, header);
> +		}

Why trace_printk()?

> +int skl_ipc_set_dx(struct sst_generic_ipc *ipc, u8 instance_id,
> +		u16 module_id, struct skl_ipc_dxstate_info *dx)
> +{
> +	struct skl_ipc_header header = {0};
> +	u64 *ipc_header = (u64 *)(&header);
> +	int ret;
> +
> +	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
> +	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
> +	header.primary |= IPC_GLB_TYPE(IPC_MOD_SET_DX);
> +	header.primary |= IPC_MOD_INSTANCE_ID(instance_id);
> +	header.primary |= IPC_MOD_ID(module_id);
> +
> +	dev_dbg(ipc->dev, "In %s primary =%x ext=%x\n", __func__,
> +			 header.primary, header.extension);
> +	ret = sst_ipc_tx_message_wait(ipc, *ipc_header,
> +			(void *)dx, sizeof(dx), NULL, 0);

If you need to cast a pointer to void something is wrong...  I suspect
you just don't need the cast though.

--w2Ze1fp8mKggy7lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnXACAAoJECTWi3JdVIfQOW4H/0gJ2662fgn+T1V+/Y6meuxy
KEikcd14107gx29TbMLoliPaMHkzMp8RKDVeyVFrY6X1vMMeI7h+ni3QSFLvRUe/
zf4DbRw3JZLB92LvLLaiutQGAJ1yq0asCcPjvGzx9BdDDYfNjDGriAm/0WwsU1rq
Su04P8QoBiv5tQv8LQmaGxtKkIP1Ziebo3aoajzrTNATbJtrGSs7/ZvYhQbaEZSw
9PDbswZd94rofklMM9zZvlRCzAL7poa9lr/zIzWDKTjjrOKNxPIp0j8Vsyr7AnSu
nteQsf3D+wJHHH0xo6eJBKK1Fx0C2KzqJvoHT+V9rbYXgkeNYGKjYdqaEoQeg/w=
=4Z3n
-----END PGP SIGNATURE-----

--w2Ze1fp8mKggy7lw--

--===============7945493188118867970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7945493188118867970==--
