From: Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 02/10] dt: add img,axd.txt device tree binding document
Date: Mon, 24 Aug 2015 14:49:24 +0100
Message-ID: <55DB20E4.60708@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-3-git-send-email-qais.yousef@imgtec.com> <20150824132633.GF7139@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150824132633.GF7139@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 08/24/2015 02:26 PM, Mark Rutland wrote:
> On Mon, Aug 24, 2015 at 01:39:11PM +0100, Qais Yousef wrote:
>> Signed-off-by: Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
>> Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> ---
>>   .../devicetree/bindings/sound/img,axd.txt          | 34 ++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/img,axd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/img,axd.txt b/Documentation/devicetree/bindings/sound/img,axd.txt
>> new file mode 100644
>> index 000000000000..6a8764a79d01
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/img,axd.txt
>> @@ -0,0 +1,34 @@
>> +* AXD Audio Processing IP Binding *
>> +
>> +Required properties:
>> +- compatible: "img,axd"
> This sounds awfully generic. Is there not a more complete name?

Shouldn't img prefix to help against this? We can sure use another name 
though like "img,axd-audio-decoder" or something like that. I'll need to 
check.

>
>> +- clocks: phandle for the clock that drives AXD.
>> +- interrupts: the GIC interrupt where AXD is connected
>> +- gic-irq: it takes two non-zero values, the first one is the host hwirq and
>> +           the second one is AXD's. Host's hwirq should match the value in
>> +           interrupts.
> I don't understand what this gic-irq property is for; and it generally
> doesn't look right.
>
> Could you please describe what this is and why you thing it is
> necessary?

AXD and host cores exchange interrupts using GIC interrupt controller. 
To configure AXD firmware to send and listen to the correct GIC 
interrupts we need these values, hence this property.

If there's a way to reverse the irq mappings of 'interrupts' property 
from the driver code we can get rid of that and have 2 interrupts 
properties instead. But as far as I can see there's no way to get the hw 
irq value from the mapped linux irq unless I missed something.

>
>> +
>> +Optional properties:
>> +- vpe: VPE number on which AXD should start. Must be provided if AXD is
>> +       running as a single VPE along Linux on the same core.
>> +       It can't be VPE0.
>> +       The VPE will be offlined before AXD is loaded.
> Likewise could you please elaborate on this is?
>
> What is a VPE number? What does it mean to start at that number?

VPE is MIPS notation of hardware thread. Instead of being a complete 
separate core AXD can run as a hardware thread (VPE) inside a Linux 
core. This number indicates which hardware thread to run AXD at.

>
>> +- inbuf-size: size of shared input buffers area. By default it's 0x7800 bytes.
>> +- outbuf-size: size of shared output buffers area. By default it's 0x3c000 bytes.
> Is this something the kernel dynamically allocates? Why does this need
> to be in the DT?

We use CMA to allocate this buffer area. This optional property is there 
to give the user a chance to use larger/smaller buffers if they think 
they need to. This buffer area is shared between Linux and AXD to 
exchange data.

Thanks,
Qais

>
> Thanks,
> Mark.
>
>> +
>> +
>> +Example:
>> +
>> +	axdclk: axdclk@400M {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <400000000>;
>> +	};
>> +
>> +	axd {
>> +		compatible = "img,axd";
>> +		clocks = <&axdclk>;
>> +		interrupts = <36 IRQ_TYPE_EDGE_RISING>;
>> +		gic-irq = <36 37>;
>> +		vpe = <1>;
>> +	};
>> -- 
>> 2.1.0
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
