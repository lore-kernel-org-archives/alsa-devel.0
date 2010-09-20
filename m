From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 3/5] ASoC: lowercase wm8978 codec name to
 match its only user and other codecs
Date: Mon, 20 Sep 2010 09:12:52 +0100
Message-ID: <1284970372.3403.15.camel@odin>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
	 <Pine.LNX.4.64.1009171214281.4988@axis700.grange>
	 <20100917125319.GF4322@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100917125319.GF4322@rakim.wolfsonmicro.main>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-17 at 13:53 +0100, Mark Brown wrote:
> On Fri, Sep 17, 2010 at 12:30:05PM +0200, Guennadi Liakhovetski wrote:
> > All ASoC codecs are called in lower case, adjust wm8978 to match them and also
> > to match its so far only user - the sh7722 migor board.
> 
> >  	.driver = {
> > -		.name = "WM8978-codec",
> > +		.name = "wm8978-codec",
> 
> Better yet would be to rename this to wm8978 (and adjust the board).

Fwiw, the reason for the "-codec" suffix was to distinguish codec
devices from their other multi-function IC siblings. It also makes sense
here to use convention with the device naming too (even if the device is
single purpose).

Liam  
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

