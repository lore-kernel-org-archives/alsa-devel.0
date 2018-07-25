From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 3/8] ASoC: Intel: Boards: Machine driver
 for SKL+ w/ HDAudio codecs
Date: Wed, 25 Jul 2018 11:45:00 -0500
Message-ID: <949e175f-b582-0438-1218-4aa7960278b2@linux.intel.com>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-4-pierre-louis.bossart@linux.intel.com>
 <20180725111145.GM3661@vkoul-mobl>
 <c9577eef-3b32-e1b9-17e2-0bedce8109c8@linux.intel.com>
 <20180725162208.GW3661@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 94EFC26774A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:45:03 +0200 (CEST)
In-Reply-To: <20180725162208.GW3661@vkoul-mobl>
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
To: Vinod <vkoul@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On 7/25/18 11:22 AM, Vinod wrote:
> On 25-07-18, 09:10, Pierre-Louis Bossart wrote:
>> On 7/25/18 6:11 AM, Vinod wrote:
> 
>>>> +		.dpcm_playback = 1,
>>>> +		.no_pcm = 1,
>>>> +	},
>>>> +	{
>>>> +		.name = "iDisp2",
>>>> +		.id = 2,
>>>> +		.cpu_dai_name = "iDisp2 Pin",
>>>> +		.codec_name = "ehdaudio0D2",
>>>> +		.codec_dai_name = "intel-hdmi-hifi2",
>>>> +		.platform_name = "0000:00:1f.3",
>>>> +		.dpcm_playback = 1,
>>>> +		.no_pcm = 1,
>>>> +	},
>>>> +	{
>>>> +		.name = "iDisp3",
>>>> +		.id = 3,
>>>
>>> shouldn't this be queried. not all will have 3 links
>>
>> Not that I know of. I've always seen SKL+ with 3 audio streams to iDisp.
> 
> IIRC later ones (after KBL) have 5 CVTs and 4 pins (or vice-versa)

Let me check on this.

> 
>>>> +static struct platform_driver skl_hda_audio = {
>>>> +	.probe = skl_hda_audio_probe,
>>>> +	.driver = {
>>>> +		.name = "skl_hda_dsp_generic",
>>>
>>> who creates this pdev, is it the board details (mach name?)
>>
>> Not sure I understand your question, this part is similar to all other Intel
>> machine drivers and the way by with the probe happens is also similar. There
>> is nothing new here, the skylake platform driver finds an entry in a table,
>> gets the driver name and creates the relevant device.
> 
> Okay sounds good. I was curious if the generic machine device is created
> generically or use the tables..

we anticipate that there will be quirks, e.g. a machine with an HDaudio 
codec but DMICs, and the idea is that those quirks would point a 
different table entry (or set a pdata field). For now we haven't done 
any work on those quirks, we'll deal with them as we see new variants.
