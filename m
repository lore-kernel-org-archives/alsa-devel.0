From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Tegra: Add support of tegra boards
 based	on ALC5632 codec
Date: Wed, 23 Nov 2011 14:30:12 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C84C@HQMAIL01.nvidia.com>
References: <1321906088-29964-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C817@HQMAIL01.nvidia.com>
	<20111123215844.GB32201@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id DF983103B20
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 23:30:20 +0100 (CET)
In-Reply-To: <20111123215844.GB32201@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Wednesday, November 23, 2011 2:59 PM:
> On Wed, Nov 23, 2011 at 01:50:39PM -0800, Stephen Warren wrote:
> > Leon Romanovsky wrote at Monday, November 21, 2011 1:08 PM:
...
> > Mark Brown wrote here:
> > > These should use the .dai_fmt member in the dai_link struct.
> 
> > Mark, I guess you mean that we should remove those two snd_soc_dai_set_fmt
> > calls, and just set .dai_fmt to a constant value? If so, that should be
> > applied to the other two Tegra machine drivers too.
> 
> Yes.
> 
> > That said, while these values are constant right now, I think they won't
> > always be; I think we'll need to switch between DSP mode for mono and
> > I2S mode for stereo here; at least I /think/ that's what I remember our
> > downstream drivers doing...
> 
> That would be a surprising restriction for your hardware to have.  From
> the CODEC point of view it really doesn't care at all, all the interface
> formats are interchangable.

I believe Tegra20 HW "hard-codes" the channel count to 2 in I2S mode,
And hence always pulls 2 channels from the FIFO for each frame. So, I2S
can't do mono. This appears to be fixed in Tegra30. Tegra can be
surprising:-)

> > > +MODULE_LICENSE("GPL");
> 
> > The comment at the top would imply "GPL v2", since no "or later" is
> > mentioned there. Yes, the existing Tegra code is probably wrong here too.
> 
> GPL v2 is the standard interpretation for GPL within the kernel given
> that that is the license of the kernel itself.  I'd only bother saying
> anything different if the license were different but it won't do any
> harm.

I mentioned this, because of the following in include/linux/module.h

* The following license idents are currently accepted as indicating free
* software modules
*
*      "GPL"                           [GNU Public License v2 or later]
*      "GPL v2"                        [GNU Public License v2]

-- 
nvpublic
