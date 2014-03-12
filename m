From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: cs42888: Add codec driver support
Date: Wed, 12 Mar 2014 10:03:35 +0800
Message-ID: <20140312020334.GD1177@MrMyself>
References: <1394536791-8381-1-git-send-email-Guangyu.Chen@freescale.com>
 <alpine.DEB.2.02.1403111026280.3558@heelrod>
 <531F320E.70605@metafoo.de>
 <20140311184606.GW28112@sirena.org.uk>
 <03E7E694-045D-4C8B-A1A4-98CC306D6D63@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <03E7E694-045D-4C8B-A1A4-98CC306D6D63@cirrus.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Brian,

On Wed, Mar 12, 2014 at 02:05:00AM +0000, Austin, Brian wrote:
> 
> 
> >> On Mar 11, 2014, at 13:46, "Mark Brown" <broonie@kernel.org> wrote:
> >> 
> >> On Tue, Mar 11, 2014 at 04:55:58PM +0100, Lars-Peter Clausen wrote:
> >> On 03/11/2014 04:41 PM, Brian Austin wrote:
> > 
> >>> So WRT the CS42888, this is one device in a series of 2 devices that are
> >>> register compatible with the only difference being that the CS42488 has 2
> >>> extra ADC's. Same die and same DeviceID.
> > 
> >>> Would it make more sense to submit the driver with the extra ADC's to make
> >>> it feature complete for both devices? Wouldn't be odd to have 2 drivers that
> >>> do the same for 98% of the code.
> > 
> >> This should be in one driver. But support for the second device can
> >> always be added in a follow up patch.
> > 
> > Yes, we can add support later.  It might be helpful to name the driver
> > with some generic name I guess.
> CS42xx8 would work.
> 
> We have a CS42448 and the CS42888. The difference is the 2 extra ADC's on the CS42448. I can add those later.
> 
> I still would like to go over some of the v2 code though before a v3 is sent.

Actually I've already sent v3 right after this v2 due to some doc updating.

Anyway, I'd love to wait for your comments against the patch before I send v3.

Thank you,
Nicolin


