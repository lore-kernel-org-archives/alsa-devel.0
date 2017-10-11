From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [alsa-devel] [Patch v6 2/7] slimbus: Add messaging APIs to
 slimbus framework
Date: Wed, 11 Oct 2017 09:53:09 +0200
Message-ID: <CAK8P3a2T+7_dVmWcdYhV85Mm-evzsMFf9RAo=GAvNGMfqWOxKw@mail.gmail.com>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org> <20171011043814.GF30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171011043814.GF30097@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dani
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 6:38 AM, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> +     ctrl->pending_wr = kcalloc((ctrl->tx.n - 1),
>> +                                sizeof(struct slim_pending),
>> +                                GFP_KERNEL);
>> +     if (!ctrl->pending_wr) {
>> +             ret = -ENOMEM;
>> +             goto wr_alloc_failed;
>> +     }
>> +
>> +     sema_init(&ctrl->tx_sem, (ctrl->tx.n - 1));
>
> i though v5 comment from Arnd was not to use semaphores..

Right, these need to go away. Thanks for spotting it!

     Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
