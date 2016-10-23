From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH v5 0/7] ARM: ASoC: drm: sun8i: Add DE2
 HDMI audio and video
Date: Sun, 23 Oct 2016 09:35:15 +0200
Message-ID: <20161023093515.960c394d78b84e0480640075@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
        <CAGb2v64fgJShfyEHnjm6ryg00WhHkmnPj+FdjHcXBa6HQbyTuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGb2v64fgJShfyEHnjm6ryg00WhHkmnPj+FdjHcXBa6HQbyTuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 23 Oct 2016 09:38:04 +0800
Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:

> > Recently, an announce about Tina OS for the R series
> >         https://www.youtube.com/watch?v=h7KD-6HblAU
> > was followed by the upload of a new linux-3.4 source tree
> >         https://github.com/tinalinux/linux-3.4
> > with files containing GPL headers.
> >
> > Well, I don't know if these sources are really from Allwinner, but
> > anyway, this is the opportunity to propose a new version of my DRM
> > HDMI driver.
> 
> Could you clarify about this bit? Did you just clean up Allwinner's
> existing drivers? Or just use them as reference? Either way I think
> this deserves some mention in all your copyright headers.
> 
> Otherwise what difference does the new release make?

- Allwinner's video driver is not DRM.
- their driver has no hardware cursor nor video overlay.
- I wrote the video DRM driver from the document
	Allwinner_H3_Datasheet_V1.2.pdf
  and the structures defined in
linux-3.4/drivers/video/sunxi/disp2/disp/de/lowlevel_sun8iw7/de_rtmx.h
  Reading Allwinner's code helped me to understand how the DE2
  is working.
- my lowlevel HDMI is just a cleanup of theirs with explanations
  about the registers. Magic constants remain due to the lack of
  knowledge about the PHYs.
- the mention of Allwinner in the copyright headers is needed to
  indicate the source of the structures (DE2) and code (HDMI).

The main difference is the DRM interface and the use of the EDID,
permitting dynamic video resolution change with xrandr.

-- 
Ken ar c'hentañ	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
