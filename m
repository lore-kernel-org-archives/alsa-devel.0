From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: only check VDDD-supply, not
 revision
Date: Mon, 6 Jun 2016 01:16:26 +0200
Message-ID: <20160605231626.GA4076@archie.localdomain>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
 <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
 <5751AEF6.40200@nelint.com>
 <575264A4.2070709@nelint.com>
 <20160604090324.GA867@archie.localdomain>
 <20160604171525.GA29266@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160604171525.GA29266@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Nelson <eric@nelint.com>, Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Eric, Fabio, Mark,

On Sat, Jun 04, 2016 at 07:15:25PM +0200, Clemens Gruber wrote:
> please don't merge the patch yet, I just observed a strange effect when
> resetting the board during playback / just after playback stops.
> At next boot time, sometimes the following error occurs:
> imx-sgtl5000 sound: ASoc: CODEC DAI sgtl5000 not registered
> imx-sgtl5000 sound: snd_soc_register_card failed (-517)

I looked into this today and discovered the following:

With my patch applied, if I reset the board just after playback, at the
next boot, the sgtl5000_fill_defaults function does not succeed: Writing
the default value 0x7060 to register 0x30 (CHIP_ANA_POWER) fails.

How did CHIP_ANA_POWER change with my patch: Before, only
LINREG_SIMPLE_POWERUP was cleared as is recommended in the datasheet
when using the internal LDO, now both LINREG_SIMPLE_POWERUP and
STARTUP_POWERUP are cleared, as is recommended when using external VDDD.

But why does the SGTL5000 nack that default write to CHIP_ANA_POWER
after a reboot, which interrupted the playback?

The following patch from Eric solved the problem; one write fails but it
continues setting the other registers and thus even if resetting a board
during playback, the sound still works after reboot:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088356.html
Another workaround might be to not even write a default value to
CHIP_ANA_POWER, as in this patch from Eric:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088355.html

What do you think we should do?

Regards,
Clemens
