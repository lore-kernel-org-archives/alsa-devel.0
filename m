From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 2/4] ASoc: kirkwood: simplify probe error
Date: Fri, 26 Jul 2013 08:28:18 +0200
Message-ID: <20130726082818.480d2a02@armhf>
References: <20130725111357.7c976963@armhf>
	<20130725191059.GO9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130725191059.GO9858@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Jul 2013 20:10:59 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jul 25, 2013 at 11:13:57AM +0200, Jean-Francois Moine wrote:
> > The function kirkwood_i2s_dev_remove() may be used when probe fails=
=2E
>=20
> This seems fine but doesn't apply against current code but otherwise
> seems fine.

My base is 3.11-rc2.

> > +	if (!IS_ERR(priv->extclk)) {
> > +		clk_disable_unprepare(priv->extclk);
> > +		clk_put(priv->extclk);
> > +	}
>=20
> Could use devm_clk_get() for extclk.

I will do it.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
