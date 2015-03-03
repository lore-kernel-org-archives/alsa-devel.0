From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: simple-card: Add support for samplerate
 and samplewidth constraints
Date: Tue, 3 Mar 2015 14:00:31 +0200
Message-ID: <54F5A25F.6090904@ti.com>
References: <cover.1425303942.git.jsarha@ti.com> <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com> <54F4C0F2.8000201@metafoo.de> <54F5884A.1090702@ti.com> <20150303113041.GM21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150303113041.GM21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 03/03/2015 01:30 PM, Mark Brown wrote:
> On Tue, Mar 03, 2015 at 12:09:14PM +0200, Jyri Sarha wrote:
>> On 03/02/2015 09:58 PM, Lars-Peter Clausen wrote:
>
>>> Can you include a description why this is needed and how and when it is
>>> supposed to be used?
>
>> Would this addition do:
>> ------------------------------------------------------------
>> These constraints help to disable the sample-format and sample-rate
>> combinations that do not properly work on a specific HW.
>> ------------------------------------------------------------
>
> Not entirely...
>
>> The reason why we need these is coming from limitations in McASP clock
>> generation. With a simple divider one can only produce certain bit-clocks.
>> With those bit-clocks we can only play/capture some sample-rate and
>> sample-width combinations accurately.
>
>> The McASP driver could try to set the constraints automatically. However,
>> since the constraint code can not select sample-width and sample-rate
>> combinations there is a compromise to be made between them. Making such
>> compromises automatically does not usually work that well.
>
> ...this is more the point.  Perhaps the constraints language needs
> improvement here?
>

Improving constraint functionality would certainly help, however the way 
that code works is beyond my understanding and I do not believe such an 
improvement would be coming from anybody else any time soon either.

>> In our case these properties could of course be added to McASP driver, but
>> then again I would expect that there is a wider need for this kind of
>> functionality. And it may not always be clear if either end of the link
>> alone is responsible for less than perfect operation.
>
> The trouble with this sort of interface is that it's a quick and dirty
> way for people to bodge around things rather than actually fixing them
> properly.  Of course sometimes fixing things properly is really hard and
> that means we want a temporary bodge but having to put them in DT is
> really unfortunate.
>

I agree with that. However, the simple-card binding goes already now 
quite a bit beyond just describing the hardware. The binding for 
instance decides the configuration that is going to be used over the 
dai-link. These constraints could be seen as an extension to that 
configuration.

I am wondering if there would be some better way to select the dai-link 
configuration than writing it to DT or creating a custom machine driver 
for each setup.

But about this patch. Should I just give it up, or would you be willing 
to apply it if I improve the description more and add a warning against 
using these properties to work around driver bugs to the binding document?

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
