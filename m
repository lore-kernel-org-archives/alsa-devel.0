From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: da7218: Add bindings documentation for
 DA7218 audio codec
Date: Tue, 17 Nov 2015 11:53:46 -0600
Message-ID: <CAL_Jsq+g4u6qvTDH3FUkZmwkOAptPnie8Mp0r=L8g+JJ-fYKnQ@mail.gmail.com>
References: <cover.1447254553.git.Adam.Thomson.Opensource@diasemi.com>
 <760d212f18efec816701f2b3e9fc549ca86d31ee.1447254553.git.Adam.Thomson.Opensource@diasemi.com>
 <20151111201946.GA24618@rob-hp-laptop> <2E89032DDAA8B9408CB92943514A0337D460E61B@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460E61B@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2015 at 11:27 AM, Opensource [Adam Thomson]
<Adam.Thomson.Opensource@diasemi.com> wrote:
> On November 11, 2015 20:20, Rob Herring wrote:
>
>> > +- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
>> > +   [<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>,
>> <3000>]
>> > +- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
>> > +   [<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>,
>> <3000>]
>>
>> Units please (-microvolt).
>
> I refer back to our previous discussion (https://lkml.org/lkml/2015/10/8/661).
> This doesn't add anything and makes the binding name unnecessarily long. Why is
> this being enforced? Whoever uses the binding will have to look at the
> documentation to understand which values are valid anyway, so this seems like
> cruft.

It is simply standard, best practice for new bindings. Certainly there
are examples that don't follow this, but they are either old or
escaped review.

Drop the 'lvl' part if you are so concerned about length.

Rob
