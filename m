From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH 01/21] ASoC: SOF:
 Intel: Add BYT, CHT and BSW DSP HW support.
Date: Fri, 18 Jan 2019 17:29:21 +0200
Message-ID: <CAEnQRZCRrt_D2wRtGVBBFtio6VZuB-cVaJMQU3GOZujypqU+Xw@mail.gmail.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
 <20181211213029.28801-2-pierre-louis.bossart@linux.intel.com>
 <CAEnQRZCgwXTMQPEE47DTY_wgvB5QiUu0sXFjfenhc_w3HnaRfA@mail.gmail.com>
 <9672de72-6fe4-5ac4-a8bf-bc0e31f6ec9d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <9672de72-6fe4-5ac4-a8bf-bc0e31f6ec9d@linux.intel.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, sound-open-firmware@alsa-project.org, Rander Wang <rander.wang@linux.intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2019 at 5:03 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >> +struct snd_sof_dsp_ops sof_cht_ops = {
> >> +       /* device init */
> >> +       .probe          = byt_probe,
> >> +
> >> +       /* DSP core boot / reset */
> >> +       .run            = byt_run,
> >> +       .reset          = byt_reset,
> >> +
> >> +       /* Register IO */
> >> +       .write          = sof_io_write,
> >> +       .read           = sof_io_read,
> >> +       .write64        = sof_io_write64,
> >> +       .read64         = sof_io_read64,
> >> +
> >> +       /* Block IO */
> >> +       .block_read     = sof_block_read,
> >> +       .block_write    = sof_block_write,
> >> +
> >> +       /* doorbell */
> >> +       .irq_handler    = byt_irq_handler,
> >> +       .irq_thread     = byt_irq_thread,
> >> +
> > What is the reason for having irq_handler/irq_thread functions inside the
> > snd_sof_dsp_ops structure?
> >
> > These functions are never used outside via sdev->ops pointer.
>
> Good point indeed, thanks for raising it. We were in the middle of
> tagging which ops are required/optional (feedback from Mark) but we
> started from the core and should have looked at the structure definition.
>
> Most drivers are "self-contained" and can reference the irq_thread and
> irq_handler directly.
>
> The exception where the abstraction is used is internal to the HDaudio
> stuff:
>
> intel/hda.c:    ret = request_threaded_irq(sdev->ipc_irq,
> hda_dsp_ipc_irq_handler,
> intel/hda.c: sof_ops(sdev)->irq_thread, IRQF_SHARED,
>
> That's useful since there a minor variations between hardware
> generations and you want to hide the hardware-specific parts.
>
> But as you point out, it's a "private" use of ops callbacks, the core
> doesn't touch this.
>
> I have no explanation other than legacy/historical reasons or a shortcut
> to make one's life easier during development.  Liam and Keyon might know?
>
> We could try and move this to a more "private" structure, the
> "chip_info" part might be more suitable for this?

I have no preference over this, I was just confused and wanting to
know if one will use
these members in the future.

We can either move them to a more private structure or at least have a
comment saying that
these will not be used by the core.

I have few things to bring into discussion now, perhaps you can comment  on it.

Firstly, we might want to look at the mailbox controller
(drivers/mailbox/mailbox.c).
It looks like the communication from AP (application processor) and
the DSP uses shim + mailbox
in Intel implementation, which could be abstracted by a mailbox client.

The confusing part here is the naming. In the Linux kernel the shim
layer you use is abstracted
by the mailbox controller, while mailbox from Intel implementation is
really a shared memory area.

We have this already implemented for our mailbox (Messaging Unit) in
drivers/mailbox/imx-mailbox.c and
trying to integrate with SOF.

So, for IPC we have the following "naming" differences:
* imx mailbox MU - equivalent with SHIM layer from Intel SOF.
* imx shared memory - equivalent with mailbox layer from Intel SOF.

Secondly, the "doorbell" naming of the interrupts. It surely looks
like a doorbell because we notify the
DSP that we pushed some data in a shared memory area. Anyhow, besides
pushing data to the shared
memory area we also send some data with the notification too.

For example, in byt_send_msg we do:

sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data, msg->msg_size);
snd_sof_dsp_write64(sdev, BYT_DSP_BAR, SHIM_IPCX, cmd | SHIM_BYT_IPCX_BUSY);

Not sure how cmd is used on the DSP side. Anyhow, this is not really
important for the next version
of the patches. Just wanted to hear your opinion.

thanks,
Daniel.
