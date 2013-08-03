From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v3 1/4] ASoc: kirkwood: simplify probe error
Date: Sat, 3 Aug 2013 18:52:55 +0200
Message-ID: <20130803185255.1b1932c4@armhf>
References: <20130731081739.76aae84c@armhf>
	<20130803124652.GY23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130803124652.GY23006@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 3 Aug 2013 13:46:52 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jul 31, 2013 at 08:17:39AM +0200, Jean-Francois Moine wrote:
> > The function kirkwood_i2s_dev_remove() may be used when probe fails=
=2E
>=20
> Looking at this deeper, I'm not happy with this.
	[snip]
> What this means is that if snd_soc_register_component() fails, we end
> up calling snd_soc_unregister_component().  This may be fine with the
> way snd_soc_unregister_component() is currently implemented, but you'=
re
> making the assumption that it's fine to call snd_soc_unregister_compo=
nent()
> for a device which hasn't been registered.  Technically, this is a
> layering violation, which makes this change fragile if the behaviour
> of snd_soc_unregister_component() changes in the future.
>=20
> For the sake of two calls in the error path, I don't think the benefi=
ts
> of this patch outweigh the risk.

You are right, but if snd_soc_unregister_component() could be
officially used safely with no previous call to
snd_soc_register_component(), this would simplify error handling in
other drivers too...

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
