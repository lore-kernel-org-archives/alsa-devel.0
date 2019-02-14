From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v4 08/14] ASoC: SOF:
 Add DSP HW abstraction operations
Date: Thu, 14 Feb 2019 09:22:52 -0600
Message-ID: <2cf18a8f-98c1-8e59-4749-819d8678759d@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-9-pierre-louis.bossart@linux.intel.com>
 <s5h5ztmzert.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h5ztmzert.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 2/14/19 7:21 AM, Takashi Iwai wrote:
> On Wed, 13 Feb 2019 23:07:28 +0100,
> Pierre-Louis Bossart wrote:
>> +int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
>> +				     u32 mask, u32 value)
>> +{
>> +	struct pci_dev *pci = to_pci_dev(sdev->dev);
>> +	unsigned int old, new;
>> +	u32 ret = ~0; /* explicit init to remove uninitialized use warnings */
>> +
>> +	pci_read_config_dword(pci, offset, &ret);
>> +	old = ret;
>> +	dev_dbg(sdev->dev, "Debug PCIR: %8.8x at  %8.8x\n", old & mask, offset);
>> +
>> +	new = (old & (~mask)) | (value & mask);
>> +
>> +	if (old == new)
>> +		return false;
>> +
>> +	pci_write_config_dword(pci, offset, new);
>> +	dev_dbg(sdev->dev, "Debug PCIW: %8.8x at  %8.8x\n", value,
>> +		offset);
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(snd_sof_pci_update_bits_unlocked);
> 
> Better to change the return type to bool to make clearer.

will rework this to make both Andy and Takashi happy :-)
