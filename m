From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 20:01:22 +0100
Message-ID: <2417485.xV8Ic1G59x@flatron>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com> <1485256.GGQxcSNhvH@flatron> <alpine.DEB.2.10.1311131248290.28828@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.10.1311131248290.28828-QCF2GsvuTPME07tKKVU2gpqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Brian,

On Wednesday 13 of November 2013 12:58:28 Brian Austin wrote:
> >> +  - compatible : "cirrus,cs42l52"
> >> +
> >> +  - reg : the I2C address of the device for I2C
> >> +
> >> +Optional properties:
> >> +
> >> +  - reset-gpio : GPIO controller's phandle and the number
> >> +		 of the GPIO used to reset the codec.
> >
> > As Kumar has already mentioned, all device-specific properties should be
> > prefixed with vendor prefix, "cirrus," in this case.
> >
> 
> I can do that, Thanks
> 
> 
> >> +  - chgfreq    : Charge Pump Frequency values. Allowable values of
> >> +		 0x00 through 0x0F.
> >> +		 Frequency = (64xFs)/(N+2)
> >
> > I suppose N means the value of chgfreq property here, but this should be
> > clearly stated. Same for Fs - I suppose it is sampling frequency, but
> > is it default, minimum, maximum or maybe something else?
> >
> Frequency = (64xFs)/(N+2)
> N = chgfreq value
> Fs = sample rate

As I mentioned in second part of my comment, is it default, minimum,
maximum or what kind of sample rate? Or is the sample rate fixed?

> 
> 
> > Personally I don't like this kind of raw values being passed using Device
> > Tree, but this one can't be really represented reasonably in a generic
> > way (such as in Hz units) without too much effort to calculate original
> > value in the driver, then it's fine.
> >
> >> +  - mica-cfg   : MIC A single-ended or differential select.
> >> +		 0x00 = Single-Ended
> >> +		 0x01 = Differential
> >
> > I'd rather make it boolean and call it cirrus,mic-a-differential.
> >
> >> +  - micb-cfg   : MIC B single-ended or differential select.
> >> +		 0x00 = Single-Ended
> >> +		 0x01 = Differential
> >
> > Ditto.
> >
> 
> I can do that as well. Thanks
> 
> >> +  - mica-sel   : MIC A single ended input select.  For Single-Ended
> >> +		 configuration, select which MIC to use.
> >> +		 0x00 = MIC1
> >> +		 0x01 = MIC2
> >> +  - micb-sel   : MIC B single ended input select.  For Single-Ended
> >> +		 configuration, select which MIC to use.
> >> +		 0x00 = MIC1
> >> +		 0x01 = MIC2
> >
> > Could you explain what are MIC A, MIC B, MIC1 and MIC2?
> >
> I can add a little more but it is best explained in the datasheet. I can 
> add a little more explaination and reference the datasheet section. I feel 
> this file might be the wrong place to go into too much depth of the pieces 
> of the device when the datasheet could be referenced. Would a reference be 
> OK?
> 

I meant just explaining to me, for the purpose of this review. However it
seems like the datasheet is publicly available, so let me just check this
there.

> 
> >> +  - micbias-lvl: Set the output voltage level on the MICBIAS Pin
> >> +		 0x00 = 0.5 x VA
> >> +		 0x01 = 0.6 x VA
> >> +		 0x02 = 0.7 x VA
> >> +		 0x03 = 0.8 x VA
> >> +		 0x04 = 0.83 x VA
> >> +		 0x05 = 0.91 x VA
> >
> > For such small range of values, decimal representation is preferred from
> > readability reasons.
> >
> OK, Thanks
> >> +
> >> +Example:
> >> +
> >> +codec: cs42l52@4a {
> >
> > coding style: Node name should be generic, i.e. codec@4a.
> 
> I can change this as well.  While we are talking about coding style, is 
> there a new format document somewhere with the style that was agreed to at 
> the conference just recently?

I believe that the latest document is in the works, but as for style
guidelines, most of recommendations are to be taken from ePAPR[1].

[1] https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf

Best regards,
Tomasz

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
