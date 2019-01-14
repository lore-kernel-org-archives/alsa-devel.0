From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Mon, 14 Jan 2019 17:10:26 +0200
Message-ID: <CAEnQRZCj7QQ1N11t44uu0nz2D7rqjc5Avu29-ecbZ9oq4G0xfw@mail.gmail.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

<snip>

> +/* send next IPC message in list */
> +static void ipc_tx_next_msg(struct work_struct *work)
> +{
> +       struct snd_sof_ipc *ipc =
> +               container_of(work, struct snd_sof_ipc, tx_kwork);
> +       struct snd_sof_dev *sdev = ipc->sdev;
> +       struct snd_sof_ipc_msg *msg;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&sdev->ipc_lock, flags);
> +
> +       /* send message if HW read and message in TX list */

s/HW read/HW ready/ I think.

> +       if (list_empty(&ipc->tx_list) || !snd_sof_dsp_is_ready(sdev))
> +               goto out;
> +
