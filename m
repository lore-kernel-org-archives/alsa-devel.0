From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/5] ASoC: generic-dmaengine-pcm:
 Prepare formats mask for valid physical sample sizes
Date: Wed, 02 Jul 2014 16:13:59 +0200
Message-ID: <53B413A7.6070301@metafoo.de>
References: <1404307763-30557-1-git-send-email-peter.ujfalusi@ti.com>	<1404307763-30557-4-git-send-email-peter.ujfalusi@ti.com>	<s5h61jf6fec.wl%tiwai@suse.de>	<53B412C1.20406@metafoo.de>
 <s5h38ej6e8y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 8057B265151
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 16:14:00 +0200 (CEST)
In-Reply-To: <s5h38ej6e8y.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, joelf@ti.com, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, dan.j.williams@intel.com
List-Id: alsa-devel@alsa-project.org

On 07/02/2014 04:12 PM, Takashi Iwai wrote:
> At Wed, 02 Jul 2014 16:10:09 +0200,
> Lars-Peter Clausen wrote:
>>
>> On 07/02/2014 03:47 PM, Takashi Iwai wrote:
>> [...]
>>>> +	/*
>>>> +	 * Prepare formats mask for valid/allowed sample types. If the dma does
>>>> +	 * not have support for the given physical word size, it needs to be
>>>> +	 * masked out so user space can not use the format which produces
>>>> +	 * corrupted audio.
>>>> +	 * In case the dma driver does not implement the slave_caps the default
>>>> +	 * assumption is that it supports 1, 2 and 4 bytes widths.
>>>> +	 */
>>>> +	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
>>>> +		int bits = snd_pcm_format_physical_width(i);
>>>
>>> Better to add a negative value check.  Some formats return -EINVAL.
>>>
>>
>> So what should we do with those formats? Not support them?
>
> Yes, these are special formats that can't be handled generically.
>

Looking through the list in pcm_misc.c there are also some formats where the 
physical width is not a multiple of 8. We should probably also skip those.

- Lars
