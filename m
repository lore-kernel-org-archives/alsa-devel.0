From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Thu, 2 Apr 2009 13:38:44 +0100
Message-ID: <20090402123844.GD9522@n2100.arm.linux.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090401192710.GH21294@sirena.org.uk>
	<20090402121348.GC9522@n2100.arm.linux.org.uk>
	<20090402121803.GD4527@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A92572434A
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 14:38:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402121803.GD4527@sirena.org.uk>
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

On Thu, Apr 02, 2009 at 01:18:03PM +0100, Mark Brown wrote:
> On Thu, Apr 02, 2009 at 01:13:48PM +0100, Russell King - ARM Linux wrote:
> > I've tried both your patches, and I still have to manually write to
> > GCR to bring the bus out of reset.  I'll investigate more in the coming
> > days.
> 
> Which PXA variant is the system using?

PXA255.
