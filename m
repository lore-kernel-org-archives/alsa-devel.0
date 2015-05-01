From: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: Add gtm601 codec driver
Date: Fri, 1 May 2015 13:36:48 +0200
Message-ID: <CAAfyv36Bi_Em=PUUf1n0nk6AAR65QLzr_R2SenHs_C5Q3Ggjmg@mail.gmail.com>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
	<1430429283-27907-2-git-send-email-marek@goldelico.com>
	<20150501110311.GV22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150501110311.GV22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, May 1, 2015 at 1:03 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Apr 30, 2015 at 11:28:01PM +0200, Marek Belisko wrote:
>
>>       select SND_SOC_WM9705 if SND_SOC_AC97_BUS
>>       select SND_SOC_WM9712 if SND_SOC_AC97_BUS
>>       select SND_SOC_WM9713 if SND_SOC_AC97_BUS
>> +     select SND_SOC_GTM601
>>          help
>> +config SND_SOC_GTM601
>> +     tristate 'GTM601 UMTS modem audio codec'
>> +
>
> Keep Makefile and Kconfig sorted.
Ok.
>
>> +/*
>> + * Note this is a simple chip with no configuration interface, sample rate is
>> + * determined automatically by examining the Master clock and Bit clock ratios
>> + */
>
>> +#define GTM601_RATES  (SNDRV_PCM_RATE_8000)
>
> Does it or doesn't it support multiple sample rates?
It support only 8kHz rate. I'll remove define and use SNDRV_PCM_RATE_8000
only in gtm601_dai struct.

Thanks and BR.

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
