From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432
Date: Mon, 17 Aug 2015 11:51:59 +0200
Message-ID: <alpine.DEB.2.02.1508171151130.27635@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508141106040.27635@lnxricardw1.se.axis.com>
 <20150814160731.GS10748@sirena.org.uk>
 <alpine.DEB.2.02.1508170844030.27635@lnxricardw1.se.axis.com>
 <55D191BB.1000204@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C64C2260451
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 11:52:12 +0200 (CEST)
In-Reply-To: <55D191BB.1000204@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Mon, 17 Aug 2015, Lars-Peter Clausen wrote:

> >>> +static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned in=
t fmt)
> >>> +{
> >>> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> >>
> >> This still seems redundant (IIRC Lars mentioned this...).
> > =

> > I though Lars was referring solely to the hw_params function, not =

> > set_dai_fmt, but of course I could have misunderstood him.
> =

> Yes, I was. In my opinion this set_dai_fmt() implementation is useful to
> have as a mechanism to detect invalid configurations. E.g. if you don't
> implement the callback the CODEC will accept any setting while with he
> callback it will error out with the wrong configuration. Given that a I2S
> link typically at least somewhat works, even if you have the wrong settin=
g,
> I think it makes sense to keep it to catch errors early on.

Makes sense to me. =


Ok, then, unless Mark seriously objects, I'll leave this as it is, and
resubmit the patch with a revised MODULE_LICENSE string and repartitioning
of the commit message / version comment.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
