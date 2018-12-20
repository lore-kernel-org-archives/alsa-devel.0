From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware,
 loader support
Date: Thu, 20 Dec 2018 10:11:55 +0800
Message-ID: <1ce21393-048f-6c04-b899-8cbfbf93983e@linux.intel.com>
References: <mailman.3934.1544619824.753.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <mailman.3934.1544619824.753.alsa-devel@alsa-project.org>
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
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: daniel.baluta@gmail.com, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


> Date: Wed, 12 Dec 2018 12:23:33 +0100
> From: Takashi Iwai <tiwai@suse.de>
> To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, Daniel
> 	Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com,
> 	vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>,
> 	sound-open-firmware@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH v3 09/14] ASoC: SOF: Add firmware
> 	loader	support
> Message-ID: <s5htvjjj8ei.wl-tiwai@suse.de>
> Content-Type: text/plain; charset=US-ASCII
>
> On Tue, 11 Dec 2018 22:23:13 +0100,
> Pierre-Louis Bossart wrote:
>
>> +
>> +		snd_sof_dsp_block_write(sdev, offset,
>> +					(void *)block + sizeof(*block),
>> +					block->size);
>> +
>> +		/* next block */
>> +		block = (void *)block + sizeof(*block) + block->size;
> This may lead to an unaligned access.

Did you mean we should double check the block->size to
prevent access to an invalid address?

> Also how is the endianess guaranteed?

Did you mean we should guarantee the driver can work no
matter what kernel's endianess is?
ie. Use le32_to_cpu() to handle it?

>
>
> thanks,
>
> Takashi
>
>
