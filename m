From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/9] ASoC: hda: Add IPC library for SKL
	platform
Date: Mon, 20 Apr 2015 22:56:39 +0100
Message-ID: <20150420215639.GY14892@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3491488160884156691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 417D2265D26
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 23:56:44 +0200 (CEST)
In-Reply-To: <1429276567-29007-3-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3491488160884156691==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ca23f2aBZR6YDKM9"
Content-Disposition: inline


--Ca23f2aBZR6YDKM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 06:46:00PM +0530, Vinod Koul wrote:

> +
> +/* IPC data */
> +struct ssth_ipc {
> +	struct device *dev;
> +	struct ssth_lib *dsp;
> +
> +/* IPC messaging */
> +	struct list_head tx_list;

Lots of odd indentation of comments in this code (well, several examples
I noticed so far anyway).

> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
> +	else {
> +	/* copy the data returned from DSP */

Coding style - { } on both sides of the if (and the comments again).

> +		if (msg->rx_size) {
> +			if (rx_data)
> +				memcpy(rx_data, msg->rx_data, msg->rx_size);
> +			else
> +				dev_err(ipc->dev, "error: no output buffer");
> +		}
> +		ret = msg->errno;
> +	}
> +
> +	ssth_ipc_msg_put_empty(ipc, msg);
> +
> +	spin_unlock_irqrestore(&ipc->ipc_lock, irq_flags);

Can we pop the message off the list, release the lock and then copy?
That way we can avoid having interrupts disabled while we do the
memcpy().  In general there seems to be a lot of interrupts disabled
copying going on (which is there for some of the other drivers too)
which might be avoidable.

> +static void ssth_ipc_reply_remove(struct ssth_ipc *ipc, struct ssth_ipc_message *msg)
> +{
> +	unsigned long irq_flags;
> +
> +	spin_lock_irqsave(&ipc->ipc_lock, irq_flags);
> +	if (list_empty(&ipc->rx_list)) {
> +		dev_dbg(ipc->dev, "empty rx list");
> +		goto out;
> +	}
> +	list_del(&msg->list);
> +
> +out:
> +	spin_unlock_irqrestore(&ipc->ipc_lock, irq_flags);
> +}

Are we expecting to not find the message/

> +	if (IPC_GLB_NOTIFI_MSG_TYPE(header.primary)) {
> +		switch (IPC_GLB_NOTIFI_TYPE(header.primary)) {
> +		case IPC_GLB_NOTIFCATION_GLITCH:
> +			break;
> +		case IPC_GLB_NOTIFCATION_OVERRUN:
> +			break;
> +		case IPC_GLB_NOTIFCATION_UNDERRUN:
> +			dev_dbg(ipc->dev, "FW UNDERRUN\n");
> +			break;
> +		case IPC_GLB_NOTIFCATION_END_STREAM:
> +			break;
> +		case IPC_GLB_NOTIFCATION_PHRASE_DETECTED:
> +			break;
> +		case IPC_GLB_NOTIFCATION_RESOURCE_EVENT:
> +			dev_dbg(ipc->dev, "MCPS Budget Violation\n");
> +			break;
> +		case IPC_GLB_NOTIFCATION_LOG_BUFFER_STATUS:
> +			break;
> +		case IPC_GLB_NOTIFCATION_TIMESTAMP_CAPTURED:
> +			break;
> +		case IPC_GLB_NOTIFCATION_FW_READY:
> +			ipc->boot_complete = true;
> +			wake_up(&ipc->boot_wait);
> +			break;

More prints perhaps?  _PHRASE_DETECTED looks interesting, as does
_OVERRUN.

--Ca23f2aBZR6YDKM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNXYWAAoJECTWi3JdVIfQ3sMH/3viLie2QY+5rB85j4Jypi0S
u+jBTBLicNQyQerzkFUm2rOOj1jtVvYLcIhj2KDoreaWAdUBJUm6hp15MZQ3svQP
Cl3HQT6hLBPaov/OvkROf+CzkKrhFm/pvUxq6glC4hmjg5nKxzVcSD206hKxA+Bx
M4rMv0VfJRevvGdHcgL+GbMDxVWqnZQ1/ajTGXJvMFWR7/a6d2drTx2IZvHFKzNm
Pi3qf52P62eNi+fGe1fTlVamvlvinPRLvro8ov7YljYp4zb2w76sAwFQMVOimSSZ
mHBHWL8+Kv1b1oPFZAt2wusnb1JtQ/wAdVBwLLeH212hAlw3v08sOkSYG5gTLsg=
=sp4a
-----END PGP SIGNATURE-----

--Ca23f2aBZR6YDKM9--

--===============3491488160884156691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3491488160884156691==--
