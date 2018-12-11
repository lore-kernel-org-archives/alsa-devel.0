From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware loader
	support
Date: Wed, 12 Dec 2018 00:38:29 +0200
Message-ID: <20181211223829.GJ10650@smile.fi.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20181211212318.28644-10-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 11, 2018 at 03:23:13PM -0600, Pierre-Louis Bossart wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> The firmware loader exports APIs that can be called by core to load and
> process multiple different file formats.

> +static int get_ext_windows(struct snd_sof_dev *sdev,
> +			   struct sof_ipc_ext_data_hdr *ext_hdr)
> +{
> +	struct sof_ipc_window *w = (struct sof_ipc_window *)ext_hdr;
> +

> +	int ret = 0;

I don't see how it's used. Perhaps you need to check code with `make W=1`.

> +	size_t size;
> +
> +	if (w->num_windows == 0 || w->num_windows > SOF_IPC_MAX_ELEMS)
> +		return -EINVAL;
> +
> +	size = sizeof(*w) + sizeof(struct sof_ipc_window_elem) * w->num_windows;
> +
> +	/* keep a local copy of the data */
> +	sdev->info_window = kmemdup(w, size, GFP_KERNEL);
> +	if (!sdev->info_window)
> +		return -ENOMEM;
> +
> +	return ret;
> +}

> +			dev_warn(sdev->dev,
> +				 "warning: block %d size zero\n", count);
> +			dev_warn(sdev->dev, " type 0x%x offset 0x%x\n",
> +				 block->type, block->offset);

Hmm... Why do we need a kernel level duplication in words?

> +int snd_sof_load_firmware(struct snd_sof_dev *sdev)
> +{

> +	dev_dbg(sdev->dev, "loading firmware\n");

Noise.
Better to introduce a trace points and drop all these kind of messages.

> +
> +	if (sdev->ops->load_firmware)
> +		return sdev->ops->load_firmware(sdev);
> +	return 0;
> +}
> +EXPORT_SYMBOL(snd_sof_load_firmware);

-- 
With Best Regards,
Andy Shevchenko
