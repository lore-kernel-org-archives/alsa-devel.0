From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 00:54:04 -0300
Message-ID: <CAOMZO5B8J-Fsv6BkeAQAneu1yf6vC-tV74VB-D6JPA1PPjd99Q@mail.gmail.com>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
	<20140224113011.GE25940@sirena.org.uk>
	<B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
	<20140224160648.GC6132@MrMyself>
	<20140225000027.GI25940@sirena.org.uk>
	<20140225023840.GB7229@MrMyself>
	<20140225030947.GO25940@sirena.org.uk>
	<20140225031313.GA7343@MrMyself>
	<20140225033929.GP25940@sirena.org.uk>
	<20140225034635.GB7343@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140225034635.GB7343@MrMyself>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Mark Brown <broonie@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Austin, Brian" <Brian.Austin@cirrus.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Tue, Feb 25, 2014 at 12:46 AM, Nicolin Chen
<Guangyu.Chen@freescale.com> wrote:
>> So register it from the ESAI driver then.
>
> Then I think I need to find a way to pass the clock to CODEC driver...

Does this example from mxs-saif help?

commit 7c9e6150f2e7cbd60e0bc9a19118ca1dc97d2780
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Mon Jul 1 16:16:10 2013 +0800

    ASoC: mxs: register saif mclk to clock framework

    Mostly the mxs system design uses saif0 mclk output as the clock source
    of codec.  Since the mclk is implemented as a general divider with the
    saif clk as the parent clock, let's register the mclk as a basic
    clk-divider to common clock framework.  Then with it being a clock
    provdier, clk_get() call in codec driver probe function will just work.

    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
    Signed-off-by: Mark Brown <broonie@linaro.org>
