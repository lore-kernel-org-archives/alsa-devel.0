From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
Date: Fri, 19 May 2017 07:35:39 -0500
Message-ID: <CAL_JsqJpcR0P03nixJqVHLhbVuuWAogx9YJSK4Gf4=01t8yfDw@mail.gmail.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-10-romain.perier@collabora.com> <20170515214138.u63u7j53jogk3prm@rob-hp-laptop>
 <20170516111837.3uf5f5jbdkrnjudi@sirena.org.uk> <a052da20-d9c7-69f5-21d9-9111d45702e6@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a052da20-d9c7-69f5-21d9-9111d45702e6-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 19, 2017 at 1:56 AM, Romain Perier
<romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> Hello,
>
>
> Le 16/05/2017 à 13:18, Mark Brown a écrit :
>> On Mon, May 15, 2017 at 04:41:38PM -0500, Rob Herring wrote:
>>> On Fri, May 12, 2017 at 03:22:25PM +0200, Romain Perier wrote:
>>>> This commit adds a compatible string for everest,es8323. This is an
>>>> audio codec that is compatible with es8328 and can be found for example
>>>> on the Firefly-RK3288 board.
>>> If it is compatible with the es8328, then that should be a fallback and
>>> you don't need the driver change.
>> While people don't strictly need the driver change it doesn't do any
>> harm either and encourages people to get the information into the DT
>> that it's a different chip.  Thinking about it it might be good to have
>> a way for something to validate if fallback compatibles are being listed
>> when they should - the drivers could provide the information fairly
>> easily I guess, or it could go into the binding docs once we have a
>> schema format.
>>
>> Even if it doesn't currently make a difference to software I'd rather
>> get the information in there for mixed signal devices like audio CODECs
>> - it's not that unknown to find later that supposedly register identical
>> chips have some differences in the analog which we want to care about.
> So, what should I do for this patch, finally ? fallback or driver change ?

Well, you could do both. However, there's not much point if you do the
driver change. So:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
