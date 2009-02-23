From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: idt blue jack patch
Date: Mon, 23 Feb 2009 20:58:20 +0800
Message-ID: <20090223125820.GA7403@localhost>
References: <s5hk57nzs1h.wl%tiwai@suse.de> <20090219030212.GA26505@localhost>
	<1235013772.27435.118.camel@razman>
	<20090220010001.GA7520@localhost> <s5hbpsx10yg.wl%tiwai@suse.de>
	<20090221014214.GB6175@localhost>
	<s5hljrzu53u.wl%tiwai@suse.de> <s5h7i3h4joz.wl%tiwai@suse.de>
	<20090223095351.GA18093@localhost> <s5h3ae51mjl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 370A910387A
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 13:58:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3ae51mjl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Paulo Cavalcanti <promac@gmail.com>, Vedran =?utf-8?Q?Mileti=C4=87?= <rivanvx@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 23, 2009 at 12:21:18PM +0200, Takashi Iwai wrote:
> At Mon, 23 Feb 2009 17:53:51 +0800,
> Wu Fengguang wrote:
> > 
> > On Mon, Feb 23, 2009 at 10:54:36AM +0200, Takashi Iwai wrote:
> > > At Sat, 21 Feb 2009 17:28:21 +0100,
> > > I wrote:
> > > > > > Regarding the default pin configurations.
> > > > > > I made a series of patches to add the interface to change the default
> > > > > > pincfg values dynamically via hwdep sysfs.  The patches are found in
> > > > > > test/hda-pincfg branch of sound git tree
> > > > > >     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > > > > > 
> > > > > > and included in the very latest alsa-driver-unstable snapshot
> > > > > >     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
> > > > > > 
> > > > > > Basically, you can get / set the default pincfg values on the fly, and
> > > > > > trigger the codec reconfiguration after that.
> > > > > > 
> > > > > > The init_pin_configs file shows the initial default pincfgs set by BIOS.
> > > > > > 
> > > > > > 	# cat /sys/class/sound/hwC0D0/init_pin_configs
> > > > > > 	0x14 0x9993013f
> > > > > > 	0x15 0x01014c10
> > > > > > 	0x16 0x99030120
> > > > > > 	0x18 0x01a19c30
> > > > > > 	0x19 0x02a11c31
> > > > > > 	0x1a 0x01813c32
> > > > > > 	0x1b 0x02211c1f
> > > > > > 	0x1c 0x99330133
> > > > > > 	0x1d 0x411111f0
> > > > > > 	0x1e 0x411111f0
> > > > > > 	0x1f 0x411111f0
> > > > > > 
> > > > > > Then, you can override the default value by writing to
> > > > > > override_pin_configs sysfs file.
> > > > > > 
> > > > > > 	# cat /sys/class/sound/hwC0D0/override_pin_configs
> > > > > > 	# echo 0x1d 0x02a11c30 > /sys/class/sound/hwC0D0/override_pin_configs
> > > > > > 	# cat /sys/class/sound/hwC0D0/override_pin_configs
> > > > > > 	0x1d 0x02a11c30
> > > > > > 
> > > > > > Note that this value won't appear in init_pin_configs.
> > > > > > 
> > > > > > Also, there is another file, cur_pin_configs.  This contains the
> > > > > > pincfgs that are set by the driver explicitly.  For example,
> > > > > > the static pincfg table in patch_sigmatel.c appears here.
> > > > > > 
> > > > > > Then you can trigger the codec reconfiguration by
> > > > > > 
> > > > > > 	# echo 1 > /sys/class/sound/hwC0D0/reconfig
> > > > > > 
> > > > > > This will re-setup the driver based on the given pin configs.
> > > > > 
> > > > > Cool!  This interface will greatly ease the developer-user interactions.
> > > > > 
> > > > > Without knowing this feature, I had to write a patch for Paulo,
> > > > > and compile/verify it before sending it to him. Paulo also have to
> > > > > pull the kernel source, apply the patch, compile and run it...
> > > > > 
> > > > > Now you turned that tedious process into two simple echo commands :-)
> > > > > 
> > > > > > Unfortunately, in the current scenario, it can't override the static
> > > > > > pincfg table in the driver like in patch_sigmatel.c.  It's just for
> > > > > > fixing and BIOS setup.
> > > > > 
> > > > > Unfortunately patch_sigmatel has a long list of static pincfgs, i.e.:
> > > > > 
> > > > >         static unsigned int ref927x_pin_configs[14] = {
> > > > >                 0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
> > > > >                 0x01a19040, 0x01011012, 0x01016011, 0x0101201f,
> > > > >                 0x183301f0, 0x18a001f0, 0x18a001f0, 0x01442070,
> > > > >                 0x01c42190, 0x40000100,
> > > > >         };
> > > > > 
> > > > > This effectively prohibits itself from being dynamically reconfigured
> > > > > via the override_pin_configs interface... 
> > > > 
> > > > Right.  Considering the implementation again, I think it must be
> > > > relatively easy to fix that.  Just changing the order of the evaluation
> > > > of pincfg, and add the check not to overwrite the value.
> > > > 
> > > > I'll work on it in the next week.
> > > 
> > > Fixed now on sound-unstable tree, together with renaming of override_pin
> > > and cur_pin to user_pin and driver_pin.
> > > 
> > > It'd be appreciated if someone can test it with a device with
> > > Sigmatel/IDT (as I have no such hardware)...
> > 
> > Hi Takashi,
> > 
> > Here are the good behaviors:
> > 
> > - the driver_pin_configs matches the numbers defined in source code
> > - the init_pin_configs/user_pin_configs will be exactly restored between module reloading
> > - setting user_pin_configs and doing reconfig did changed the 0x0c pin from output to input.
> > 
> > However,
> > 
> > - after reconfig, Surround, Center and LFE channels are muted and have to be
> >   turned on again in alsamixer.
> 
> That's a feature.  You can restore via "alsactl restore"

Ah OK, I'd take it as a workaround ;-)

> > - if reconfig while playing audio, it will trigger a panic:
> 
> Ah, that's bad.  I know this can be a problem (and thus is marked as
> EXPERIMENTAL :)
> 
> We need some mutex and/or flag to disable the reconfig during the
> critical operation.

It won't be a trivial work. The reset/rebuild is a long and complex process.
For the moment I'd suggest to simply fail reconfig if there are active streams,
so as to let this useful feature go upstream ASAP.

Thanks,
Fengguang
