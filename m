From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] Documentation: dt: bindings: sound: Add bindings
 for CS35L32
Date: Tue, 05 Aug 2014 20:06:22 +0530
Message-ID: <53E0EBE6.9050407@gmail.com>
References: <1407183077-23807-1-git-send-email-brian.austin@cirrus.com> <1407183077-23807-2-git-send-email-brian.austin@cirrus.com> <53E05737.3000601@gmail.com> <alpine.DEB.2.02.1408050926260.7394@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1408050926260.7394@heelrod>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


On Tuesday 05 August 2014 07:58 PM, Brian Austin wrote:
> On Mon, 4 Aug 2014, Varka Bhadram wrote:
>>> +  0 = Left/right channels VMON[11:0], IMON[11:0], VPMON[7:0].
>>> +  1 = Left/right channels VMON[11:0], IMON[11:0], STATUS.
>>> +  2 = (Default) left/right channels VMON[15:0], IMON [15:0].
>>> +  3 = Left/right channels VPMON[7:0], STATUS.
>>> +
>>> +  - cirrus,sdout-share : SDOUT sharing. Determines whether one or two
>>> CS35L32
>>> +  devices are on board sharing SDOUT.
>>> +  0 = (Default) One IC.
>>> +  1 = Two IC's.
>>> +
>>> +  - cirrus,battery-recovery : Low battery nominal recovery threshold,
>>> rising VP.
>>> +  0 = 3.1V
>>> +  1 = 3.2V
>>> +  2 = 3.3V (Default)
>>> +  3 = 3.4V
>>> +
>>> +  - cirrus,battery-threshold : Low battery nominal threshold, falling VP.
>>> +  0 = 3.1V
>>> +  1 = 3.2V
>>> +  2 = 3.3V
>>> +  3 = 3.4V (Default)
>>> +  4 = 3.5V
>>> +  5 = 3.6V
>>> +
>> Proper indentation for all the properties... These are not readable like
>> this...
>>
>> Required properties:
>>   - compatible:		"cirrus,cs35l32"
>>   - reg:			the I2C address of the device for I2C. Address is
>> determined by the level
>> 			of the AD0 pin. Level 0 is 0x40 while Level 1 is 0x41.
>>   - VA-supply,VP-supply:	power supplies for the device,
>> 			as covered in
>> Documentation/devicetree/bindings/regulator/regulator.txt.
>>
>> Optional properties:
>>   - reset-gpios:		a GPIO spec for the reset pin. If specified, it will
>> be
>> 			deasserted before communication to the codec starts.
>>   - cirrus,boost-manager:Boost voltage control.
>> 			0 = Automatically managed.
>> 				Boost-converter output voltage is the higher
>> 				of the two: Class G or adaptive LED voltage.
>> 			1 = Automatically managed irrespective of audio,
>> adapting for low-power
>>
>> -- 
>> Regards,
>> Varka Bhadram.
>>
>>
> Well when I look at your example that makes it more difficult for me to
> read ;)

sorry... this the problem due to my email client...

> I think if there is a mandatory style we are looking for I would expect it
> to be documented. Maybe I have missed that? I take my bindings file from
> examples already in the mainline and find this to be acceptable and
> readable for me.
>
see this ex:http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/sound/adi,adau1701.txt

-- 
-Varka Bhadram

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
