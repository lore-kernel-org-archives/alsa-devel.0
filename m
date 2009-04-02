From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 + touchscreen
	suspend/resume
Date: Thu, 2 Apr 2009 13:33:37 +0100
Message-ID: <20090402123337.GF4527@sirena.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090331191539.GA10854@sirena.org.uk>
	<20090402115541.GB9522@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 31E2F24334
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 14:33:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402115541.GB9522@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 12:55:41PM +0100, Russell King - ARM Linux wrote:
> On Tue, Mar 31, 2009 at 08:15:40PM +0100, Mark Brown wrote:

> > With a normal ASoC codec
> > driver the AC97 codec is not visible as a separate device in the device
> > tree - if you could point me to your machine driver that'd be helpful.

> Not true - the codec appears as /sys/devices/0-0:WM9705 rather than a
> sub-device of the AC97 controller.  Below this there are two sub-devices:

Ah, I see what you mean - as you say that's actually the device for the
touch functionalty of the device rather than for the codec part which is
handled in soc-audio.

> /sys/devices/0-0:WM9705/wm97xx-battery
> /sys/devices/0-0:WM9705/wm97xx-touch

> The wm97xx-ts touchscreen driver binds to the 0-0:WM9705 device, so
> clearly unless 0-0:WM9705 is a child of the AC97 controller, things
> aren't going to be guaranteed to be resumed in the right order.

Right, the second patch I sent yesterday parents the device properly so
the ordering should now be OK there.  Did you try using the generic AC97
driver?  The code for handling the controller hardware is now shared
between the ASoC and that - if it fails with both that'd point at the
controller support.
