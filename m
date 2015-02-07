From: yakir <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 05/15] drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n()
 and hdmi_regenerate_cts()
Date: Sat, 07 Feb 2015 11:33:17 +0800
Message-ID: <54D5877D.1070500@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com> <1422976340-30118-1-git-send-email-ykk@rock-chips.com> <CAGS+omC_vWBdoWvzy96A5kFOKEeqaKRcPzNhNc20--+MoAPHyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omC_vWBdoWvzy96A5kFOKEeqaKRcPzNhNc20--+MoAPHyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, open list:OPEN FIRMW
List-Id: alsa-devel@alsa-project.org


On 02/05/2015 11:54 PM, Daniel Kurtz wrote:
> On Tue, Feb 3, 2015 at 11:12 PM, Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> Signed-off-by: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Okay, add in next verson4.

Thanks.  : )
>
>> ---
>> Changes in v3:
>> - Combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
>>
>> Changes in v2: None
>>
>>   drivers/gpu/drm/bridge/dw_hdmi.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
>> index 7b5b664..262163f 100644
>> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
>> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
>> @@ -196,19 +196,16 @@ static void hdmi_mask_writeb(struct dw_hdmi *hdmi, u8 data, unsigned int reg,
>>          hdmi_modb(hdmi, data << shift, mask, reg);
>>   }
>>
>> -static void hdmi_set_clock_regenerator_n(struct dw_hdmi *hdmi,
>> -                                        unsigned int value)
>> +static void hdmi_set_clock_regenerator(struct dw_hdmi *hdmi,
>> +                                      unsigned int n, unsigned int cts)
>>   {
>> -       hdmi_writeb(hdmi, value & 0xff, HDMI_AUD_N1);
>> -       hdmi_writeb(hdmi, (value >> 8) & 0xff, HDMI_AUD_N2);
>> -       hdmi_writeb(hdmi, (value >> 16) & 0x0f, HDMI_AUD_N3);
>> +       hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
>> +       hdmi_writeb(hdmi, (n >> 8) & 0xff, HDMI_AUD_N2);
>> +       hdmi_writeb(hdmi, (n >> 16) & 0x0f, HDMI_AUD_N3);
>>
>>          /* nshift factor = 0 */
>>          hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
>> -}
>>
>> -static void hdmi_regenerate_cts(struct dw_hdmi *hdmi, unsigned int cts)
>> -{
>>          /* Must be set/cleared first */
>>          hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
>>
>> @@ -374,8 +371,7 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>>                  __func__, hdmi->sample_rate, hdmi->ratio,
>>                  pixel_clk, clk_n, clk_cts);
>>
>> -       hdmi_set_clock_regenerator_n(hdmi, clk_n);
>> -       hdmi_regenerate_cts(hdmi, clk_cts);
>> +       hdmi_set_clock_regenerator(hdmi, clk_n, clk_cts);
>>   }
>>
>>   static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
>> --
>> 2.1.2
>>
>>
>
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
