From: Simran Rai <simran.rai-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH resend v5 1/3] ASoC: cygnus: Add DT bindings for Broadcom
 Cygnus audio
Date: Thu, 31 Mar 2016 11:14:53 -0700
Message-ID: <CAES42Na+wM6P5yB3tg+bxk88txQA+52kgL8uwFqEW1XO8LfUeQ@mail.gmail.com>
References: <1459277192-10942-1-git-send-email-simran.rai@broadcom.com>
 <1459277192-10942-2-git-send-email-simran.rai@broadcom.com> <20160331141308.GA9670@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160331141308.GA9670@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arun Parameswaran <arunp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Rob,

On Thu, Mar 31, 2016 at 7:13 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Mar 29, 2016 at 11:46:30AM -0700, Simran Rai wrote:
>> From: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>>
>> Add bindings for audio driver in Broadcom Cygnus.
>>
>> Signed-off-by: Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Simran Rai <simran.rai-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>  .../bindings/sound/brcm,cygnus-audio.txt           |   67 ++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
>
> I acked v3 of this already. Did something change? If not, please add
> acks when sending new versions. If things did change, explain that here.
There was a change made in v4 that introduced assigned-clocks,
assigned-clock-parents, and assigned-clock-rates, to allow initial
configuration of
default parent clock and its frequency.
>
> And this v5 is not a resend if you didn't already send out v5 before.
I had sent out v5 on March 01 but looks like it did not make it to
through. Yesterday I sent out another patch (v6) to address Mark's
comments. Can you please ack PATCH v6.

Thanks,
Simran
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
