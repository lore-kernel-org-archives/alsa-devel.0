From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Tegra: Add support of tegra boards
 based	on ALC5632 codec
Date: Wed, 23 Nov 2011 22:46:22 +0000
Message-ID: <20111123224621.GA456@opensource.wolfsonmicro.com>
References: <1321906088-29964-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C817@HQMAIL01.nvidia.com>
	<20111123215844.GB32201@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C84C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 215A9103D4D
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 23:46:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C84C@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 02:30:12PM -0800, Stephen Warren wrote:
> Mark Brown wrote at Wednesday, November 23, 2011 2:59 PM:

> > > That said, while these values are constant right now, I think they won't
> > > always be; I think we'll need to switch between DSP mode for mono and
> > > I2S mode for stereo here; at least I /think/ that's what I remember our
> > > downstream drivers doing...

> > That would be a surprising restriction for your hardware to have.  From
> > the CODEC point of view it really doesn't care at all, all the interface
> > formats are interchangable.

> I believe Tegra20 HW "hard-codes" the channel count to 2 in I2S mode,
> And hence always pulls 2 channels from the FIFO for each frame. So, I2S
> can't do mono. This appears to be fixed in Tegra30. Tegra can be
> surprising:-)

If it's got that restriction why not run it in PCM mode all the time?
