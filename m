From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/6] ASoC: samsung: Add DT bindings documentation for
 TM2 sound subsystem
Date: Tue, 28 Jun 2016 15:55:08 -0500
Message-ID: <20160628205508.GD3737@rob-hp-laptop>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-6-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466678715-19962-6-git-send-email-s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2016 at 12:45:14PM +0200, Sylwester Nawrocki wrote:
> This patch adds DT binding documentation for Exnos5433 based TM2
> and TM2E boards sound subsystem.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes since initial version:
>  - dropped clocks, clock-names properties, instead properties from
>    the CODEC node will be used,
>  - property renames: 'samsung,model' -> 'model', 'samsung,i2s-controller'
>    -> 'i2s-controller', 'samsung,speaker-amplifier' -> 'audio-amplifier',
>  - added 'audio-codec' property.
> ---
>  .../bindings/sound/samsung,tm2-audio.txt           | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
