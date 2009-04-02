From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Thu, 2 Apr 2009 13:13:48 +0100
Message-ID: <20090402121348.GC9522@n2100.arm.linux.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090401192710.GH21294@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 20DB6103852
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 14:14:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090401192710.GH21294@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 01, 2009 at 08:27:10PM +0100, Mark Brown wrote:
> On Tue, Mar 31, 2009 at 07:37:55PM +0100, Russell King - ARM Linux wrote:
> > I don't think this is the complete story.  Sometime between 2.6.27 and
> > 2.6.29, the structure below /sys/devices/platform/soc-audio changed
> > (the ac97 codec moved to the top level.)
> 
> I also haven't manage to reproduce the ordering issues with the register
> writes with or without my fixes so I can't be 100% confident that this
> will fix the problem you're seeing.  If you could post your machine
> driver that'd be helpful.

My machine driver is very simple and doesn't implement any suspend/resume
callbacks (that's what other things like soc-audio are doing, right?)

I've tried both your patches, and I still have to manually write to
GCR to bring the bus out of reset.  I'll investigate more in the coming
days.
