From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Tue, 26 Aug 2014 11:19:01 +0200
Message-ID: <53FC5105.6070901@metafoo.de>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com> <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com> <53F9A6EE.5070005@metafoo.de> <871ts4nmki.wl%kuninori.morimoto.gx@gmail.com> <20140826062558.GR17528@sirena.org.uk> <87wq9vmyyc.wl%kuninori.morimoto.gx@gmail.com> <20140826091120.GC17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140826091120.GC17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 08/26/2014 11:11 AM, Mark Brown wrote:
> On Tue, Aug 26, 2014 at 01:34:21AM -0700, Kuninori Morimoto wrote:
>
>> This patch expand route setting by using DAI name.
>> You can select "ak4642-hifi" side "Playback" by below.
>
>> DT
>> 	simple-audio-card,routing =
>> 		"ak4642-hifi Playback", "DAI0 Playback";
>
>> non DT
>> 	struct snd_soc_dapm_route route[] = {
>> 		{ "ak4642-hifi Playback", NULL, "DAI0 Playback"},
>> 	}
>
> If we're already specifying the DAI links for the (D)PCM code it seems
> like we shouldn't also have to put DAPM routes for them in DT as well.
>

Yes, and I think we shouldn't use anything except for datahsheet pin names 
in the devicetree routing, because otherwise we are leaking driver 
implementation details.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
