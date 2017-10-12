From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Thu, 12 Oct 2017 14:26:42 +0100
Message-ID: <d68d2f4f-92d9-76a7-aea7-4c91924819f3@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171012110145.GA13024@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171012110145.GA13024@buildpc-HP-Z230>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanyog Kale <sanyog.r.kale-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 12/10/17 12:01, Sanyog Kale wrote:
> On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> +Per specification, Slimbus uses "clock gears" to do power management based on
>> +current frequency and bandwidth requirements. There are 10 clock gears and each
>> +gear changes the Slimbus frequency to be twice its previous gear.
> 
> Does the spec mandate 10 clock gears or its controller property?

Clock Gear Construct is part of SLIMbus Specs to alter clk frequency.


>> +Device notifications to the driver:
>> +-----------------------------------
>> +Since SLIMbus devices have mechanisms for reporting their presence, the
>> +framework allows drivers to bind when corresponding devices report their
>> +presence on the bus.
>> +However, it is possible that the driver needs to be probed
>> +first so that it can enable corresponding SLIMbus devie (e.g. power it up and/or
>> +take it out of reset). To support that behavior, the framework allows drivers
>> +to probe first as well  (e.g. using standard DeviceTree compatbility field).
>> +This creates the necessity for the driver to know when the device is functional
>> +(i.e. reported present). device_up callback is used for that reason when the
>> +device reports present and is assigned a logical address by the controller.
>> +
>> +Similarly, SLIMbus devices 'report absent' when they go down. A 'device_down'
>> +callback notifies the driver when the device reports absent and its logical
>> +address assignment is invalidated by the controller.
> 
> Is the same logical address assign when it reports present again?

Currently, Code as it is will pick the first available logical address. 
If required we can add logic in future to assign same logical address.
For now the code is simple.



>> + *
>> + *	Controller here performs duties of the manager device, and 'interface
>> + *	device'. Interface device is responsible for monitoring the bus and
>> + *	reporting information such as loss-of-synchronization, data
>> + *	slot-collision.
>> + * @dev: Device interface to this driver
>> + * @nr: Board-specific number identifier for this controller/bus
>> + * @list: Link with other slimbus controllers
>> + * @name: Name for this controller
>> + * @min_cg: Minimum clock gear supported by this controller (default value: 1)
>> + * @max_cg: Maximum clock gear supported by this controller (default value: 10)
>> + * @clkgear: Current clock gear in which this bus is running
>> + * @a_framer: Active framer which is clocking the bus managed by this controller
>> + * @m_ctrl: Mutex protecting controller data structures
>> + * @addrt: Logical address table
>> + * @num_dev: Number of active slimbus slaves on this bus
>> + * @wq: Workqueue per controller used to notify devices when they report present
>> + * @xfer_msg: Transfer a message on this controller (this can be a broadcast
>> + *	control/status message like data channel setup, or a unicast message
>> + *	like value element read/write.
> 
> xfer_msg element is not present in structure.
> 

Thanks, it will be fixed in next version.

thanks,
Srini


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
