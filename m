From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 08/14] ASoC: SOF: Add DSP HW abstraction
	operations
Date: Thu, 14 Feb 2019 15:45:10 +0200
Message-ID: <20190214134510.GZ9224@smile.fi.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-9-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20190213220734.10471-9-pierre-louis.bossart@linux.intel.com>
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

On Wed, Feb 13, 2019 at 04:07:28PM -0600, Pierre-Louis Bossart wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Add operation pointers that can be called by core to control a wide
> variety of DSP targets. The DSP HW drivers will fill in these
> operations.

> +int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
> +				     u32 mask, u32 value)
> +{
> +	struct pci_dev *pci = to_pci_dev(sdev->dev);
> +	unsigned int old, new;

> +	u32 ret = ~0; /* explicit init to remove uninitialized use warnings */

In case you handle pci_read_config_dword() errors, would you get same warning?

Something like

unsigned int old, new;
int ret;

ret = pci_read_config_dword(..., &old);
if (ret)
	return -ENXIO;

...


I really don't like such assignments that potentially can shadow a real corner
cases.

> +
> +	pci_read_config_dword(pci, offset, &ret);
> +	old = ret;
> +	dev_dbg(sdev->dev, "Debug PCIR: %8.8x at  %8.8x\n", old & mask, offset);
> +

> +	new = (old & (~mask)) | (value & mask);

(~mask) -> ~mask.

> +
> +	if (old == new)
> +		return false;



> +
> +	pci_write_config_dword(pci, offset, new);
> +	dev_dbg(sdev->dev, "Debug PCIW: %8.8x at  %8.8x\n", value,
> +		offset);
> +
> +	return true;
> +}

-- 
With Best Regards,
Andy Shevchenko
