From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood
	i2s	driver for DT usage
Date: Tue, 23 Jul 2013 16:19:56 +0100
Message-ID: <20130723151956.GX24642@n2100.arm.linux.org.uk>
References: <20130723104615.3696f1a9@armhf>
 <20130723123444.GW9858@sirena.org.uk> <51EE7E1A.3040301@gmail.com>
 <20130723132016.GC9858@sirena.org.uk> <51EE8591.7060005@gmail.com>
 <20130723150150.GH9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 4E06C2650D1
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 17:20:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130723150150.GH9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, devicetree-discuss@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2013 at 04:01:50PM +0100, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 03:30:57PM +0200, Sebastian Hesselbarth wrote:
> > On 07/23/13 15:20, Mark Brown wrote:
> 
> > >Why would this be required?  The driver is already asking for multiple
> > >clocks...
> 
> > The driver is asking for multiple *DT based* clocks. Legacy
> > platform_data has never been updated to reflect that. Mainly because
> > multiple clocks are only supported on Dove, which has no active non-DT
> > board in mainline.
> 
> Why would platform data have anything to do with this?  To repeat again
> the way the clocks are mapped should be totally transparent to the
> driver requesting them, if it isn't then the driver is not using the API
> properly.

Total rubbish.  Of course the driver needs to know what the clocks are,
so that it can program its hardware accordingly.

What you have here is an audio block which has two clock inputs.  One
clock is the system clock, whose rate can be adjusted but has a massive
impact on the rest of the system.  The other clock input is via an
external pin.

Internally, in one of the audio blocks registers is a set of control bits
which select which clock is to be used to generate the internal timing
for the block, and a divisor on that input.

>From that description, anyone can see that it is absolutely required for
the driver to know which clock is which, so it can program the clock
input selection bit appropriately.

In this case, it has always been the rule with the clock API that it
shall be used as:

	clk_get(device, "internal");

to get the internal clock, and:

	clk_get(device, "external");

to get the external clock - or whatever names are appropriate to name the
clock _inputs_.
