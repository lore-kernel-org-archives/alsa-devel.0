From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 23 Aug 2012 12:39:23 +0100
Message-ID: <20120823113922.GZ7995@opensource.wolfsonmicro.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4567699672833342829=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65BC8265CC1
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 13:39:24 +0200 (CEST)
In-Reply-To: <20120823092216.GA27264@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: roger.xr.nilsson@stericsson.com, 'Linus Walleij' <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Ola Lilja <olalilja@yahoo.se>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4567699672833342829==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vI7bUhxOxYx/Tbgh"
Content-Disposition: inline


--vI7bUhxOxYx/Tbgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 23, 2012 at 10:22:17AM +0100, Lee Jones wrote:

> > > Just thinking about this now. I converted it to the current format at
> > > the request of Mark. If this isn't the correct method I'm not quite
> > > sure what is. If you want it to be registered as a device, then it
> > > needs to go into the Device Tree, but Mark doesn't want it in there
> > > because it doesn't actually represent hardware.

> I've just taken a closer look at this with a view to finding the most
> suitable solution. My conclusion is that although the PCM doesn't
> contain any registers, or represent hardware it should be a device and
> therefore be present in the Device Tree.

Your assumption that being a device in Linux means that something should
appear in the device tree definitely doesn't follow.

> PCM devices already represented in DTs:
>   fsl,mpc5200-pcm - written by Grant Likely, the author of Device Tree
>   phytec,pcm030   - written by Grant Likely, the author of Device Tree

I suspect Mitch might have a word or two to say about the above...  in
any case, these are *really* old PowerPC bindings which means they're
not always a good model.  Though in this case if you look at the code
you'll also see that the driver is actually directly managing hardware
with register I/O rather than just purely proxying an underlying DMA
API.  Clearly if there's actual hardware control involved a device is
appropriate.

> PCM devices which register as actual devices (should be in DT):

These are all Linux platform devices, things that are OK for purely
internal Linux usage which we can rewrite at will aren't always
appropriate for a cross platform DT.

> I propose to represent the PCM in the Device Tree again and have it
> probe just like all the other PCM devices in sound/soc.

> If you give me the nod, I'll revert this patch, enable the PCM for DT
> again and resent the patch-set in full.

I say I don't understand the motivation for this change.  All the modern
DT bindings are perfectly happy handling this without an explicit shim
in the device tree to bodge things for Linux, adding them in seems like
it'd be a retrograde step.  What benefit do you believe this brings?

--vI7bUhxOxYx/Tbgh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNhZkAAoJEFJkBDiqVpZ4FpMQAJuEQEF/Of5jCauqn25LcF/q
nHVLB7YtyG7a+2zNQ2X3ywtjs5A18c4VNlAKNe5cQHN2ukX6IZVWftCF7XGmqOHm
jLEOaAdkgvzb6B/D/75YwkQID5zfnDBSz/vOX1VGIDb2kvBCdF/QbGBZYGAeHfQH
bSdDHvLchwWjVhufxlfjaGV8lZdpzj6ZUgQm2DW+8AGxZFL2OPcBiRK3nX92sbOJ
Vxp4FtA/A1O4OE9F8ecpsKAOGEeoXdqOlscVs2IfB3MZ93NRp43YDCwvZSV8We/f
A8QnzDQoafwB3UxfFRCdCfSIqlCUory74Xm6stWZAMVghfkUq91QU5r1DJG8kf4O
hjxxyVhLjWq7lLG8TwmgD9ewEb9WbR2P8zJtVD7hMprmSWM1aeZA/5mkBzO3ImQG
tpDNpaYFgciPHVhNPcj6mHAQ1jE7v35/T2Y7znIqV7DoozXHspb0Q903kD4lOIdc
HSiNztK4ssLxFTIyUMiDDyGY8BBEAQ/uecwStc6mZJZmNiuyHTb9GAzGddgvahpF
hbPaj5tEaQz5/yVGb4YA6F9+l75vdU0YAScvgUuAj+uxEIjl8I7hHFJoTc2qyqGm
slxSqIF3p2PRZJYv5/58EUzt94qlQGh7JbQGMwnhP7DrWZz4G8lUg+K2PMFle8K+
AQSvkF/USURkbcA7cvIt
=6Uqd
-----END PGP SIGNATURE-----

--vI7bUhxOxYx/Tbgh--

--===============4567699672833342829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4567699672833342829==--
