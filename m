From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Thu, 10 Jan 2019 14:11:32 -0600
Message-ID: <876df209-c829-873e-047e-c73fb0579d68@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
 <20190109203720.GQ10405@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190109203720.GQ10405@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[consolidated answers from Liam and me]


>> +/* wait for IPC message reply */
>> +static int tx_wait_done(struct snd_sof_ipc *ipc, struct snd_sof_ipc_msg *msg,
>> +			void *reply_data)
>> +{
> This has exactly one caller, why not inline it (or make both tx and rx
> separate functions)?
we'll look into it.
>
>> +	spin_lock_irqsave(&sdev->ipc_lock, flags);
>> +
>> +	/* get an empty message */
>> +	msg = msg_get_empty(ipc);
>> +	if (!msg) {
>> +		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
>> +		return -EBUSY;
>> +	}
>> +
>> +	msg->header = header;
>> +	msg->msg_size = msg_bytes;
>> +	msg->reply_size = reply_bytes;
>> +	msg->ipc_complete = false;
>> +
>> +	/* attach any data */
>> +	if (msg_bytes)
>> +		memcpy(msg->msg_data, msg_data, msg_bytes);
> How big do these messages get?  Do we need to hold the lock while we
> memcpy()?
Messages can be as big as the mailbox, which is hardware dependent. It 
could be from a few bytes to a larger e.g. 4k page or more, and indeed 
we need to keep the lock.
>
>> +	/* schedule the message if not busy */
>> +	if (snd_sof_dsp_is_ready(sdev))
>> +		schedule_work(&ipc->tx_kwork);
> If the DSP is idle is there a reason this has to happen in another
> thread?
we will rename this as snd_sof_dsp_is_ipc_ready() to avoid any confusion 
with the DSP state. We only care about IPC registers/doorbells at this 
point, not the fact that the DSP is in its idle loop.
>
>> +
>> +	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
> The thread is also going to take an irq spinlock after all.
didn't get this point, sorry.
>
>> +	/* send first message in TX list */
>> +	msg = list_first_entry(&ipc->tx_list, struct snd_sof_ipc_msg, list);
>> +	list_move(&msg->list, &ipc->reply_list);
>> +	snd_sof_dsp_send_msg(sdev, msg);
> Should the move happen if the send fails (I see it can return an error
> code, though we ignore it)?

so far neither the HDaudio nor the BYT stuff return an error on 
send_msg, so we'll need to thing about what happens should this happen 
with other hardware, or demote the status to void.

We'll look into this.

>
>> +	int err = -EINVAL;
>> +	case SOF_IPC_FW_READY:
>> +		/* check for FW boot completion */
>> +		if (!sdev->boot_complete) {
>> +			if (sdev->ops->fw_ready)
>> +				err = sdev->ops->fw_ready(sdev, cmd);
>> +			if (err < 0) {
>> +				dev_err(sdev->dev, "error: DSP firmware boot timeout %d\n",
>> +					err);
> err defaults to -EINVAL here which doesn't seem like the right thing if
> fw_ready() is really optional.  Perhaps just validate the ops on
> registration and call this unconditionally?
Good catch, err should default to 0, thanks for pointing this out.
>
>> +void snd_sof_ipc_free(struct snd_sof_dev *sdev)
>> +{
>> +	cancel_work_sync(&sdev->ipc->tx_kwork);
>> +	cancel_work_sync(&sdev->ipc->rx_kwork);
>> +}
>> +EXPORT_SYMBOL(snd_sof_ipc_free);
> It might be better to have something that stops any new messages being
> processed as well, to prevent races on removal.
ok, we will add something to stop the IPC, good suggestion indeed.
