From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH] ASoC: make snd_soc_dai_link more symmetrical
Date: Tue, 31 Dec 2013 18:44:30 +0100
Message-ID: <20131231184430.3a4c9414@armhf>
References: <20131212185917.7ed6b21f@armhf>
	<20131231165533.GK31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131231165533.GK31886@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Dec 2013 16:55:33 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Dec 12, 2013 at 06:59:17PM +0100, Jean-Francois Moine wrote:
>=20
> > This patch renders optional the CODEC name / OF node on sound card =
register,
> > as it is done for the CPU side, in the case the CODEC DAI name is u=
nique.
>=20
> > This simplifies the definition of CODECs with multiple DAIs, especi=
ally
> > in DTs, while keeping compatibility.
>=20
> So, this is similar to one of the comments I made on the DT patch you
> sent today: you're saying that this makes things better but you're no=
t
> saying why it makes things better.  I've been sitting on this partly
> because I've been wanting to sit down and try to work out what the
> benefit is.  This information should be readily avaiable and omiting =
it
> seems like it will make things more fragile.
>=20
> If anything I'd expect DT to want to move towards specifying things b=
y
> CODEC plus optional DAI index rather than anything else, that's the m=
ore
> common pattern for DT based things (really phandle plus index) and it=
's
> what the current generic card is doing.
>=20
> It's possible there is a benefit I'm just not seeing but you'll need =
to
> tell me.

The first benefit I got was in the front-end definition: the codec side
is the dummy codec, and this one has no phandle.

Then, finding the CODEC DAI from phandle asks for more code
(of_xlate_dai_name in the CODEC drivers) and finding it from the CODEC
name asks for a double loop in soc_bind_dai_link. On the other way, a
simple loop without any more change may be used when the DAI is simply
specified by its name. I would say that the DAI name is more meaningful
than a DAI index and that it is less subject to internal changes of the
CODEC driver.

Eventually, I don't think that, using only the name of the CODEC side
DAI to identify it, is not more fragile than identifying the CPU side
of the DAI link by its name.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
