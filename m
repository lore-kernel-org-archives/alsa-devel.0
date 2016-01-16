From: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Sat, 16 Jan 2016 08:15:33 -0600
Message-ID: <569A5085.10806@tabi.org>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia> <56984BE7.2050303@tabi.org>
 <20160115131325.GW6588@sirena.org.uk> <5698F846.5080604@tabi.org>
 <CAG5mAdy553q4Te5755575WaiLxGRp43h=WVH6QzF7idsaCnhbg@mail.gmail.com>
 <20160115183824.GB31703@Asurada-Nvidia>
 <CAG5mAdyXPtnnZvGcWrhhbv7wuamz_xbRsn76VXdbE1yZRgx_Mg@mail.gmail.com>
 <20160115185736.GC31703@Asurada-Nvidia>
 <CAG5mAdyUfSuCqA4_342MS2AyshvuyeiYsjQyRqifmqVhn4T2xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAG5mAdyUfSuCqA4_342MS2AyshvuyeiYsjQyRqifmqVhn4T2xA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Caleb Crome <caleb-EebDDntmC0DYtjvyW6yDsg@public.gmane.org>, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Xiubo Li <Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Caleb Crome wrote:
> I see the 4 compatibles are:  fsl,mpc8610-ssi, fsl,imx51-ssi,
> fsl,imx35-ssi, and fsl,imx21-ssi.
>
> Shall I submit a patch that sets the value to 4 for for any/all of the
> above?  Should it be different based on whether fiq is enabled.  Maybe
> set it to 4 for whenever DMA is used, and to 13 whenever FIQ is used?

Do NOT change the watermark value for fsl,mpc8610-ssi from whatever it 
is today.  You would need to retest your code on an mpc8610 and p1022ds, 
and I don't think you have either of those boards.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
