From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 04/13] slimbus: core: Add slim controllers support
Date: Mon, 20 Nov 2017 06:47:58 +0000
Message-ID: <64797182-9244-e6e7-8044-dbc404cdda7c@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-5-srinivas.kandagatla@linaro.org>
 <20171116164233.GB3187@localhost>
 <55794ca5-b70a-4866-1e80-bc0e78880c50@linaro.org>
 <20171117044222.GK3187@localhost> <20171117081322.GF10671@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117081322.GF10671@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org



On 17/11/17 08:13, Greg KH wrote:
> On Fri, Nov 17, 2017 at 10:12:22AM +0530, Vinod Koul wrote:
>> On Thu, Nov 16, 2017 at 05:29:35PM +0000, Srinivas Kandagatla wrote:
>>> thanks for the comments.
>>>
>>>
>>> On 16/11/17 16:42, Vinod Koul wrote:
>>>> On Wed, Nov 15, 2017 at 02:10:34PM +0000,srinivas.kandagatla@linaro.org  wrote:
>>>>
>>>>> +static void slim_dev_release(struct device *dev)
>>>>> +{
>>>>> +	struct slim_device *sbdev = to_slim_device(dev);
>>>>> +
>>>>> +	put_device(sbdev->ctrl->dev);
>>>> which device would that be?
>>> This is controller device
>>>
>>>>> +static int slim_add_device(struct slim_controller *ctrl,
>>>>> +			   struct slim_device *sbdev,
>>>>> +			   struct device_node *node)
>>>>> +{
>>>>> +	sbdev->dev.bus = &slimbus_bus;
>>>>> +	sbdev->dev.parent = ctrl->dev;
>>>>> +	sbdev->dev.release = slim_dev_release;
>>>>> +	sbdev->dev.driver = NULL;
>>>>> +	sbdev->ctrl = ctrl;
>>>>> +
>>>>> +	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
>>>>> +				  sbdev->e_addr.manf_id,
>>>>> +				  sbdev->e_addr.prod_code,
>>>>> +				  sbdev->e_addr.dev_index,
>>>>> +				  sbdev->e_addr.instance);
>>>>> +
>>>>> +	get_device(ctrl->dev);
>>>> is this controller device and you ensuring it doesnt go away while you have
>>>> slaves on it?
>>> Yes.
>> I thought since you are marking ctrl->dev as parent, the device core should
>> ensure that parent doesn't go off when you have child device?
>>
>> Greg, is that understanding correct, if so we may not need these calls.
> That understanding should be correct, as the reference count is
> incremented on the parent when a child is added.
> 
> It would be trivial for this to be tested, and yes, I am pretty sure you
> don't need this call.
> 

Thanks for suggestion, I will remove this in next version.


thanks,
srini
