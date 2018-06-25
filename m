From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
Date: Mon, 25 Jun 2018 11:11:20 +0100
Message-ID: <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <20180622125050.GO27187@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622125050.GO27187@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, sdharia@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, ctatlor97@gmail.com
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for the Review,

On 22/06/18 13:50, Vinod wrote:
> On 21-06-18, 14:40, Srinivas Kandagatla wrote:
>> This patch adds support to SLIMbus stream apis for slimbus device.
>> SLIMbus streaming involves adding support to Data Channel Management and
>> channel Reconfiguration Messages to slim core plus few stream apis.
>> >From slim device side the apis are very simple mostly inline with other
>    ^^
> Bad char >
Yep, will fix it.
> 
>> +/**
>> + * enum slim_port_direction: SLIMbus port direction
> 
> blank line here makes it more readable
> 
Sure it makes sense.
>> +/**
>> + * struct slim_presence_rate - Presense Rate table for all Natural Frequencies
>> + *	The Presense rate of a constant bitrate stram is mean flow rate of the
>                                                  ^^^^^
> Do you mean stream?
Yep will fix it.
> 
>> +static struct slim_presence_rate {
>> +	int rate;
>> +	int pr_code;
>> +} prate_table[] = {
>> +	{12000,		0x01},
>> +	{24000,		0x02},
>> +	{48000,		0x03},
>> +	{96000,		0x04},
>> +	{192000,	0x05},
>> +	{384000,	0x06},
>> +	{768000,	0x07},
>> +	{110250,	0x09},
>> +	{220500,	0x0a},
>> +	{441000,	0x0b},
>> +	{882000,	0x0c},
>> +	{176400,	0x0d},
>> +	{352800,	0x0e},
>> +	{705600,	0x0f},
>> +	{4000,		0x10},
>> +	{8000,		0x11},
>> +	{16000,		0x12},
>> +	{32000,		0x13},
>> +	{64000,		0x14},
>> +	{128000,	0x15},
>> +	{256000,	0x16},
>> +	{512000,	0x17},
> 
> this table values are indices, so how about using only rate and removing
> pr_code and use array index for that, saves half the space..
> 
look like I over done it, I will fix this in next version.

>> +struct slim_stream_runtime *slim_stream_allocate(struct slim_device *dev,
>> +						 const char *name)
>> +{
>> +	struct slim_stream_runtime *rt;
>> +	unsigned long flags;
>> +
>> +	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
>> +	if (!rt)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rt->name = kasprintf(GFP_KERNEL, "slim-%s", name);
>> +	if (!rt->name) {
>> +		kfree(rt);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	rt->dev = dev;
>> +	rt->state = SLIM_STREAM_STATE_ALLOCATED;
>> +	spin_lock_irqsave(&dev->stream_list_lock, flags);
>> +	list_add_tail(&rt->node, &dev->stream_list);
>> +	spin_unlock_irqrestore(&dev->stream_list_lock, flags);
> 
> Any reason for _irqsave variant? Do you expect stream APIs to be called
> from ISR?We can move to non irqsave variant here, as i do not see a case where 
this list would be interrupted from irq context.


> 
>> +/*
>> + * slim_stream_prepare() - Prepare a SLIMbus Stream
>> + *
>> + * @rt: instance of slim stream runtime to configure
>> + * @cfg: new configuration for the stream
>> + *
>> + * This API will configure SLIMbus stream with config parameters from cfg.
>> + * return zero on success and error code on failure. From ASoC DPCM framework,
>> + * this state is linked to hw_params()/prepare() operation.
> 
> so would this be called from either.. btw prepare can be invoked
> multiple times, so that should be taken into consideration by caller.

This should be just hw_params() where we have more information on the 
audio parameters, I will make this more clear in the doc about this.

> 
>> + */
>> +int slim_stream_prepare(struct slim_stream_runtime *rt,
>> +			struct slim_stream_config *cfg)
>> +{
>> +	struct slim_controller *ctrl = rt->dev->ctrl;
>> +	struct slim_port *port;
>> +	int num_ports, i, port_id;
>> +
>> +	num_ports = hweight32(cfg->port_mask);
>> +	rt->ports = kcalloc(num_ports, sizeof(*port), GFP_ATOMIC);
> 
> since this is supposed to be invoked in hw_params()/prepare, why would
> we need GFP_ATOMIC here?
No, we do not need this to be ATOMIC, will remove this!

> 
>> +static int slim_activate_channel(struct slim_stream_runtime *stream,
>> +				 struct slim_port *port)
>> +{
>> +	struct slim_device *sdev = stream->dev;
>> +	struct slim_val_inf msg = {0, 0, NULL, NULL};
>> +	u8 mc = SLIM_MSG_MC_NEXT_ACTIVATE_CHANNEL;
>> +	DEFINE_SLIM_LDEST_TXN(txn, mc, 5, stream->dev->laddr, &msg);
>> +	u8 wbuf[1];
>> +
>> +	txn.msg->num_bytes = 1;
>> +	txn.msg->wbuf = wbuf;
>> +	wbuf[0] = port->ch.id;
>> +	port->ch.state = SLIM_CH_STATE_ACTIVE;
>> +
>> +	return slim_do_transfer(sdev->ctrl, &txn);
>> +}
> 
> how about adding a macro for sending message, which fills slim_val_inf
> and you invoke that with required parameters to be filled.
> 
Sounds sensible thing, I will give that a try and see!

>> +/*
>> + * slim_stream_enable() - Enable a prepared SLIMbus Stream
> 
> Do you want to check if it is already prepared ..?
Yep, I think most of the code needs similar state machine check, I will 
add this in next version.
> 
>> +/**
>> + * slim_stream_direction: SLIMbus stream direction
>> + *
>> + * @SLIM_STREAM_DIR_PLAYBACK: Playback
>> + * @SLIM_STREAM_DIR_CAPTURE: Capture
>> + */
>> +enum slim_stream_direction {
>> +	SLIM_STREAM_DIR_PLAYBACK = 0,
>> +	SLIM_STREAM_DIR_CAPTURE,
> 
> this is same as SNDRV_PCM_STREAM_PLAYBACK, so should we use that here?
Sure will do, makes it clear!

> 
