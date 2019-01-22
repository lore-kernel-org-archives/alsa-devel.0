From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 01/21] ASoC: SOF: Intel: Add BYT,
	CHT and BSW DSP HW support.
Date: Tue, 22 Jan 2019 09:35:31 +0200
Message-ID: <CAEnQRZAVUFbTKC3_P-uDu3wSmBMeu7W=2p32vVnimXjeABxyQA@mail.gmail.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
 <20181211213029.28801-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211213029.28801-2-pierre-louis.bossart@linux.intel.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> +static int byt_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
> +{
> +       u64 cmd = msg->header;
> +
> +       /* send the message */
> +       sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
> +                         msg->msg_size);

I was wondering if the mailbox shared memory wouldn't be better
implemented as a queue.
Do you support playing multiple streams in parallel?

We have this use case where we need to to memory to memory
decoding/encoding with lots
of streams in parallel.
