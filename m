From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 08/14] ASoC: SOF: Add DSP HW abstraction
	operations
Date: Wed, 12 Dec 2018 01:16:37 +0200
Message-ID: <20181211231637.GN10650@smile.fi.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-9-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20181211212318.28644-9-pierre-louis.bossart@linux.intel.com>
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

On Tue, Dec 11, 2018 at 03:23:12PM -0600, Pierre-Louis Bossart wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Add operation pointers that can be called by core to control a wide
> variety of DSP targets. The DSP HW drivers will fill in these
> operations.

> +int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
> +				     u32 mask, u32 value)
> +{
> +	bool change;
> +	unsigned int old, new;
> +	u32 ret = ~0; /* explicit init to remove uninitialized use warnings */
> +
> +	pci_read_config_dword(sdev->pci, offset, &ret);
> +	dev_dbg(sdev->dev, "Debug PCIR: %8.8x at  %8.8x\n",
> +		pci_read_config_dword(sdev->pci, offset, &ret), offset);
> +
> +	old = ret;
> +	new = (old & (~mask)) | (value & mask);
> +

> +	change = (old != new);
> +	if (change) {
> +		pci_write_config_dword(sdev->pci, offset, new);
> +		dev_dbg(sdev->dev, "Debug PCIW: %8.8x at  %8.8x\n", value,
> +			offset);
> +	}
> +
> +	return change;

What about dropping change completely?

if (old == new)
	return false;

...
return true;


> +}
> +EXPORT_SYMBOL(snd_sof_pci_update_bits_unlocked);

> +int snd_sof_dsp_update_bits_unlocked(struct snd_sof_dev *sdev, u32 bar,
> +				     u32 offset, u32 mask, u32 value)
> +{
> +	bool change;
> +	unsigned int old, new;
> +	u32 ret;
> +
> +	ret = snd_sof_dsp_read(sdev, bar, offset);
> +
> +	old = ret;
> +	new = (old & (~mask)) | (value & mask);
> +
> +	change = (old != new);
> +	if (change)
> +		snd_sof_dsp_write(sdev, bar, offset, new);
> +
> +	return change;

Ditto.
Everywhere in similar places.

> +}
> +EXPORT_SYMBOL(snd_sof_dsp_update_bits_unlocked);

> +	/* check if set state successful */
> +	for (time = 5; time > 0; time--) {
> +		if ((snd_sof_dsp_read(sdev, bar, offset) & mask) == target)
> +			break;
> +		msleep(20);
> +	}
> +
> +	if (!time) {
> +		/* sleeping in 10ms steps so adjust timeout value */
> +		timeout /= 10;
> +
> +		for (time = timeout; time > 0; time--) {

> +			if ((snd_sof_dsp_read(sdev, bar, offset) & mask) ==
> +				target)

I would leave it on one line.

> +				break;
> +
> +			usleep_range(5000, 10000);
> +		}
> +	}
> +
> +	ret = time ? 0 : -ETIME;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(snd_sof_dsp_register_poll);

> +static inline void snd_sof_dsp_write64(struct snd_sof_dev *sdev, u32 bar,
> +				       u32 offset, u64 value)
> +{
> +	if (sdev->ops->write64)

> +		sdev->ops->write64(sdev,
> +			sdev->bar[bar] + offset, value);

Why not one line?

> +}


-- 
With Best Regards,
Andy Shevchenko
