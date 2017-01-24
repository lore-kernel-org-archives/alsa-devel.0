From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v4 0/4] Add support for es8388 and hdmi audio on the rock2
Date: Tue, 24 Jan 2017 09:09:02 +0100
Message-ID: <3f39ed38-309f-2e79-bd00-21ff367c83b5@collabora.com>
References: <20170123104149.2508-1-romain.perier@collabora.com>
 <20170123175451.hwvuum4ismutrbsf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170123175451.hwvuum4ismutrbsf-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Le 23/01/2017 à 18:54, Mark Brown a écrit :
> On Mon, Jan 23, 2017 at 11:41:45AM +0100, Romain Perier wrote:
>
>> Changes in v4:
>>  - Add support for multi codecs in the asoc machine driver, so the driver
>>    matches the hw architecture (analog and hdmi audio are connected on
>>    the same i2s line)
>>  - Renamed the driver to rk3288-hdmi-analog.c and changed its
>>    documentation
>>  - Add built-in support for hdmi audio in this driver
>>  - Add support for the property 'rockchip,routing'
> This is the first version that has been sumbitted upstream.
No this is the 4th, I have just re-worded the title :
-
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-January/116702.html

Not sure that you was in Cc: for the previous ones (whoops?)

Romain
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
