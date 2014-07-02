From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: generic-dmaengine-pcm: Prepare
 formats mask for valid physical sample sizes
Date: Wed, 02 Jul 2014 16:10:09 +0200
Message-ID: <53B412C1.20406@metafoo.de>
References: <1404307763-30557-1-git-send-email-peter.ujfalusi@ti.com> <1404307763-30557-4-git-send-email-peter.ujfalusi@ti.com> <s5h61jf6fec.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h61jf6fec.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, joelf@ti.com, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, dan.j.williams@intel.com
List-Id: alsa-devel@alsa-project.org

On 07/02/2014 03:47 PM, Takashi Iwai wrote:
[...]
>> +	/*
>> +	 * Prepare formats mask for valid/allowed sample types. If the dma does
>> +	 * not have support for the given physical word size, it needs to be
>> +	 * masked out so user space can not use the format which produces
>> +	 * corrupted audio.
>> +	 * In case the dma driver does not implement the slave_caps the default
>> +	 * assumption is that it supports 1, 2 and 4 bytes widths.
>> +	 */
>> +	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
>> +		int bits = snd_pcm_format_physical_width(i);
>
> Better to add a negative value check.  Some formats return -EINVAL.
>

So what should we do with those formats? Not support them?

>> +
>> +		/* Enable only samples with DMA supported physical widths */
>> +		if (addr_widths & BIT(bits / 8))
>
> Just nitpicking: Using BIT() for 32bit int isn't always a wise choice
> since BIT() is defined as unsigned long.  This is a generic problem,
> though, as we see many codes using BIT() wrongly (and thus get
> compiler warnings on 64bit machines).  We should introduce a new macro
> for 32bit int...
