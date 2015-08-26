From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v4] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432 (fwd)
Date: Wed, 26 Aug 2015 14:00:27 +0200
Message-ID: <alpine.DEB.2.02.1508261355390.16666@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508241357410.16666@lnxricardw1.se.axis.com>
 <20150825174933.GI12878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id B89952654D4
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 14:00:29 +0200 (CEST)
In-Reply-To: <20150825174933.GI12878@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Tue, 25 Aug 2015, Mark Brown wrote:

> On Mon, Aug 24, 2015 at 02:03:14PM +0200, Ricard Wanderlof wrote:
> =

> > +static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned int =

> > +fmt) {
> > +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +	case SND_SOC_DAIFMT_NB_NF:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> =

> I've asked you several times to implement format checking in the core if =

> you think it's useful to add :(

Sorry, I misunderstood the outcome of the discussion with you and =

Lars-Peter, to the point that it was better to have that type of checking =

in the core, but in the absence of that (since apparently no one has had =

the need to had it before) it was better to have the check at the driver =

level than not at all.

I'll take it out of the driver and repost.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
