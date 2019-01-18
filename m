From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 01/21] ASoC: SOF: Intel: Add BYT,
	CHT and BSW DSP HW support.
Date: Fri, 18 Jan 2019 10:14:10 +0200
Message-ID: <CAEnQRZCgwXTMQPEE47DTY_wgvB5QiUu0sXFjfenhc_w3HnaRfA@mail.gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

<snip>

> +/* cherrytrail and braswell ops */
> +struct snd_sof_dsp_ops sof_cht_ops = {
> +       /* device init */
> +       .probe          = byt_probe,
> +
> +       /* DSP core boot / reset */
> +       .run            = byt_run,
> +       .reset          = byt_reset,
> +
> +       /* Register IO */
> +       .write          = sof_io_write,
> +       .read           = sof_io_read,
> +       .write64        = sof_io_write64,
> +       .read64         = sof_io_read64,
> +
> +       /* Block IO */
> +       .block_read     = sof_block_read,
> +       .block_write    = sof_block_write,
> +
> +       /* doorbell */
> +       .irq_handler    = byt_irq_handler,
> +       .irq_thread     = byt_irq_thread,
> +

What is the reason for having irq_handler/irq_thread functions inside the
snd_sof_dsp_ops structure?

These functions are never used outside via sdev->ops pointer.

thanks,
Daniel.
