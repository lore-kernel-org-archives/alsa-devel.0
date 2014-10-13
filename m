From: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] audio: sgtl5000: Add MicBias resistor
 support in DT
Date: Mon, 13 Oct 2014 07:46:53 +0200
Message-ID: <CAL8zT=hXxRz0OfAN1vsE2BTiQKONdtQV6so5JpSsOLV=f6_EFA@mail.gmail.com>
References: <1413139149-2485-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <CAOMZO5BtUPkrpaXtupeLpeng4bPAiZeMZuJdmxx1RoPWhJ874w@mail.gmail.com>
 <CAL8zT=hKgMYVCHr2x90imRD1eBvsjXZ+subrVmBh0YX-E3Fscw@mail.gmail.com> <CAOMZO5C+20UWCOFRD033y+MEWd-DUBJ15AejBEFxSzn5otySnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5C+20UWCOFRD033y+MEWd-DUBJ15AejBEFxSzn5otySnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

2014-10-13 0:39 GMT+02:00 Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi Jean-Michel,
>
> On Sun, Oct 12, 2014 at 6:42 PM, Jean-Michel Hautbois
> <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org> wrote:
>
>> You are right of course, second version sent. I have a patch wich adds
>> MicBias voltage support too, but it will be on top of this one, is
>> this a problem ?
>
> In this case you could send a series of two patches: PATCH v3 1/2 and
> PATCH v3 2/2

I am using a "big" enum of 8 values, but there may be a nicer way to do it.
In the datasheet it is said that MICBIAS_VOLT is set in 250mV steps,
from 1.25V when register is 0 to 3.00V when register is 7.

Thanks,
JM
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
