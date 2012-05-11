From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Fri, 11 May 2012 17:44:19 +0200
Message-ID: <4FAD33D3.3050104@ti.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
 <4FACF1C2.7050008@ti.com> <20120511130816.GB3960@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120511130816.GB3960-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Misael Lopez Cruz <misael.lopez-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 5/11/2012 3:08 PM, Mark Brown wrote:
> On Fri, May 11, 2012 at 01:02:26PM +0200, Cousson, Benoit wrote:
>> On 5/9/2012 3:35 PM, Mark Brown wrote:
>
>>> Clearly.  This is all very circular.  Obviously if you're intent on
>>> using a phandle specific to the MFD child then you need to have that in
>>> the device tree but this is because you're making the child devices
>>> externally visible...  Clearly if we're not going to use the MFD
>>> subdevices in the DT then the links ought to reference the chip.
>
>> I'm not sure to understand you concern here.
>
>> Describing sub nodes, especially for big SoC is pretty useful.
>> It is as useful as doing that for board that are sharing similar components.
>
> The concern here is that the device tree you're writing here is clearly
> just a direct translation of the particular stuff Linux happens to use
> internally into device tree; this is similar to the thing with using
> hwmod in the device tree representation and omitting basic stuff like
> the register ranges.
>
>> It will allow to define several Audio / PMIC variants without having
>> to rewrite a driver potentially.
>
> This binding doesn't do anything to move towards that goal given that
> the only information it includes about the contents of the chip is the
> name.

But it does not have to expose everything. And what will be your 
definition of everything in that case?

> Writing the name out in separate CODEC and vibra nodes really
> isn't going to accomplish much to promote reuse that can't trivially be
> achieved by parsing the name in the MFD driver.

Maybe, but... so what? This is not because you can do it with MFD that 
you cannot make it more flexible with DT.
Preferring to hard code that in MFD is similar to keeping all the static 
C board files we are all trying to remove. It is possible, sure, but 
there are now better way to describe HW modules than hard-coding that in 
a C file.

Moreover, there is not an unique way to describe the HW. So for sure we 
will cheat a little bit and make some assumption about what the SW will 
really use. But otherwise you will end up putting the full RTL inside 
the DT node.
It is very similar to the discussion we had for the clock tree. For sure 
we can describe the full clock tree in DT, but that's huge and useless. 
So we are taking some assumption and expose only the ones that have to 
be exposed because dependent of the board or needed by the devices.

> If the binding were doing things like describing the internals of the
> device in a way that meant the driver didn't need to know that this was
> a twl6040 in particular this sort of thinking is useful but the binding
> we have here just isn't doing that at all.
>
>> Both Vibra and Codec IPs can be located elsewhere, so by exposing
>> that inside the DT, you will increase the level of HW details and
>> thus make the re-use of these sub-IPs easier.
>
> Especially for the CODEC it's not really an IP in itself, it's an
> assembly of large numbers of other IPs - digital audio interfaces,
> analogue amps and whatnot.  Like I say if the device tree described
> this assembly it'd be different but it's really not doing that.
>
>> Moreover, the fact the Linux implementation uses MFD to represent
>> that is irrelevant for the DT description. We should be able to use
>> whatever SW representation for this type of HW.
>
> This is precisely my point, what we're being presented with here is a
> device tree description of the particular way that Linux wants to
> understand this stuff rather than something that lets us learn about the
> chip internals.

As I said before; there is not a single way to describe that kind of HW. 
But still this description is perfectly valid for the HW point of view. 
It just does not represent all the details inside the CODEC. But the way 
DT is done, nothing can prevent someone else to add further details 
below that node assuming there will be some SW to use that at some point.

It is up to the driver owner to assess the level of information he'd 
like to expose to DT based on the number of chip variants that already 
exist.

So far, MFD was the only way to describe some HW hierarchy in a SoC that 
only have platform_device.
Now, DT can do that as well without hard coding some sub device 
information inside a driver, thus allowing you to change that sub-device 
without changing the driver.

Both formats are valid.
It is just a matter of flexibility / personal choice / mood of the day.

The important point is that this is not a black or white kind of 
decision, we can be in the grey area and use a little bit of both approach.

Thanks,
Benoit
