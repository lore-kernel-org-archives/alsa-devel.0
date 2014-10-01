From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v6 2/2] drm/i2c:tda998x: Use the HDMI audio CODEC
Date: Wed, 1 Oct 2014 11:28:46 +0200
Message-ID: <20141001112846.0dbc80ae@armhf>
References: <cover.1411547014.git.moinejf@free.fr>
	<4b3d35a14461ed164956b7f5aa77b29170bc393d.1411547014.git.moinejf@free.fr>
	<20140930192540.GL4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140930192540.GL4273@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Sep 2014 20:25:40 +0100
Mark Brown <broonie@kernel.org> wrote:

> > +	request_module("snd-soc-hdmi-codec");
> > +	pdev =3D platform_device_register_resndata(&priv->hdmi->dev,
> > +						 "hdmi-audio-codec",
> > +						  PLATFORM_DEVID_NONE,
> > +						  NULL, 0,
> > +						  &tda998x_hdmi_data,
> > +						  sizeof tda998x_hdmi_data); =20
>=20
> Why is this request_module() needed?  If there is a good reason for i=
t
> we should have some documentation.

The reason is simple: as the HDMI CODEC is not declared in the DT, the
associated module must be loaded in memory.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
