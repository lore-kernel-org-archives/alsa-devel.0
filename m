From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v2 1/2] ASoC: da7218: Add bindings
 documentation for DA7218 audio codec
Date: Wed, 18 Nov 2015 11:23:53 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460E69C@SW-EX-MBX01.diasemi.com>
References: <cover.1447254553.git.Adam.Thomson.Opensource@diasemi.com>
 <760d212f18efec816701f2b3e9fc549ca86d31ee.1447254553.git.Adam.Thomson.Opensource@diasemi.com>
 <20151111201946.GA24618@rob-hp-laptop>
 <2E89032DDAA8B9408CB92943514A0337D460E61B@SW-EX-MBX01.diasemi.com>
 <CAL_Jsq+g4u6qvTDH3FUkZmwkOAptPnie8Mp0r=L8g+JJ-fYKnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.109])
 by alsa0.perex.cz (Postfix) with ESMTP id C991D2656F3
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 12:23:57 +0100 (CET)
In-Reply-To: <CAL_Jsq+g4u6qvTDH3FUkZmwkOAptPnie8Mp0r=L8g+JJ-fYKnQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On November 17, 2015 17:54, Rob Herring wrote:

> >> > +- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
> >> > +   [<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>,
> >> <3000>]
> >> > +- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
> >> > +   [<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>,
> >> <3000>]
> >>
> >> Units please (-microvolt).
> >
> > I refer back to our previous discussion (https://lkml.org/lkml/2015/10/8/661).
> > This doesn't add anything and makes the binding name unnecessarily long. Why is
> > this being enforced? Whoever uses the binding will have to look at the
> > documentation to understand which values are valid anyway, so this seems like
> > cruft.
> 
> It is simply standard, best practice for new bindings. Certainly there
> are examples that don't follow this, but they are either old or
> escaped review.
> 
> Drop the 'lvl' part if you are so concerned about length.

If this is a standard, then maybe this should be explicitly documented and
pushed to all other maintainers so it isn't escaping review? Otherwise you're
left with a disparity which suggests it isn't standard at all. Personally I
stand by that for device specific bindings this shouldn't apply as it gains
nothing except achieving an overly long binding, or you end up cutting down the
descriptive part of the name to accommodate units at the end.
