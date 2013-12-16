From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: imx-spdif: Use module_init() to
	handle	platform_device_register()
Date: Mon, 16 Dec 2013 21:19:58 +0000
Message-ID: <20131216211958.GS4360@n2100.arm.linux.org.uk>
References: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131216194717.GO3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id F40F62619F7
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 22:20:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131216194717.GO3185@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 16, 2013 at 07:47:17PM +0000, Mark Brown wrote:
> On Mon, Dec 16, 2013 at 06:36:09PM +0800, Nicolin Chen wrote:
> 
> > 1) When modprobing modules in order: snd-soc-fsl-spdif -> snd-soc-imx-spdif
> > -> snd-soc-spdif-tx/rx, we will fail to create imx-spdif card and dai link
> > unless we rmmod snd-soc-imx-spdif and modprobe it again due to inappropriate
> > condition of platform_driver_unregister() in probe().
> 
> The crucial bit of information here is what the "inappropriate
> condition" is - what is this trying to fix?  The code doesn't look
> obviously wrong though it does rely on the platform device registration
> taking effect immediately to actually probe which is a bit of an

It's an exact copy-n-paste of the same problem which Kirkwood stuff had
when I first looked at spdif there (presumably because Kirkwood had copied
it from somewhere.)  The basic problem is this:

- No spdif codec loaded
- Card probes
- Card creates a platform device
- Creation of the platform device triggers a uevent
- Card is attempted to be registered, but fails because no spdif codec
- Card removes platform device
- Card exits with -EPROBE_DEFER
- SPDIF codec is loaded, no device to bind to
- Since no device has been bound, no deferred probing is done.

This is a fundamental problem with any ASoC card driver which tries to
self-declare platform devices - you can't do this with deferred probing.
The struct device for the codec really really needs to not go away _even_
if the card exits with -EPROBE_DEFER.

> What should work right now is for the module to ensure that the S/PDIF
> CODEC drivers are loaded before it is by linking to some symbol from
> there.  This is a total hack though.  Nicer would be for the machine
> driver to either directly register S/PDIF DAIs (rather than devices that
> then register the DAIs) or to create a card subdevice in parallel with
> the S/PDIF ones and hook the card registration off that.

That creates much more complexity though, and adds yet more possibility
for unreliability into this.  "Keep it simple" is well worth following.

The simple thing here is to declare the codec device in the module init,
before registering the card driver, and cleaning it up at the appropriate
moment.  That way, the card platform driver gets registered and it can
be probed, and all the time that the card platform driver is registered,
the codec device is also present, ready to hook into the codec driver
when it becomes available, and thus triggering the deferred probing of
any unbound card.
