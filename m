From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: asoc multi-component: almost there!
Date: Tue, 27 Jul 2010 13:20:58 -0500
Message-ID: <AANLkTin7zDYdZGdoYXhF9eJovcbaPGy98HRkqeL7tqpC@mail.gmail.com>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
	<1280238546.3085.89.camel@odin>
	<AANLkTikGhu8EVLozlBWmC6Tuu_gHZX_mkTRImsMo91TE@mail.gmail.com>
	<1280251590.3085.112.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 090812414B
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 20:21:30 +0200 (CEST)
Received: by iwn39 with SMTP id 39so4326372iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 11:21:30 -0700 (PDT)
In-Reply-To: <1280251590.3085.112.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 27, 2010 at 12:26 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> I think you are probably a special case here since you are the only
> person who is dynamically building a DAI link array atm. Everyone else
> has a static table.

I thought the whole point behind this "multi-component" stuff was to
eliminate the need for static tables!

> To further complicate matters, you are having to
> read from a device tree that has not been optimised for creating ASoC
> DAI link tables (hence the meeting at UDS this year to come up with some
> device tree ASoC format).

I don't think that's a factor.  The outcome of that meeting is to
determine how a device tree should represent the relationship between
the SSI, DMA, and codec nodes.  I already have a definition for that,
and the machine driver uses it, but other people apparently don't like
it.  However, the only thing that will change is the specific code I
use to traverse the device tree in the machine driver.  I will still
have the same problems I'm having now.

> Fwiw, I've just again tested another multiple DAI mapping to single
> CODEC DAI :-
>
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "DAI test1",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.stream_name =3D "Multimedia",
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.cpu_dai_name =3D "omap-mcbsp-dai.1",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_name =3D "omap-pcm-audio",
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.codec_dai_name =3D =A0"twl6040-dl1",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.codec_name =3D "twl6040-codec",
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "DAI test2",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.stream_name =3D "Multimedia",
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.cpu_dai_name =3D "omap-mcbsp-dai.3",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_name =3D "omap-pcm-audio",
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.codec_dai_name =3D =A0"twl6040-dl1",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.codec_name =3D "twl6040-codec",
> =A0 =A0 =A0 =A0}
>
>
> Works fine for me.

Look at cs4270.c.  The chip has only one digital interface, so I have
a single DAI structure.  Are you telling me that I need to have two
DAIs in the CS4270 driver?  Won't that break something else?

> I was meaning the DAI _link_ name (above as "DAI test1" and "DAI test
> 2") and not the CODEC DAI name ("twl6040-dl1" above).
>
> I think you should be creating two DAI links like this:-

Ugh.  So you're saying that ASOC no longer supports having two CPU
DAIs connect to the same codec DAI?

-- =

Timur Tabi
Linux kernel developer at Freescale
