From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v1 2/2] dt-bindings: sound: add devicetree document for
 rt5616
Date: Tue, 22 Dec 2015 08:54:11 +0800
Message-ID: <56789F33.1010803@rock-chips.com>
References: <1450703894-32623-2-git-send-email-wxt@rock-chips.com>
 <1450709768-14898-1-git-send-email-wxt@rock-chips.com>
 <56786BF7.7070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56786BF7.7070608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi

=E5=9C=A8 2015=E5=B9=B412=E6=9C=8822=E6=97=A5 05:15, Frank Rowand =E5=86=
=99=E9=81=93:
> On 12/21/2015 6:56 AM, Caesar Wang wrote:
>> Add the description for rt5616 codec.
>>
>> Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>
>> ---
>>
>> Changes in v1:
>> - As Heiko comments, remove the not exist option properties.
>>
>>   Documentation/devicetree/bindings/sound/rt5616.txt | 36 ++++++++++=
++++++++++++
>>   1 file changed, 36 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/rt5616.=
txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Do=
cumentation/devicetree/bindings/sound/rt5616.txt
>> new file mode 100644
>> index 0000000..2030a22
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/rt5616.txt
>> @@ -0,0 +1,36 @@
>> +RT5616 audio CODEC
>> +
>> +This device supports I2C only.
>> +
>> +Required properties:
>> +
>> +- compatible : "realtek,rt5616".
>> +
>> +- reg : The I2C address of the device.
>> +
>> +Pins on the device (for linking into audio routes) for RT5616:
>> +
>> +  * IN1P
>> +  * IN2P
>> +  * IN2N
>> +  * LOUTL
>> +  * LOUTR
>> +  * CPN2
>> +  * CPP2
>> +  * CPN1
>> +  * CPP1
>> +  * HPO_R
>> +  * HPO_L
>> +  * ADCDAT1
>> +  * DACDAT1
>> +  * LRCK1
>> +  * BCLK1
>> +  * MCLK
>> +  * GPIO1
>> +
>> +Example:
>> +
>> +rt5616 {
> The node name should be rt5616@1b (including the reg value
> from the node).

In general, that's right.

Okay, fixed in next version.


>
>> +	compatible =3D "realtek,rt5616";
>> +	reg =3D <0x1b>;
>> +};
>>
>
>
>

--=20
caesar wang | software engineer | wxt-TNX95d0MmH73oGB3hsPCZA@public.gmane.org


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
