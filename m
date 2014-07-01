From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] ASoC: tas2552: Support TI TAS2552 Amplifier
Date: Tue, 1 Jul 2014 09:37:49 +0100
Message-ID: <20140701083749.GH28740@leverpostej>
References: <1404148259-17305-1-git-send-email-dmurphy@ti.com>
 <20140630172115.GE28740@leverpostej>
 <20140630214342.GI23300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140630214342.GI23300@sirena.org.uk>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 30, 2014 at 10:43:42PM +0100, Mark Brown wrote:
> On Mon, Jun 30, 2014 at 06:21:15PM +0100, Mark Rutland wrote:
> > On Mon, Jun 30, 2014 at 06:10:59PM +0100, Dan Murphy wrote:
> 
> > > +Optional properties:
> 
> > > +- power-gpio - gpio pin to enable/disable the device
> 
> > The code below seems to look for "enable-gpio". Searching for
> > "power-gpio" only hits in the line above and the example below. I assume
> > the code is in error?
> 
> It depends what this is for - if it's for an external regulator it
> should be a regulator binding.  Also all GPIO properties
> are supposed to be called -gpios because DT conventions.

Sure. I was commenting on the mismatch between "enable" in the code and
"power" in the documentation rather than the appropriateness of either
"power-gpios" or "enable-gpios".

Mark.
