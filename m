From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Tegra: Add support of tegra boards
 based	on ALC5632 codec
Date: Wed, 23 Nov 2011 15:31:43 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C886@HQMAIL01.nvidia.com>
References: <1321906088-29964-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C817@HQMAIL01.nvidia.com>
	<20111123215844.GB32201@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C84C@HQMAIL01.nvidia.com>
	<20111123224621.GA456@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 29C4D103D1D
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 00:31:51 +0100 (CET)
In-Reply-To: <20111123224621.GA456@opensource.wolfsonmicro.com>
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

Mark Brown wrote at Wednesday, November 23, 2011 3:46 PM:
> On Wed, Nov 23, 2011 at 02:30:12PM -0800, Stephen Warren wrote:
> > Mark Brown wrote at Wednesday, November 23, 2011 2:59 PM:
> 
> > > > That said, while these values are constant right now, I think they won't
> > > > always be; I think we'll need to switch between DSP mode for mono and
> > > > I2S mode for stereo here; at least I /think/ that's what I remember our
> > > > downstream drivers doing...
> 
> > > That would be a surprising restriction for your hardware to have.  From
> > > the CODEC point of view it really doesn't care at all, all the interface
> > > formats are interchangable.
> 
> > I believe Tegra20 HW "hard-codes" the channel count to 2 in I2S mode,
> > And hence always pulls 2 channels from the FIFO for each frame. So, I2S
> > can't do mono. This appears to be fixed in Tegra30. Tegra can be
> > surprising:-)
> 
> If it's got that restriction why not run it in PCM mode all the time?

That's a good idea. The internal feedback is that should work.

Leon, I'd suggest just hard-coding the current values into .dai_fmt as
Mark suggested. I'll take an action to investigate switching to DSP/PCM
mode, mono support, and switching the machine drivers (and I2S driver)
to it.

-- 
nvpublic
