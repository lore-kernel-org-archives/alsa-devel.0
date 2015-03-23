From: Howard Mitchell <hm-n6SlHCM0l+K9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] ASoC:pcm512x: Make PLL lock output selectable via device
 tree.
Date: Mon, 23 Mar 2015 19:15:47 +0000
Message-ID: <55106663.5060802@hmbedded.co.uk>
References: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk> <20150322162409.GG6643@sirena.org.uk> <550FE05F.6070204@hmbedded.co.uk> <105aef6a0e21488d8661d2a2823515d8@EMAIL.axentia.se> <20150323165621.GH14954@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150323165621.GH14954-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 23/03/15 16:56, Mark Brown wrote:
> On Mon, Mar 23, 2015 at 11:00:53AM +0000, Peter Rosin wrote:
>
>> Strongly agreed that we should fix this before it is published (I assumed
>> that is was included in 3.19, it felt so long ago that Mark merged it...). My
>> preference would be to remove the pll-lock things entirely though. Assuming
>> you don't need it for your board of course, but I doubt it from your description.
>> I used it to make sure I had understood the chip correctly, that's all.
> It didn't make v3.19 so if we're very quick we can get this in as a fix.
> Can someone resend a version which splits this into two patches, one
> deleting the existing code to configure GPIO 4 and the other adding the
> configurability?  I can then send the removal as a bug fix to v4.0 so we
> don't have any compatibility issues and add the new feature for v4.1.
Ok, will do, although it seems that both Peter and I agree that the 
configurability is not required, so I'll just submit a patch for the 
deletion.

- Howard
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
