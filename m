From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Wed, 9 Jan 2019 20:37:20 +0000
Message-ID: <20190109203720.GQ10405@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1844598430007484172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1844598430007484172==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vsi50HYs5tPfr+1I"
Content-Disposition: inline


--Vsi50HYs5tPfr+1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 03:23:08PM -0600, Pierre-Louis Bossart wrote:

> +/* wait for IPC message reply */
> +static int tx_wait_done(struct snd_sof_ipc *ipc, struct snd_sof_ipc_msg *msg,
> +			void *reply_data)
> +{

This has exactly one caller, why not inline it (or make both tx and rx
separate functions)?

> +	spin_lock_irqsave(&sdev->ipc_lock, flags);
> +
> +	/* get an empty message */
> +	msg = msg_get_empty(ipc);
> +	if (!msg) {
> +		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
> +		return -EBUSY;
> +	}
> +
> +	msg->header = header;
> +	msg->msg_size = msg_bytes;
> +	msg->reply_size = reply_bytes;
> +	msg->ipc_complete = false;
> +
> +	/* attach any data */
> +	if (msg_bytes)
> +		memcpy(msg->msg_data, msg_data, msg_bytes);

How big do these messages get?  Do we need to hold the lock while we
memcpy()?

> +	/* schedule the message if not busy */
> +	if (snd_sof_dsp_is_ready(sdev))
> +		schedule_work(&ipc->tx_kwork);

If the DSP is idle is there a reason this has to happen in another
thread?

> +
> +	spin_unlock_irqrestore(&sdev->ipc_lock, flags);

The thread is also going to take an irq spinlock after all.

> +	/* send first message in TX list */
> +	msg = list_first_entry(&ipc->tx_list, struct snd_sof_ipc_msg, list);
> +	list_move(&msg->list, &ipc->reply_list);
> +	snd_sof_dsp_send_msg(sdev, msg);

Should the move happen if the send fails (I see it can return an error
code, though we ignore it)?

> +	int err = -EINVAL;

> +	case SOF_IPC_FW_READY:
> +		/* check for FW boot completion */
> +		if (!sdev->boot_complete) {
> +			if (sdev->ops->fw_ready)
> +				err = sdev->ops->fw_ready(sdev, cmd);
> +			if (err < 0) {
> +				dev_err(sdev->dev, "error: DSP firmware boot timeout %d\n",
> +					err);

err defaults to -EINVAL here which doesn't seem like the right thing if
fw_ready() is really optional.  Perhaps just validate the ops on
registration and call this unconditionally?

> +void snd_sof_ipc_free(struct snd_sof_dev *sdev)
> +{
> +	cancel_work_sync(&sdev->ipc->tx_kwork);
> +	cancel_work_sync(&sdev->ipc->rx_kwork);
> +}
> +EXPORT_SYMBOL(snd_sof_ipc_free);

It might be better to have something that stops any new messages being
processed as well, to prevent races on removal.

--Vsi50HYs5tPfr+1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2W38ACgkQJNaLcl1U
h9BtIgf/WKEBwl3s0hJYwvDZg9//gxWZmtPoYYiMSYqD3DP5KIf893SvlmQpAJs7
tAH2Fe82sdDtTuuf2bt2p4RvMzgQkDF/YD2d62a73Obp3VhwvH/9E+/mFKVbb1TB
kQ2IO/2J9CJRGQn6FQDVOZ/VkPob2zTELzqZbpSkNQX7SrmfonhMIbgfiZkXbxaH
3btwEJP0hiLty/khtUpvJ0GP3eb3bVP49YSIh2h9K7zsdqHZp+M9VDph8iqupWtj
qggZPeMHd1Ia5X/+3uxg2hUMq9/f96DjMbcWSx/eybrJXMC4z+resl20WNUOsW0i
nwInZgadQxBHkNM2nMdHvZhNMf60+Q==
=wTOX
-----END PGP SIGNATURE-----

--Vsi50HYs5tPfr+1I--

--===============1844598430007484172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1844598430007484172==--
