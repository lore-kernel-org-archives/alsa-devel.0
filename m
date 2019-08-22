From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream
 config/free callbacks
Date: Thu, 22 Aug 2019 08:53:06 -0500
Message-ID: <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822071835.GA30262@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, YueHaibing <yuehaibing@huawei.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Thanks for the review Guennadi

>> +static int sdw_config_stream(void *arg, void *s, void *dai,
>> +			     void *params, int link_id, int alh_stream_id)
> 
> I realise, that these function prototypes aren't being introduced by these
> patches, but just wondering whether such overly generic prototype is really
> a good idea here, whether some of those "void *" pointers could be given
> real types. The first one could be "struct device *" etc.

In this case the 'arg' parameter is actually a private 'struct 
snd_sof_dev', as shown below [1]. We probably want to keep this 
relatively opaque, this is a context that doesn't need to be exposed to 
the SoundWire code.

The dai and params are indeed cases where we could use stronger types, 
they are snd_soc_dai and hw_params respectively. I don't recall why the 
existing code is this way, Vinod and Sanyog may have the history of this.

> 
>> +{
>> +	struct snd_sof_dev *sdev = arg;
>> +	struct snd_soc_dai *d = dai;
[1]

>> +	struct sof_ipc_dai_config config;
>> +	struct sof_ipc_reply reply;
>> +	int ret;
>> +	u32 size = sizeof(config);
>> +
>> +	memset(&config, 0, size);
>> +	config.hdr.size = size;
>> +	config.hdr.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG;
>> +	config.type = SOF_DAI_INTEL_ALH;
>> +	config.dai_index = (link_id << 8) | (d->id);
>> +	config.alh.stream_id = alh_stream_id;
> 
> Entirely up to you, in such cases I usually do something like
> 
> +	struct sof_ipc_dai_config config = {
> +		.type = SOF_DAI_INTEL_ALH,
> +		.hre = {
> +			.size = sizeof(config),
> +			.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG,
> +			...
> 
> which then also avoids a memset(). But that's mostly a matter of personal
> preference, since this is on stack, the compiler would probably internally
> anyway translate the above initialisation to a memset() with all the
> following assignments.

I have no preference, so in this case I will go with consistency with 
existing code, which uses the suggested style for all IPCs.

> 
>> +
>> +	/* send message to DSP */
>> +	ret = sof_ipc_tx_message(sdev->ipc,
>> +				 config.hdr.cmd, &config, size, &reply,
>> +				 sizeof(reply));
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev,
>> +			"error: failed to set DAI hw_params for link %d dai->id %d ALH %d\n",
> 
> Are readers really expected to understand what "dai->id" means? Wouldn't
> "DAI ID" be friendlier, although I understand you - who might not know
> what "x->y" stands for?.. ;-)

I was trying to avoid a confusion here, we have config->dai_index which 
are shared concepts between topology and firmware, and dai->id which is 
shared between topology and machine driver (which refers to the dai in 
the dai_link which has its own .id). In topology files we have the three 
indices and of course after a couple of weeks I can't recall which one 
maps to what.
I am afraid DAI ID might be confused with dai_index. If there are 
suggestions on this I am all ears, all I care about is avoiding 
ambiguity and having to ask Ranjani what index this really is :-)
