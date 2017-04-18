From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [resend][PATCH v5 06/10] ASoC: soc-core: enable "dai-name" on snd_soc_of_parse_daifmt()
Date: Mon, 17 Apr 2017 19:05:32 -0500
Message-ID: <CAL_Jsq+D9FsL=JG+ZCm4H8VAh=fSOAJcN_30UZC36vgX8n9Dng@mail.gmail.com>
References: <87bmrvvqgs.wl%kuninori.morimoto.gx@renesas.com>
 <8737d7vqc4.wl%kuninori.morimoto.gx@renesas.com> <CAL_JsqLVM1mQWXv42N_hC+nTWV=dOaSc2wmu4SAAN3-w4O8v6w@mail.gmail.com>
 <8737d6zizt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8737d6zizt.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 17, 2017 at 7:00 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob
>
>> Subject should be dai-format, not dai-name.
>
> Oops !
> Will fix in v6
>
>> > Current snd_soc_of_parse_daifmt() detects [prefix]format, but
>> > "format" was unclear in some case. This patch enables
>> > [prefix]dai-format, too.
>>
>> prefix is not valid here either.
>
> This function will be used from many drivers.
> OF-graph sound card will use it without prefix.

Only the legacy [prefix]format or new dai-format are valid.
[prefix]dai-format should not be allowed.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
