From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 12:58:28 -0600
Message-ID: <alpine.DEB.2.10.1311131248290.28828@heelrod.ad.cirrus.com>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com>
 <1384357474-28653-2-git-send-email-brian.austin@cirrus.com>
 <1485256.GGQxcSNhvH@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB252602F3
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 19:55:41 +0100 (CET)
In-Reply-To: <1485256.GGQxcSNhvH@flatron>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, rob.herring@calxeda.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

>> +  - compatible : "cirrus,cs42l52"
>> +
>> +  - reg : the I2C address of the device for I2C
>> +
>> +Optional properties:
>> +
>> +  - reset-gpio : GPIO controller's phandle and the number
>> +		 of the GPIO used to reset the codec.
>
> As Kumar has already mentioned, all device-specific properties should be
> prefixed with vendor prefix, "cirrus," in this case.
>

I can do that, Thanks


>> +  - chgfreq    : Charge Pump Frequency values. Allowable values of
>> +		 0x00 through 0x0F.
>> +		 Frequency = (64xFs)/(N+2)
>
> I suppose N means the value of chgfreq property here, but this should be
> clearly stated. Same for Fs - I suppose it is sampling frequency, but
> is it default, minimum, maximum or maybe something else?
>
Frequency = (64xFs)/(N+2)
N = chgfreq value
Fs = sample rate


> Personally I don't like this kind of raw values being passed using Device
> Tree, but this one can't be really represented reasonably in a generic
> way (such as in Hz units) without too much effort to calculate original
> value in the driver, then it's fine.
>
>> +  - mica-cfg   : MIC A single-ended or differential select.
>> +		 0x00 = Single-Ended
>> +		 0x01 = Differential
>
> I'd rather make it boolean and call it cirrus,mic-a-differential.
>
>> +  - micb-cfg   : MIC B single-ended or differential select.
>> +		 0x00 = Single-Ended
>> +		 0x01 = Differential
>
> Ditto.
>

I can do that as well. Thanks

>> +  - mica-sel   : MIC A single ended input select.  For Single-Ended
>> +		 configuration, select which MIC to use.
>> +		 0x00 = MIC1
>> +		 0x01 = MIC2
>> +  - micb-sel   : MIC B single ended input select.  For Single-Ended
>> +		 configuration, select which MIC to use.
>> +		 0x00 = MIC1
>> +		 0x01 = MIC2
>
> Could you explain what are MIC A, MIC B, MIC1 and MIC2?
>
I can add a little more but it is best explained in the datasheet. I can 
add a little more explaination and reference the datasheet section. I feel 
this file might be the wrong place to go into too much depth of the pieces 
of the device when the datasheet could be referenced. Would a reference be 
OK?


>> +  - micbias-lvl: Set the output voltage level on the MICBIAS Pin
>> +		 0x00 = 0.5 x VA
>> +		 0x01 = 0.6 x VA
>> +		 0x02 = 0.7 x VA
>> +		 0x03 = 0.8 x VA
>> +		 0x04 = 0.83 x VA
>> +		 0x05 = 0.91 x VA
>
> For such small range of values, decimal representation is preferred from
> readability reasons.
>
OK, Thanks
>> +
>> +Example:
>> +
>> +codec: cs42l52@4a {
>
> coding style: Node name should be generic, i.e. codec@4a.

I can change this as well.  While we are talking about coding style, is 
there a new format document somewhere with the style that was agreed to at 
the conference just recently?

Thanks,
Brian
