From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 10:21:10 -0600
Message-ID: <alpine.DEB.2.10.1311131019180.28828@heelrod.ad.cirrus.com>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com> <1384357474-28653-2-git-send-email-brian.austin@cirrus.com> <9097292C-9233-49B3-995D-27574D544237@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9097292C-9233-49B3-995D-27574D544237-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

>> +Required properties:
>> +
>> +  - compatible : "cirrus,cs42l52"
>> +
>> +  - reg : the I2C address of the device for I2C
>> +
>> +Optional properties:
>> +
>> +  - reset-gpio : GPIO controller's phandle and the number
>> +		 of the GPIO used to reset the codec.
>> +  - chgfreq    : Charge Pump Frequency values. Allowable values of
>> +		 0x00 through 0x0F.
>> +		 Frequency = (64xFs)/(N+2)
>> +  - mica-cfg   : MIC A single-ended or differential select.
>> +		 0x00 = Single-Ended
>> +		 0x01 = Differential
>> +  - micb-cfg   : MIC B single-ended or differential select.
>> +		 0x00 = Single-Ended
>> +		 0x01 = Differential
>> +  - mica-sel   : MIC A single ended input select.  For Single-Ended
>> +		 configuration, select which MIC to use.
>> +		 0x00 = MIC1
>> +		 0x01 = MIC2
>> +  - micb-sel   : MIC B single ended input select.  For Single-Ended
>> +		 configuration, select which MIC to use.
>> +		 0x00 = MIC1
>> +		 0x01 = MIC2
>> +  - micbias-lvl: Set the output voltage level on the MICBIAS Pin
>> +		 0x00 = 0.5 x VA
>> +		 0x01 = 0.6 x VA
>> +		 0x02 = 0.7 x VA
>> +		 0x03 = 0.8 x VA
>> +		 0x04 = 0.83 x VA
>> +		 0x05 = 0.91 x VA
>
> these properties should be cirrus, prefixed.
>

This is for a Cirrus CODEC, not related to the Cirrus ARM9. I didn't think 
we would prefix for a binding on a codec. I thought that was only for 
SOC/Platforms


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
