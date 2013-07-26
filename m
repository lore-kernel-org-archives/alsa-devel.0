From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 1/4] ASoc: kirkwood: change the pcm/dma stream data
 pointer
Date: Fri, 26 Jul 2013 08:19:53 +0200
Message-ID: <20130726081953.785c8527@armhf>
References: <20130725111314.66b811bc@armhf>
	<20130725093855.GB24642@n2100.arm.linux.org.uk>
	<20130725182356.GN9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130725182356.GN9858@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Jul 2013 19:23:56 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jul 25, 2013 at 10:38:55AM +0100, Russell King - ARM Linux wr=
ote:
>=20
> > There's a much better solution to this, which is to get rid of
> > kirkwood_dma_priv entirely:
>=20
> This does seem a lot nicer, can we either grab the relevant patch fro=
m
> your tree or update this one to use the same approach?

Russel's solution works fine for me, so my patch 1/4 may be cancelled.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
