From: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Fri, 15 Jan 2016 13:51:48 -0600
Message-ID: <CAOZdJXXF016K38drSrFiLsvmRys_VeVzTaxxGVqWjeFKrQEbCw@mail.gmail.com>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
	<20160114201858.GA17567@Asurada-Nvidia>
	<56984BE7.2050303@tabi.org>
	<20160115131325.GW6588@sirena.org.uk>
	<5698F846.5080604@tabi.org>
	<CAG5mAdy553q4Te5755575WaiLxGRp43h=WVH6QzF7idsaCnhbg@mail.gmail.com>
	<20160115183824.GB31703@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160115183824.GB31703@Asurada-Nvidia>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Caleb Crome <caleb-EebDDntmC0DYtjvyW6yDsg@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Xiubo Li <Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 12:38 PM, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> If nobody objects, we can just set the value to 4 and be done with it.
>
> I agree. And we may apply it only to i.MX platforms with DMA if
> other platform owners feel comfortable with the previous settings.

It's imperative that the PowerPC chips continue to use whatever
setting they're using now.  It took a long time for me to find values
that actually work on those chips, and I don't want to have to re-test
the driver on hardware that I don't have any more.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
