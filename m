From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 4/4] ASoC: ep93xx: add
	Simplemachines	Sim.One AC97 audio support
Date: Mon, 11 Oct 2010 10:38:16 +0300
Message-ID: <20101011073816.GC27142@gw.healthdatacare.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<cbadad77a7e11b27fedd9e92fe05322291ca1377.1286707213.git.mika.westerberg@iki.fi>
	<AANLkTi=PAp8pQeVM=GWYVVeKnf2-f+YG2bdSuu5QZH87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 23902243E4
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 09:38:22 +0200 (CEST)
Received: by bwz18 with SMTP id 18so1928699bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 00:38:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=PAp8pQeVM=GWYVVeKnf2-f+YG2bdSuu5QZH87@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, martinwguy@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2010 at 09:22:51AM +0900, Jassi Brar wrote:
> On Sun, Oct 10, 2010 at 7:54 PM, Mika Westerberg <mika.westerberg@iki.fi>=
 wrote:
> =

> > +
> > +static struct snd_soc_dai_link simone_dai =3D {
> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "AC97",
> > + =A0 =A0 =A0 .stream_name =A0 =A0=3D "AC97 HiFi",
> > + =A0 =A0 =A0 .cpu_dai =A0 =A0 =A0 =A0=3D &ep93xx_ac97_dai,
> > + =A0 =A0 =A0 .codec_dai =A0 =A0 =A0=3D &ac97_dai,
> > +};
> ASoC no longer works on cpu and codec_dai. You need to only
> provide the name of the dais... ASoC does string matching to
> link appropriate dais in a link.
> =

> You might want to give another thorough look to all of your drivers
> under the new ASoC.

Thanks.

Which tree/branch should I use for preparing the driver to work
with the new ASoC? Is it the official
git://git.alsa-project.org/alsa-kernel tree or something else?

Regards,
MW
