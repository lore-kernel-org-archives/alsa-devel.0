From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as
 deprecated
Date: Tue, 20 Mar 2018 19:08:48 +0100
Message-ID: <248b81f5-adb2-a8cb-75a0-960bfaab89cc@samsung.com>
References: <CGME20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8@epcas1p1.samsung.com>
        <20180318153512.8343-1-krzk@kernel.org>
        <9bb639c3-f4e9-3a1e-61e8-a34fcfd0a344@samsung.com>
        <CAJKOXPcBesWpBoq07XbE1j3F1_N5dAWMTRkv8SN=tSMEm1q0iQ@mail.gmail.com>
        <12dfaefb-fd79-7a1d-2676-307d4e28b7e1@samsung.com>
        <CAJKOXPe1_g3XoVSorXRAsLB532TCxoSi-GAgm5Ve9-PxkM3OKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJKOXPe1_g3XoVSorXRAsLB532TCxoSi-GAgm5Ve9-PxkM3OKw@mail.gmail.com>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/20/2018 08:11 AM, Krzysztof Kozlowski wrote:
> On Mon, Mar 19, 2018 at 4:14 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 03/19/2018 11:56 AM, Krzysztof Kozlowski wrote:
>>> On Mon, Mar 19, 2018 at 11:29 AM, Sylwester Nawrocki
>>> <s.nawrocki@samsung.com> wrote:
>>>> On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:

>>> The compatible does not describe physical differences. It does not
>>> mean that devices are the same. In this case they are just coming from
>>> the same family and they operate the same, from the bindings
>>> perspective.
>>
>> From the ePAPR 'compatible' string definition you cited, the compatible
>> string is supposed to indicate programming model of a device, for the purpose
>> of matching a driver.
> 
> Yes, you're correct, it refers to programming model. Although later
> you will find second explanation (chapter 4): "The compatible property
> of a device node describes the specific binding (or bindings) to which
> the node complies.".

Yes, I'm aware of that.
>> I thought the programming model refers to the driver's
>> SW interfaces used to control the hardware, rather than only to a particular
>> DT binding design. And XU4 is not compatible with XU3 from device programming
>> perspective.
> 
> The programming models of XU4 and XU3 audio components, to which we
> refer now and which are implemented/used, are the same. I mean not the
> same in general, but how we use them. The used subset of each is the
> same. Therefore the binding and the driver do not distinguish any
> differences (like codec).
 
Actually the driver has to determine the number of codecs, as one of them 
requires additional configuration steps. But this is currently being taken
care of by looking at number of entries in one of the properties.

>>> The XU4 binding is not being used. Adding a compatible which is not
>>> used in the moment of adding is a proof that this compatible is not
>>> needed. It is just a duplicate. There is no point of adding
>>> duplicates.
>>
>> I disagree it is just an unnecessary duplicate, I think dts for XU4 could
>> fixed instead of dropping that compatible from the binding.
> 
> You know, there is nothing to fix - changing the compatible to XU4
> will not change anything. The executed code will be exactly the
> same...

Right, there is really no need now for another compatible as the 
differences across boards are handled through additional properties. 

>>>> So I think we should keep at least these 2 compatible strings:
>>>>
>>>> - "hardkernel,odroid-xu3-audio" - for boards with audio CODEC,
>>>> - "hardkernel,odroid-xu4-audio" - for boards without audio CODEC,
>>>>    supporting only HDMI interface.
>>>
>>> Yeah, and then we inflate this list into X, X2, U3, HC1 and all others
>>> which are the same. And then we should add XU3-lite (it is different
>>> device). This goes to some nonsense. Compatible is not for each device
>>> but for family even though there are differences between specific
>>> devices.
>>
>> You are not listening, I refer only to major audio subsystem differences.
>> It would have been:
>>
>>  - "hardkernel,odroid-xu3-audio" for: U2, U3, X, X2, XU, XU3, XU3-Lite
>>  - "hardkernel,odroid-xu4-audio" for: XU4
>>
>> But if you insist on only one compatible I'm not going to argue further,
>> you will be responsible for this. :)
> 
> Ah, I read too fast and missed that point. Actually that is nice
> consensus in this case.

As Mark said, it is not essential what we decide here, my preference was 
to keep these 2 compatibles. I might got confused a bit and did not consider
a more feature complete "hardkernel,odroid-xu3-audio" binding being applied 
to a XU4 device supporting only a subset of functionality.

-- 
Regards,
Sylwester
