From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: fsl: add imx-cs427x machine driver
Date: Tue, 26 Jan 2016 09:05:42 -0200
Message-ID: <CAOMZO5CjVxAHOJSywveK7dYvdz8PSMADJd1F7TdO+asEQ89XTg@mail.gmail.com>
References: <1453744403-12268-1-git-send-email-eu@felipetonello.com>
	<20160126022948.GA21187@rob-hp-laptop>
	<56A73FDE.2060607@felipetonello.com>
	<CAOMZO5BjeDMqNgf-=tE7=pByJi+jJVA=G2bbtp+XJeYbpev6KA@mail.gmail.com>
	<56A75205.8060000@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56A75205.8060000-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Ferreri Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 26, 2016 at 9:01 AM, Felipe Ferreri Tonello
<eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org> wrote:

> Actually yes, thanks! I didn't know about the existence of fsl-asoc-card.
>
> I get some errors but I don't think they actually matter:
> [   19.734494] fsl-asrc 2034000.asrc: driver registered
> [   19.738707] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
> [   19.738717] fsl-asoc-card sound: snd_soc_register_card failed (-517)
> [   19.741556] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
> [   19.741564] fsl-asoc-card sound: snd_soc_register_card failed (-517)
> [   19.774591] fsl-asoc-card sound: cs4271-hifi <-> 2028000.ssi mapping ok
> [   19.781507] fsl-asoc-card sound: ASoC: no source widget found for
> ASRC-Playback
> [   19.790065] fsl-asoc-card sound: ASoC: Failed to add route
> ASRC-Playback -> direct -> CPU-Playback
> [   19.805349] fsl-asoc-card sound: ASoC: no sink widget found for
> ASRC-Capture
> [   19.817222] fsl-asoc-card sound: ASoC: Failed to add route
> CPU-Capture -> direct -> ASRC-Capture
>
> The codec is producing sound, which is good. Any idea on why these
> errors are been triggered?

Adding Nicolin on Cc.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
