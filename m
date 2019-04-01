From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 03/14] ASoC: SOF: Add driver debug
 support.
Date: Mon, 1 Apr 2019 13:15:46 -0400
Message-ID: <631c6cba-2f81-6f5f-3d5f-f9f5bbb171c7@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-4-pierre-louis.bossart@linux.intel.com>
 <s5hsgv5k6ox.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hsgv5k6ox.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/29/19 12:04 PM, Takashi Iwai wrote:
> On Thu, 21 Mar 2019 17:10:05 +0100,
> Pierre-Louis Bossart wrote:
>>
>> +static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
>> +				 size_t count, loff_t *ppos)
>> +{
>> +	struct snd_sof_dfsentry *dfse = file->private_data;
>> +	struct snd_sof_dev *sdev = dfse->sdev;
>> +	int size;
>> +	u32 *buf;
>> +	loff_t pos = *ppos;
>> +	size_t size_ret;
>> +
>> +	size = dfse->size;
>> +
>> +	/* validate position & count */
>> +	if (pos < 0)
>> +		return -EINVAL;
>> +	if (pos >= size || !count)
>> +		return 0;
>> +	/* find the minimum. min() is not used since it adds sparse warnings */
>> +	if (count > size - pos)
>> +		count = size - pos;
>> +
>> +	/* intermediate buffer size must be u32 multiple */
>> +	size = ALIGN(count, 4);
> 
> Doesn't pos need to be aligned to 32bit as well (at least at actually
> reading from iomem)?

Good point,  we can either return an error if the count in both a 
multiple of 32 bits, or do some caching to allow for arbitrary size 
access. The former is very simple but not sure if this is accepted 
behavior for debugfs.
