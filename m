From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 15/18] dt-bindings: sound: Add bindings for Cirrus
 Logic Madera codecs
Date: Fri, 28 Apr 2017 13:06:52 -0500
Message-ID: <20170428180652.5fb6gagdtrtlgfdy@rob-hp-laptop>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-16-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170425155257.s6m4wgrzxxsxcggo@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170425155257.s6m4wgrzxxsxcggo@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 25, 2017 at 04:52:57PM +0100, Mark Brown wrote:
> On Mon, Apr 24, 2017 at 05:08:41PM +0100, Richard Fitzgerald wrote:
> > The Cirrus Logic Madera codecs are a family of related codecs with
> > extensive digital and analogue I/O, digital mixing and routing,
> > signal processing and programmable DSPs.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.
> 
> > +Required properties:
> > +  - compatible : One of the following chip-specific strings:
> > +        "cirrus,cs47l35-codec"
> > +        "cirrus,cs47l85-codec"
> > +        "cirrus,cs47l90-codec"
> 
> You shouldn't have compatible strings for subfunctions of a MFD unless
> these represent meaningful reusable IPs that can exist separately from
> the parent chip, that's clearly not the case here.  All you're doing
> here is encoding Linux internal abstractions which aren't OS neutral and
> might change in future (for example clocking might move more into the
> clock API).

s/compatible strings/child nodes/ and I agree. If you have child nodes, 
then they need to have compatible strings so we can tell what child is 
which. Node name can be used, but there's no way to version node names. 
A compatible implies what properties are valid.

Rob

