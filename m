From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [Patch v6 2/7] slimbus: Add messaging APIs to
 slimbus framework
Date: Wed, 11 Oct 2017 12:12:20 +0100
Message-ID: <8a6e9376-89a6-56d4-055a-29aae7abc311@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
 <20171011043814.GF30097@localhost>
 <aa117cb8-ba59-894c-5a82-1b38facfa841@linaro.org>
 <20171011102436.GH30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011102436.GH30097@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org



On 11/10/17 11:24, Vinod Koul wrote:
> On Wed, Oct 11, 2017 at 10:42:28AM +0100, Srinivas Kandagatla wrote:
>> On 11/10/17 05:38, Vinod Koul wrote:
>>> On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla@linaro.org wrote:
>>>
>>>>   	mutex_init(&ctrl->m_ctrl);
>>>> +	spin_lock_init(&ctrl->tx.lock);
>>>> +	spin_lock_init(&ctrl->rx.lock);
>>>
>>> locks galore :) My assumption is that you want to optimize these? But given
>>> that audio user is going to be serialized do we practically need two locks?
>>>
>> If we remove the locking, It will be issue if we have multiple devices in a
>> component, which is common atleast with the codec which am looking at.
> 
> can you explian what you mean by a "device" here?

SLIMbus component contain two or more SLIMbus devices,
like function(Generic) device, interface device.
Interface device provides bus management services, where as generic 
device provides more of application specific functionality like ADC/DAC..


> 
>>>> +	switch (mc) {
>>>> +	case SLIM_MSG_MC_REQUEST_VALUE:
>>>> +	case SLIM_MSG_MC_REQUEST_INFORMATION:
>>>
>>> what does MC refer to?
>>
>> Message Code.
> 
> isnt SLIM_MSG enough :D I think we cna get rid of MC here..
> 
>>>> +struct slim_val_inf {
>>>> +	u16			start_offset;
>>>> +	u8			num_bytes;
>>>> +	u8			*rbuf;
>>>> +	const u8		*wbuf;
>>>
>>> can we do read and write, if not it can be a buf which maybe rbuf or wbug
>>> based on type
>> With REQUEST_CHANGE_VALUE single command we can read old value at the same
>> time we can write new value.
> 
> so that is a read modify write, correct? Is that implemented in HW, if so we
> need to provide only write value

Its not really a read-modify-write,
REQUEST_CHANGE_VALUE/REQUEST_CLEAR_INFORMATION commands are part of 
SLIMbus Spec.
We need provide write value + buffer for read value to store.

all REQUEST_CHANGE_VALUE cmd do is this in single operation:

1> save the old value
2> update new value from wbuf
3> return the saved value from step 1, into rbuf

Not sure what is the real usecase for this, I have not seen its usage in 
any Qualcomm downstream code.

May be it can be used to implement some class of atomic ops.
