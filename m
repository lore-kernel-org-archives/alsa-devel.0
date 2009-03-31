From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 + touchscreen
	suspend/resume
Date: Tue, 31 Mar 2009 19:37:55 +0100
Message-ID: <20090331183755.GA27451@n2100.arm.linux.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6FD701037ED
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 20:38:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090331103048.GC11800@sirena.org.uk>
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

On Tue, Mar 31, 2009 at 11:30:48AM +0100, Mark Brown wrote:
> On Mon, Mar 30, 2009 at 11:37:20PM +0100, Russell King - ARM Linux wrote:
> > 1. when suspend occurs, we turn the AC97 link off by setting the
> > GCR_ACLINK_OFF bit, and stopping the functional units clock.
> 
> > Setting GCR to '2' (to release cold reset) using devmem2 starts things
> > moving again, shutting up this warning.
> 
> Hrm, I suspect this is a result of the second issue.
> 
> > 2. maybe as a result of the above problem, the wm9705 touchscreen
> > driver doesn't reinitialize, causing loss of touchscreen.  Unbinding
> > and re-binding the driver restores the touchscreen, but with a very
> > long lag between touching the screen and it being registered.
> 
> > I bring (2) up because I notice that the resume actions in (1) are
> > deferred.  Given that codecs have shared functions (such as
> > touchscreens) need to access the codec from their own resume
> > functions, how can this deferral be safe?
> 
> Other multi-function devices shouldn't have this problem since they
> will not be relying on ASoC to resume their control interface (most
> likely they will be using MFD to share the device).  It's not safe for
> AC97 devices, though.
> 
> We only really need the deferral for non-AC97 devices - it's there since
> some I2C buses are very slow and non-AC97 codecs often have large
> numbers of registers to restore and require delays to bring the codec up
> cleanly leading to a substantial impact on overall resume time.
> 
> Could you let me know if the patch below works, please?  I've not fully
> tested it myself yet.

I don't think this is the complete story.  Sometime between 2.6.27 and
2.6.29, the structure below /sys/devices/platform/soc-audio changed
(the ac97 codec moved to the top level.)

This clearly isn't right.  We want to resume the host side of the link
first, followed by the AC97 codec, followed by any sub drivers next.
The way to guarantee that is to ensure that the parenting of the devices
is correct.

In other words, this structure:

/sys/devices/platform/soc-audio/ac97-device/sub-devices-eg-touchscreen

I'm not sure where wm9705-ts currently appears in the device tree (I
need to resume the device, and sort out its resume quirks so that I can
see the sysfs layout... but I'm absolutely sure that the ac97 device
appears at /sys/devices/platform/ which is definitely wrong.
