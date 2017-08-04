From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH RESEND v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
Date: Fri, 4 Aug 2017 08:44:32 +0200
Message-ID: <0febe9b7-724a-78fa-6ced-ec0874c5488f@collabora.com>
References: <20170726135526.475-1-romain.perier@collabora.com>
 <20170726135526.475-10-romain.perier@collabora.com>
 <20170803190116.wo6siwstbkzd4ph7@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170803190116.wo6siwstbkzd4ph7@rob-hp-laptop>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org



Le 03/08/2017 à 21:01, Rob Herring a écrit :
> On Wed, Jul 26, 2017 at 03:55:24PM +0200, Romain Perier wrote:
>> This commit adds a compatible string for everest,es8323. This is an
>> audio codec that is compatible with es8328 and can be found for example
>> on the Firefly-RK3288 board.
>>
>> Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/sound/es8328.txt | 5 ++++-
>>  sound/soc/codecs/es8328-i2c.c                      | 2 ++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
> I acked the previous v3 at the end of the discussion. Please add acks 
> when posting new versions.
>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Rob

My bad! Thanks

Romain
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
