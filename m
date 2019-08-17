From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 2/3] ASoC: SOF: imx: Add i.MX8 HW support
Date: Sat, 17 Aug 2019 17:21:02 +0200
Message-ID: <c8c78674-7af8-4577-9e18-da85c064b345@intel.com>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24173F8011F
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2019 17:21:08 +0200 (CEST)
In-Reply-To: <20190815154500.29090-3-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 2019-08-15 17:44, Pierre-Louis Bossart wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Add support for the audio DSP hardware found on NXP i.MX8 platform.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> +static void imx8_get_reply(struct snd_sof_dev *sdev)
> +{
> +	struct snd_sof_ipc_msg *msg = sdev->msg;
> +	struct sof_ipc_reply reply;
> +	int ret = 0;
> +
> +	if (!msg) {
> +		dev_warn(sdev->dev, "unexpected ipc interrupt\n");
> +		return;
> +	}
> +
> +	/* get reply */
> +	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
> +
> +	if (reply.error < 0) {
> +		memcpy(msg->reply_data, &reply, sizeof(reply));
> +		ret = reply.error;
> +	} else {
> +		/* reply has correct size? */
> +		if (reply.hdr.size != msg->reply_size) {
> +			dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
> +				msg->reply_size, reply.hdr.size);
> +			ret = -EINVAL;
> +		}
> +
> +		/* read the message */
> +		if (msg->reply_size > 0)
> +			sof_mailbox_read(sdev, sdev->host_box.offset,
> +					 msg->reply_data, msg->reply_size);
> +	}
> +
> +	msg->reply_error = ret;
> +}

Assuming reply.hdr.size is coming from HW IPC regs, msg object is 
representing application side - SW, kernel. If so, is msg->reply_size 
value an estimated size (which can be overestimated since exact size may 
be unknown by the host) -or- the exact size of incoming IPC reply?

The estimated-case is usually permissive as long as assumed size is >= 
reply.hdr.size - dev_err needed. In the exact-case, it should be viewed 
as a requirement. If such "requirement" fails, is it valid to read 
mailbox regardless? Is this to extract some error-debug payload sent by FW?

Just curious, please feel free to correct me here, Pierre.
