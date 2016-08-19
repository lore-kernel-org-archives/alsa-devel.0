From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH for 4.8] ASoC: omap-abe-twl6040: Correct dmic-codec
 device registration
Date: Fri, 19 Aug 2016 09:54:04 +0100
Message-ID: <20160819085404.GI1041@n2100.armlinux.org.uk>
References: <20160819063424.16383-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160819063424.16383-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2016 at 09:34:24AM +0300, Peter Ujfalusi wrote:
> The dmic-codec was registered within the platform_driver's probe function,
> which can cause deferred probe to run in loops as reported and analyzed by
> Russell King.
> 
> Use module_init/exit in the driver and handle the dmic-codec device
> registration and removal at that level instead of the platform_driver
> probe/remove.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reported-by: Russell King <linux@arm.linux.org.uk>

I think this address came from memory... it's certainly not the one that
I'm using today. ;)

> ---

This certainly fixes the problem:

VUSB: disabling
mmcblk0: mmc0:0002 00000 972 MiB
ALSA device list:
 mmcblk0: p1 p2
  No soundcards found.
omap-abe-twl6040 sound: ASoC: CPU DAI (null) not registered
omap-abe-twl6040 sound: snd_soc_register_card() failed: -517
Waiting 2 sec before mounting root device...
EXT4-fs (mmcblk0p2): mounting ext3 file system using the ext4 subsystem
EXT4-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck is recommended

and allows booting to continue.  Thanks.

Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
