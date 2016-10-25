From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver
 for Allwinner DE2
Date: Tue, 25 Oct 2016 08:44:22 +0200
Message-ID: <20161025064422.4jua6qmpr7zu3ijt@phenom.ffwll.local>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
Reply-To: daniel-/w4YWyX8dFk@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDYZDG4VSMIRBSP6XPAAKGQE3THRBTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2016 at 09:26:18AM +0200, Jean-Francois Moine wrote:
> +static int de2_drm_bind(struct device *dev)
> +{
> +	struct drm_device *drm;
> +	struct priv *priv;
> +	int ret;
> +
> +	drm = drm_dev_alloc(&de2_drm_driver, dev);
> +	if (!drm)
> +		return -ENOMEM;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(dev, "failed to allocate private area\n");
> +		ret = -ENOMEM;
> +		goto out1;
> +	}
> +
> +	dev_set_drvdata(dev, drm);
> +	drm->dev_private = priv;
> +
> +	drm_mode_config_init(drm);
> +	drm->mode_config.min_width = 32;	/* needed for cursor */
> +	drm->mode_config.min_height = 32;
> +	drm->mode_config.max_width = 1920;
> +	drm->mode_config.max_height = 1080;
> +	drm->mode_config.funcs = &de2_mode_config_funcs;
> +
> +	drm->irq_enabled = true;
> +
> +	/* initialize the display engine */
> +	priv->soc_type = (int) of_match_device(de2_drm_of_match, dev)->data;
> +	ret = de2_de_init(priv, dev);
> +	if (ret)
> +		goto out2;
> +
> +	/* start the subdevices */
> +	ret = component_bind_all(dev, drm);
> +	if (ret < 0)
> +		goto out2;
> +
> +	ret = drm_dev_register(drm, 0);

This needs to be the very last step in your driver load sequence.
Kerneldoc explains why. Similar, but inverted for unloading:
drm_dev_unregister is the very first thing you must call.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
