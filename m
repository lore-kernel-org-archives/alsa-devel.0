From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [resend][PATCH v5 07/10] ASoC: add snd_soc_get_dai_id()
Date: Mon, 17 Apr 2017 08:41:31 -0500
Message-ID: <CAL_JsqLm6tcupSuvsd_yjVH6Ks+cEm1_p2WBToGLpQQFGVwfhA@mail.gmail.com>
References: <87bmrvvqgs.wl%kuninori.morimoto.gx@renesas.com> <871ssrvqbk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871ssrvqbk.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 16, 2017 at 7:23 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> ALSA SoC needs to know connected DAI ID for probing.
> On OF-graph case, basically we can check DT port location.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v4 -> v5
>
>  - no change

You can keep posting the same version again, but I still have the same
objections.

Having the core graph-card parsing details of remote endpoints is
fragile. The driver for the remote node should do the parsing of its
own endpoints and is the only entity that should care or know what the
port and endpoint numbering is. The fact that you are planning to
change this for HDMI support is evidence of that. I don't see the
point of a temporary solution.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
