From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v6] ASoC: cs53l30: Add codec driver support for Cirrus
 CS53L30
Date: Wed, 25 May 2016 10:37:24 -0700
Message-ID: <20160525173724.GA20293@Asurada-Nvidia>
References: <1464045237-4074-1-git-send-email-nicoleotsuka@gmail.com>
 <20160525172800.GB3056@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525172800.GB3056@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lgirdwood@gmail.com, Tim.Howe@cirrus.com, somduttar@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2016 at 12:28:00PM -0500, Rob Herring wrote:

> > diff --git a/Documentation/devicetree/bindings/sound/cs53l30.txt b/Documentation/devicetree/bindings/sound/cs53l30.txt
> > new file mode 100644
> > index 0000000..ace7ffe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/cs53l30.txt
> > @@ -0,0 +1,38 @@
> > +CS53L30 audio CODEC
> > +
> > +Required properties:
> > +
> > +  - compatible : "cirrus,cs53l30"
> > +
> > +  - reg : the I2C address of the device
> > +
> > +  - VA-supply, VP-supply : power supplies for the device,
> > +    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.

> Also, these are missing from the example yet are required. I'd argue 
> they should be optional as you could have designs with no regulator 
> control.

Will refine both in next ver. Thanks
