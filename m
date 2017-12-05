From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 01/13] Documentation: Add SLIMbus summary
Date: Tue, 5 Dec 2017 22:01:50 +0000
Message-ID: <96cbc048-e76a-ad36-bba2-e717bc8bc05b@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
 <20171130174200.6684-2-srinivas.kandagatla@linaro.org>
 <20171201102758.bcziygl3k46iepc6@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171201102758.bcziygl3k46iepc6@latitude>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments.

On 01/12/17 10:27, Jonathan Neuschäfer wrote:
> Hi, some small nits below.
> 
> On Thu, Nov 30, 2017 at 05:41:48PM +0000, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
>> developed by MIPI (Mobile Industry Processor Interface) alliance.
>> SLIMbus is a 2-wire implementation, which is used to communicate with
>> peripheral components like audio-codec.
>>
>> The summary of SLIMbus and API is documented in the 'summary' file.
>>
>> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   Documentation/driver-api/slimbus/index.rst   |  15 ++++
>>   Documentation/driver-api/slimbus/summary.rst | 108 +++++++++++++++++++++++++++
>>   2 files changed, 123 insertions(+)
>>   create mode 100644 Documentation/driver-api/slimbus/index.rst
>>   create mode 100644 Documentation/driver-api/slimbus/summary.rst
> 
> It would probably make sense to Cc the documentation maintainers/mailing
> list on this patch (AFAICS, you didn't do that).
> 
Yep, I will include them while sending next version.

> When do you plan to add slimbus to Documentation/driver-api/index.rst?

that's good point, I will fix this in next version.
> 

>> +framework allows drivers to bind when corresponding devices report their
>> +presence on the bus.
>> +However, it is possible that the driver needs to be probed
>> +first so that it can enable corresponding SLIMbus device (e.g. power it up and/or
>> +take it out of reset). To support that behavior, the framework allows drivers
>> +to probe first as well  (e.g. using standard DeviceTree compatbility field).
> 
> Typo: s/compatbility/compatibility/
Yep, Will fix in next version.

> 
>> +---------------
>> +The framework supports APIs to exchange control-information with a SLIMbus
>> +device. APIs can be synchronous or asynchronous.
>> +From controller's perspective, multiple buffers can be queued to/from
>> +hardware for sending/receiving data using slim_ctrl_buf circular buffer.
>> +The header file <linux/slimbus.h> has more documentation about messaging APIs.
> 
> Once the kerneldoc documentation (i.e. the /** ... */ comments in the
> source) is included somewhere, I think it would make sense to make
> slim_ctrl_buf a clickable link to the struct's documentation.
Sure, I will explore this side of it before i send next version.

thanks,
srini
> 
> 
> Thanks,
> Jonathan Neuschäfer
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
