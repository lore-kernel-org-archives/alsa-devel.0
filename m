From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] ASoC: tse850: document axentia,tse850-pcm5142
 bindings
Date: Tue, 15 Nov 2016 09:08:58 -0600
Message-ID: <20161115150858.hist2uhdi4vvg6pg@rob-hp-laptop>
References: <1478863752-10569-1-git-send-email-peda@axentia.se>
 <1478863752-10569-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478863752-10569-3-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 11, 2016 at 12:29:11PM +0100, Peter Rosin wrote:
> The TSE-850 is an FM Transmitter Station Equipment, designed to generate
> baseband signals for FM, mainly the DARC subcarrier, but other signals
> are also possible.
> 
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> ---
>  .../bindings/sound/axentia,tse850-pcm5142.txt      | 88 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
> new file mode 100644
> index 000000000000..0c2d44fda17e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
> @@ -0,0 +1,88 @@
> +ASoC driver for the Axentia TSE-850 with a PCM5142 codec

Bindings don't describe drivers nor ASoC. Otherwise,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
