From: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ARM: dts: pbab01: enable I2S audio on phyFLEX-i.MX6
 boards
Date: Wed, 1 Oct 2014 16:40:17 +0300
Message-ID: <542C0441.5080508@sam-solutions.com>
References: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410854903-26419-3-git-send-email-d.lavnikevich@sam-solutions.com> <CAOMZO5CgrQ6Wf6kStga40TUKx9dARygCNB4OYSUoG3c8eUYbrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5CgrQ6Wf6kStga40TUKx9dARygCNB4OYSUoG3c8eUYbrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/10/14 15:11, Fabio Estevam wrote:
> On Tue, Sep 16, 2014 at 5:08 AM, Dmitry Lavnikevich
> <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org> wrote:
>
>> +       regulators {
>> +               sound_1v8: regulator@2 {
>
> We usually start counting from @0.
>
...
 >> +               };
 >> +
 >> +               sound_3v3: regulator@3 {
 >
 > ,so this one should be @1.

@0 and @1 are used for "usb_otg_vbus" and "usb_h1_vbus" regulators in 
dts for phyFLEX module (imx6qdl-phytec-pfla02.dtsi) which gets included 
before base board dts (imx6qdl-phytec-pbab01.dtsi)

>> +                       compatible = "regulator-fixed";
>> +                       reg = <2>;
>> +                       regulator-name = "i2s-audio-1v8";
>> +                       regulator-min-microvolt = <1800000>;
>> +                       regulator-max-microvolt = <1800000>;
>> +                       regulator-always-on;
>
> No need to have this 'regulator-always-on'
>
...
>> +                       compatible = "regulator-fixed";
>> +                       reg = <3>;
>> +                       regulator-name = "i2s-audio-3v3";
>> +                       regulator-min-microvolt = <3300000>;
>> +                       regulator-max-microvolt = <3300000>;
>> +                       regulator-always-on;
>
> No need to have this 'regulator-always-on'
>

why is there no need for 'regulator-alweys-on'? I see it in
similar fixed regulator descriptions in imx6qdl-sabrelite.dtsi,
imx6qdl-wandboard.dtsi, imx6qdl-nitrogen6x.dtsi and many other
boards.

>> +&ssi2 {
>> +       fsl,mode = "i2s-slave";
>
> Please remove this 'fsl,mode' property. It is ignored by the fsl_ssi driver.

yes, thanks. It is present in Documentation but now I see that it
was actually removed not that long ago. I will remove this
property with next patchset.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
