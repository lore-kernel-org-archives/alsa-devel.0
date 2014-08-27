From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 04/11] ASoC: Intel: sst: Add IPC handling
Date: Wed, 27 Aug 2014 21:37:37 +0100
Message-ID: <20140827203737.GY17528@sirena.org.uk>
References: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6087799235723166279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D89252681A9
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 22:37:52 +0200 (CEST)
In-Reply-To: <1408625450-32315-5-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6087799235723166279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cl0sN3H3VGsmJOtm"
Content-Disposition: inline


--cl0sN3H3VGsmJOtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:20:43PM +0530, Subhransu S. Prusty wrote:

> +	spin_unlock_bh(&ctx->block_lock);
> +	pr_debug("Block not found or a response is received for a short message for ipc %d, drv_id %d\n",
> +			ipc, drv_id);

Is this not an error?

> +int sst_free_block(struct intel_sst_drv *ctx, struct sst_block *freed)
> +{
> +	struct sst_block *block = NULL, *__block;
> +
> +	pr_debug("in %s\n", __func__);
> +	spin_lock_bh(&ctx->block_lock);
> +	list_for_each_entry_safe(block, __block, &ctx->block_list, node) {
> +		if (block == freed) {
> +			list_del(&freed->node);
> +			kfree(freed->data);
> +			freed->data = NULL;
> +			kfree(freed);

Can you safely kfree() inside a spinlock?

> +			spin_unlock_bh(&ctx->block_lock);
> +			return 0;
> +		}
> +	}
> +	spin_unlock_bh(&ctx->block_lock);
> +	return -EINVAL;

I'd expect much louder complaints if we try to free something that's not
allocated - what happens if we end up reallocating something quickly and
then double freeing?  Better to complain if we hit such a code path.

> +	/* check busy bit */
> +	header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> +	if (header.p.header_high.part.busy) {
> +		spin_unlock_irqrestore(&sst_drv_ctx->ipc_spin_lock, irq_flags);
> +		pr_debug("Busy not free... post later\n");
> +		return;
> +	}
> +	/* copy msg from list */

Blank line here.

> +	/* check busy bit */
> +	header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> +	while (header.p.header_high.part.busy) {
> +		if (loop_count > 10) {
> +			pr_err("sst: Busy wait failed, cant send this msg\n");
> +			retval = -EBUSY;
> +			goto out;
> +		}
> +		cpu_relax();
> +		loop_count++;
> +		header.full = sst_shim_read64(sst_drv_ctx->shim, SST_IPCX);
> +	}

10 spins seems short but OK.

> +	pr_debug("sst: Post message: header = %x\n",
> +					msg->mrfld_header.p.header_high.full);
> +	pr_debug("sst: size = 0x%x\n", msg->mrfld_header.p.header_low_payload);
> +	if (msg->mrfld_header.p.header_high.part.large)
> +		memcpy_toio(sst_drv_ctx->mailbox + SST_MAILBOX_SEND,
> +			msg->mailbox_data,
> +			msg->mrfld_header.p.header_low_payload);
> +
> +	sst_shim_write64(sst_drv_ctx->shim, SST_IPCX, msg->mrfld_header.full);

Can we factor out the I/O bit with the non-blocking case here here?
It's just a small bit at the top of the function that's really
duplicated.

> +	case IPC_IA_FW_ASYNC_ERR_MRFLD:
> +		pr_err("FW sent async error msg:\n");
> +		for (i = 0; i < (data_size/4); i++)
> +			pr_err("0x%x\n", (*((unsigned int *)data_offset + i)));

print_hex_dump()?

--cl0sN3H3VGsmJOtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/kGOAAoJELSic+t+oim969wQAJ19TuoCcd2hqP+GhpSFSVof
by7WCID7d6uJWsfyUU1ffLMtgJZTXQcOiGK6JIY2pTImSK5jXtZc7exfaBFKaBF7
B48nDIst60n0DXQMzNvNjb9lyAIT/MSFTBzN05ad4lgPrPFNrp4KXVS8sMUUkjHj
Vj4hQBRSEcsW47w6uYT70hz+FogBnTtGJmg3EaLB1p0xv53Z56JL8anWnNc5sC8/
Uz0zVtIl16Xp9P/xZBzQ9QeKKOpWnjJnizjpteCUMC9ErRJl0ee7j7wP+XQ+cheA
sl0793iR3+UkwRXE1yGuPb3UC4GA46yeSOA7FFJCtJpUEXF+hQcNEv8xiAw5/ARv
HHIGXC4mQ81m/Sr5nH0PTYS7RjVUPjREuEi/h9Diz9gmDxYr5lK1fmY+EllwWlCW
wPAfJUmR42xyNbcKbTi2WjCkdP7mk6HORK3Sf5qDePGyEmZYL19Vwft2ytGz7FaE
6U3wuCIqGXkcaVQo6M00fHQcVEoVWNQnd9bYkrjh0zKHzcL7i7mg25ky7pZ1HjRk
v8wiB3scxotfMR9EwB53+xJ/3imC9v1uymM0cDsKQOhxmxVGn4L22ml7JFbDbhl1
NO75qQg9DHN0ulU4OinIIOniJYKJxVvSAdpweEVOa9n6/TpVJE1lhFfosVvR93X8
lfMWmC8CEGKZSDM5kJAf
=iIhO
-----END PGP SIGNATURE-----

--cl0sN3H3VGsmJOtm--

--===============6087799235723166279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6087799235723166279==--
