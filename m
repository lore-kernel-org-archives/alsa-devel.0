From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
Date: Sat, 20 Feb 2016 19:22:04 +0100
Message-ID: <871t87z1gz.fsf@belgarion.home>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
	<20160220171459.GA18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160220171459.GA18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Sun, 21 Feb 2016 02:14:59 +0900")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Sat, Feb 20, 2016 at 03:37:56PM +0100, Robert Jarzmik wrote:
>
>> +WM9713 audio CODEC
>> +
>> +This devices supports I2C.
>
> No, it clearly doesn't...
Right, it supports AC97.

> The problem with doing this is that since AC'97 is an enumerable bus we really
> shouldn't need to list AC'97 CODECs in the device tree.
Ok, I understand that.

> Instead we should be probing at runtime (as the non-ASoC AC'97 code does) or
> something similar.
When you say "non-ASoC AC'97 code", which file are you referring to ? Is it
sound/pci/ac97/ac97_codec.c ?

If so is there already a table of tuples (AC97_VENDOR_ID1, AC97_VENDOR_ID2) ->
(platform device, platform device data) and a matching mechanism already
available to the ASoC drivers ?

Cheers.

-- 
Robert
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
