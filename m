From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 8/8] Documentation: Add WM8998/WM1814
	device tree bindings
Date: Thu, 23 Apr 2015 15:46:15 +0100
Message-ID: <20150423144615.GC17323@opensource.wolfsonmicro.com>
References: <1429619636-25478-9-git-send-email-rf@opensource.wolfsonmicro.com> <0D842736-8A6E-4462-9690-C9BD60690A7C@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0D842736-8A6E-4462-9690-C9BD60690A7C@cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "Fitzgerald, Richard" <Richard.Fitzgerald@cirrus.com>, "gnurou@gmail.com" <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "broonie@kernel.org" <broonie@kernel.org>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2015 at 02:05:18AM +0000, Austin, Brian wrote:
> 
> 
> > On Apr 21, 2015, at 07:38, Richard Fitzgerald <rf@opensource.wolfsonmicro.com> wrote:
> > 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> > Documentation/devicetree/bindings/mfd/arizona.txt |    3 +++
> > 1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> > index 7665aa9..a3cb34b 100644
> > --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> > +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> > @@ -10,6 +10,9 @@ Required properties:
> >         "wlf,wm5110"
> >         "wlf,wm8280"
> >         "wlf,wm8997"
> > +        "wlf,WM8998"
> > +        "wlf,wm1814"
> > +
> Is there a reason for caps on the 8998? 
> 
> -Brian 

Yes, it's called "lack of attention to detail". Will be fixed in the respin.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
