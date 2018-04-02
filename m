From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Mon, 2 Apr 2018 15:26:35 +0900
Message-ID: <f8f97f3a-3447-5d6d-eeb6-9140ce299e06@sakamocchi.jp>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
 <1522229918-4748-9-git-send-email-vinod.koul@intel.com>
 <355ca9b5-d6c4-9423-8cf6-a1c73fbdc695@sakamocchi.jp>
 <20180330060325.GA9729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id B03FE266A73
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 08:26:38 +0200 (CEST)
In-Reply-To: <20180330060325.GA9729@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Greg,

I'm sorry for delay but I had a short trip.

On Mar 30 2018 15:03, Greg KH wrote:
> On Fri, Mar 30, 2018 at 12:05:00PM +0900, Takashi Sakamoto wrote:
>> Hi,
>>
>> On Mar 28 2018 18:38, Vinod Koul wrote:
>>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>>> index c0edac80df34..690e56a35237 100644
>>> --- a/sound/soc/soc-core.c
>>> +++ b/sound/soc/soc-core.c
>>> @@ -2882,6 +2882,26 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
>>>    EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
>>>    /**
>>> + * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
>>> + * @dai: DAI
>>> + * @stream: STREAM
>>> + * @direction: Stream direction(Playback/Capture)
>>> + * SoundWire subsystem doesn't have a notion of direction and we reuse
>>> + * the ASoC stream direction to configure sink/source ports.
>>> + *
>>> + * Returns 0 on success, a negative error code otherwise.
>>> + */
>>> +int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>> +				void *stream, int direction)
>>> +{
>>> +	if (dai->driver->ops->set_sdw_stream)
>>> +		return dai->driver->ops->set_sdw_stream(dai, stream, direction);
>>> +	else
>>> +		return -ENOTSUPP;
>>> +}
>>> +EXPORT_SYMBOL_GPL(snd_soc_dai_set_sdw_stream);
>>
>> It's better for this kind of code to be incline function in any header. In
>> general, new symbols increase maintenance cost of binary of kernel-related
>> stuffs. It's preferable to avoid the addition if possible, IMO.
> 
> I don't understand, functionally it's the same, there should not be any
> increased maintenance either way.  Please explain how this makes things
> "harder"?

Hm, if so it might be my misunderstanding to reasons for typical usage 
of inline functions in kernel source, sorry.

In my understanding, exported symbols are put into some sections of ELF 
binary. Addition of new symbols increases size of the section. 
Additionally, after linking vmlinux, kbuild scans built-in symbols and 
make a file with entries of them. The addition increases time of this 
step. Furthermore, at the end of building kernel, kmod is called to 
generate some map files for exported symbols in loadable module. In a 
view of distributors, these files are maintained by binary packages of 
any type carefully because some incompatibilities can be delivered such 
as version mismatch.

For these reasons, I think thing goes harder when people carelessly add 
new symbols for functions with a few codes; e.g. accessing to a member 
of structure, then simply check an return it. Actually I can see some 
examples in upstreamed headers.


Thanks

Takashi Sakamoto
