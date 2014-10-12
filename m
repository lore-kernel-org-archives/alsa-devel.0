From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] audio: sgtl5000: Add MicBias resistor
 support in DT
Date: Sun, 12 Oct 2014 23:42:47 +0200
Message-ID: <CAL8zT=hKgMYVCHr2x90imRD1eBvsjXZ+subrVmBh0YX-E3Fscw@mail.gmail.com>
References: <1413139149-2485-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <CAOMZO5BtUPkrpaXtupeLpeng4bPAiZeMZuJdmxx1RoPWhJ874w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5BtUPkrpaXtupeLpeng4bPAiZeMZuJdmxx1RoPWhJ874w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

2014-10-12 23:15 GMT+02:00 Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Sun, Oct 12, 2014 at 3:39 PM, Jean-Michel Hautbois
> <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org> wrote:
>
>> +       if (np) {
>> +               if (!of_property_read_u32(np,
>> +                       "sgtl5000-micbias-resistor", &value)) {
>> +                       switch (value) {
>> +                       case 1:
>> +                               sgtl5000->micbias_resistor =
>> +                                       SGTL5000_MICBIAS_2K;
>> +                               break;
>> +                       case 2:
>> +                               sgtl5000->micbias_resistor =
>> +                                       SGTL5000_MICBIAS_4K;
>> +                               break;
>> +                       case 3:
>> +                               sgtl5000->micbias_resistor =
>> +                                       SGTL5000_MICBIAS_8K;
>> +                               break;
>> +                       default:
>> +                               sgtl5000->micbias_resistor =
>> +                                       SGTL5000_MICBIAS_OFF;
>> +                               dev_err(&client->dev,
>> +                                       "Unsuitable MicBias resistor\n");
>
> The case 0 should SGTL5000_MICBIAS_OFF and the default should be
> SGTL5000_MICBIAS_4K.

You are right of course, second version sent. I have a patch wich adds
MicBias voltage support too, but it will be on top of this one, is
this a problem ?

Thanks,
JM
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
