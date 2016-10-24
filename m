From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 3/7] drm: sunxi: add DE2 HDMI support
Date: Mon, 24 Oct 2016 15:17:03 +0200
Message-ID: <20161024131703.exrqt5cqrepwuvkp@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <36bd5454897c8ab77749e0294e4a4ecc2450dd12.1477142934.git.moinejf@free.fr>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j2ch3qfkybhcbhss"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB4FVXHAAKGQEJZNKS6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <36bd5454897c8ab77749e0294e4a4ecc2450dd12.1477142934.git.moinejf-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--j2ch3qfkybhcbhss
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Fri, Oct 21, 2016 at 10:08:06AM +0200, Jean-Francois Moine wrote:
> This patch adds a HDMI driver to the DE2 based Allwinner's SoCs
> as A83T and H3.
> Audio and video are supported.
> 
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>

Output from checkpatch:
total: 26 errors, 31 warnings, 70 checks, 1458 lines checked

Please run checkpatch before sending your patches.

Apart from that, this looks an awful lot like the designware HDMI
controller, for which a driver already exists. Any reason to create a
new driver from scratch?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--j2ch3qfkybhcbhss--
