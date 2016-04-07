From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/6] ASoC: davinci-mcbsp: add binding for
 McBSP
Date: Thu, 7 Apr 2016 17:37:00 +0200
Message-ID: <57067E9C.1090902@barix.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-2-git-send-email-petr@barix.com> <570661A6.6020804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570661A6.6020804-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 07.04.2016 15:33, Peter Ujfalusi wrote:
> On 04/06/16 16:21, Petr Kulhavy wrote:
>> Add devicetree binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx
>> MultiChannel Buffered Serial Port (McBSP)
>>
>> The optional register range "dat" is not implemented at the moment.
>> The current driver supports only DMA into RX/TX registers but no FIFO.
>> Once the FIFO is implemented in the driver the "dat" range will be used.
>>
>> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>> ---
>>   .../bindings/sound/davinci-mcbsp-audio.txt         | 57 ++++++++++++++++++++++
> I would drop the -audio postfix.
> I know the McASP introduced this and it is annoying. Let's not repeat it again...
>
I'm going to correct it, thanks.

>>   1 file changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp-audio.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp-audio.txt
>> new file mode 100644
>> index 000000000000..f60fceb927dd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp-audio.txt
>> @@ -0,0 +1,57 @@
>> +Texas Instruments DaVinci McBSP module
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
>> +audio interface found in some TI DaVinci processors like e.g. the DA850,
>> +DM6446, DA355.
> Given that the driver is actually a driver for daVinci ASP and it completely
> ignores registers introduced when the IP is renamed from ASP to McBSP, should
> we say something about this? That the ASP is compatible or subset of McBSP
> (w/o the multichannel support) and these bindings could be used for ASP, with
> adding new compatible?
> Or just leave that out and bother with it when we have such a device booting
> with DT?
It would be nice to mention both but if there is only one compatible 
string then it doesn't make much sense. And saying "you can add your own 
compatible string" is the binding not the right place to say this.
But could we add another compatible string for the older ASP?

Petr
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
