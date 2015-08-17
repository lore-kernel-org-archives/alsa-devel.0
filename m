From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432
Date: Mon, 17 Aug 2015 09:09:22 +0200
Message-ID: <alpine.DEB.2.02.1508170844030.27635@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508141106040.27635@lnxricardw1.se.axis.com>
 <20150814160731.GS10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FD0626053D
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 09:09:24 +0200 (CEST)
In-Reply-To: <20150814160731.GS10748@sirena.org.uk>
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


On Fri, 14 Aug 2015, Mark Brown wrote:

> On Fri, Aug 14, 2015 at 11:10:10AM +0200, Ricard Wanderlof wrote:
> > =

> > V2: Update after comments from Lars-Peter yesterday: set rate to =

> > CONTINUOUS and let ALSA figure out the details, also removing hw_params=
 as =

> > it is then not needed.
> =

> Please add any non-changelog content like this after the --- as covered
> in SubmittingPatches.

Ok, sorry.

> > +static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned int =
fmt)
> > +{
> > +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> =

> This still seems redundant (IIRC Lars mentioned this...).

I though Lars was referring solely to the hw_params function, not =

set_dai_fmt, but of course I could have misunderstood him.

I can understand the rates constraints being handled by the ALSA framework =

based on the parameters set in struct snd_soc_dai_driver, but how would =

the framework know about the acceptable INV_MASK and FORMAT_MASK values?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
