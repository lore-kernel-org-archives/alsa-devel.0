From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v5 2/2] mfd: arizona: Update DT binding to
	support INn_MODE init_data
Date: Mon, 1 Sep 2014 10:04:21 +0100
Message-ID: <20140901090421.GB12043@opensource.wolfsonmicro.com>
References: <1409365639-5320-1-git-send-email-ideal.song@samsung.com> <1409365639-5320-3-git-send-email-ideal.song@samsung.com> <20140901083400.GD7374@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140901083400.GD7374@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Inha Song <ideal.song@samsung.com>, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sameo@linux.intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2014 at 09:34:00AM +0100, Lee Jones wrote:
> On Sat, 30 Aug 2014, Inha Song wrote:
> 
> > This patch update DT binding to support INn_MODE init_data. Each
> > input signal path can be configurated either as a Analogue or
> > Digital using the INn_MODE registers.
> > 
> > Signed-off-by: Inha Song <ideal.song@samsung.com>
> > Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/arizona.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> Applied, thanks.
> 
> > diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> > index 5c7e723..7bd1273 100644
> > --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> > +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> > @@ -42,6 +42,13 @@ Optional properties:
> >      the chip default will be used.  If present exactly five values must
> >      be specified.
> >  
> > +  - wlf,inmode : A list of INn_MODE register values, where n is the number
> > +    of input signals. Valid values are 0 (Differential), 1 (Single-ended) and
> > +    2 (Digital Microphone). If absent, INn_MODE registers set to 0 by default.
> 
> Please #define these in include/dt-bindings in a subsequent patch.
> 
> And an example?

I have a patch here that I am hoping to push out soon that moves
a lot of defines into include/dt-bindings I can probably roll it
into that or at the least we should probably wait till I have
pushed that out first.

Thanks,
Charles
