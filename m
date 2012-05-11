From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Fri, 11 May 2012 13:02:26 +0200
Message-ID: <4FACF1C2.7050008@ti.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120509133511.GQ3955-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

+ DT list

Hi Mark,

On 5/9/2012 3:35 PM, Mark Brown wrote:
> On Wed, May 09, 2012 at 03:01:23PM +0300, Peter Ujfalusi wrote:
>> On 05/08/2012 04:41 PM, Mark Brown wrote:
>>> On Tue, May 08, 2012 at 03:42:41PM +0300, Peter Ujfalusi wrote:
>
>>>> Also without a DT entry I will not have a way to use phandle to
>>>> connect the codec in the machine driver.
>
>>> Of course you do!  There's going to be a device tree entry for the
>>> chip, things can point at this perfectly happily.
>
>> That's true but what can I do with that in the ASoC machine driver?
>> The chip driver is _not_ the codec driver.
>
> This really doesn't seem like it should be at all hard to resolve...
>
>> I can craft the pdata for the MFD child devices out from the DT
>> information but then the child devices will have no dev.of_node since
>> they were not probed via OF.  So I would have not phandle for the
>> codec to be used to define the dai-link connection within the sound
>> dts section.
>
>> Am I missing something here?
>
> Clearly.  This is all very circular.  Obviously if you're intent on
> using a phandle specific to the MFD child then you need to have that in
> the device tree but this is because you're making the child devices
> externally visible...  Clearly if we're not going to use the MFD
> subdevices in the DT then the links ought to reference the chip.

I'm not sure to understand you concern here.

Describing sub nodes, especially for big SoC is pretty useful.
It is as useful as doing that for board that are sharing similar components.
It will allow to define several Audio / PMIC variants without having to 
rewrite a driver potentially.

DT is about HW description. You can go to whatever level you'd like as 
soon as it is relevant for the drivers.

In this is case it is relevant since the sub-devices will have driver to 
be bound to the device nodes.

Both Vibra and Codec IPs can be located elsewhere, so by exposing that 
inside the DT, you will increase the level of HW details and thus make 
the re-use of these sub-IPs easier.

The twl6040 is just a container. These IPs can be inside a PCI chip, or 
inside OMAP or whatever, but they do need a node to represent them. In 
this case the container is irrelevant, only the children matter.

Moreover, the fact the Linux implementation uses MFD to represent that 
is irrelevant for the DT description. We should be able to use whatever 
SW representation for this type of HW.

DT was useful to get rid of static board definition. DT can be useful as 
well to get rid of the static cell definition inside a MFD.
This is exactly the same problem at different HW level.

Regards,
Benoit
