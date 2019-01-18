From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH 01/21] ASoC: SOF:
 Intel: Add BYT, CHT and BSW DSP HW support.
Date: Fri, 18 Jan 2019 10:14:25 -0600
Message-ID: <a49e3fd6-4e2f-907a-a5a6-825e2ebf22ad@linux.intel.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
 <20181211213029.28801-2-pierre-louis.bossart@linux.intel.com>
 <CAEnQRZCgwXTMQPEE47DTY_wgvB5QiUu0sXFjfenhc_w3HnaRfA@mail.gmail.com>
 <9672de72-6fe4-5ac4-a8bf-bc0e31f6ec9d@linux.intel.com>
 <CAEnQRZCRrt_D2wRtGVBBFtio6VZuB-cVaJMQU3GOZujypqU+Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAEnQRZCRrt_D2wRtGVBBFtio6VZuB-cVaJMQU3GOZujypqU+Xw@mail.gmail.com>
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
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, sound-open-firmware@alsa-project.org, Rander Wang <rander.wang@linux.intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> I have few things to bring into discussion now, perhaps you can comment  on it.
>
> Firstly, we might want to look at the mailbox controller
> (drivers/mailbox/mailbox.c).
> It looks like the communication from AP (application processor) and
> the DSP uses shim + mailbox
> in Intel implementation, which could be abstracted by a mailbox client.
>
> The confusing part here is the naming. In the Linux kernel the shim
> layer you use is abstracted
> by the mailbox controller, while mailbox from Intel implementation is
> really a shared memory area.
>
> We have this already implemented for our mailbox (Messaging Unit) in
> drivers/mailbox/imx-mailbox.c and
> trying to integrate with SOF.
>
> So, for IPC we have the following "naming" differences:
> * imx mailbox MU - equivalent with SHIM layer from Intel SOF.
> * imx shared memory - equivalent with mailbox layer from Intel SOF.

the "shim" on the intel side is a mix of control capabilities. There are 
indeed IPC registers in there, but also clock, DMA and power control 
capabilities. I am not sure we can really remove direct access to the 
shim, it's really the host-visible set of DSP registers.

We'll look at the pointer to the i.mx mailbox, thanks for the information.

>
> Secondly, the "doorbell" naming of the interrupts. It surely looks
> like a doorbell because we notify the
> DSP that we pushed some data in a shared memory area. Anyhow, besides
> pushing data to the shared
> memory area we also send some data with the notification too.
>
> For example, in byt_send_msg we do:
>
> sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data, msg->msg_size);
> snd_sof_dsp_write64(sdev, BYT_DSP_BAR, SHIM_IPCX, cmd | SHIM_BYT_IPCX_BUSY);
>
> Not sure how cmd is used on the DSP side. Anyhow, this is not really
> important for the next version
> of the patches. Just wanted to hear your opinion.

Humm, that one looks like an exception as well, it makes no sense. This 
is over a year old. Liam, any memories of this?
