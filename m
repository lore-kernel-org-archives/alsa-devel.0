From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] blackfin I2S(TDM mode) CPU DAI driver
Date: Mon, 27 Jul 2009 15:40:52 +0100
Message-ID: <20090727144052.GA8900@rakim.wolfsonmicro.main>
References: <1248286234-6053-1-git-send-email-21cnbao@gmail.com>
	<1248286234-6053-2-git-send-email-21cnbao@gmail.com>
	<20090725124909.GA7284@opensource.wolfsonmicro.com>
	<3c17e3570907270300u7ccc47b5q9d0fd9039080deb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC4682457B
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jul 2009 16:40:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570907270300u7ccc47b5q9d0fd9039080deb3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 27, 2009 at 06:00:48PM +0800, Barry Song wrote:
> 2009/7/25 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > Looking at the code it appears that the main difference is that your TDM
> > mode always configures the DMA layout for 8 channel blocks. =A0This

> I2S is not a special case of TDM with only left and right two slots
> for SPORT interface. I2S coordinates with TDM in SPORT, but not a part
> of TDM. TDM require different hardware configuration with I2S, not
> only different slot number.
> One is "Stereo Serial Operation" mode of SPORT, the other one is
> "Multichannel Operation" mode. They are incompatible at the same time.

Right, but that's something I'd expect to be handleable at run time -
and in any case, the multi-channel varaint can drop down to only two
channels.

> Mainly due to hardware, it's really difficult for us to control the
> memory layout on the fly. That causes much trouble in hardware and
> driver reliability. Datasheet claims DMA buffer should be fixed while
> SPORT is enabled, but also claims the layout may be changed while
> SPORT is disabled. So it's maybe possible for us to change the SPORT
> api to support the configuration on the fly with a SPORT shutdown,
> then i2s, tdm even ac97 can all use them to reduce the amount of code
> duplication. But it need much work on debugging and testing to make it
> work and reliable. So how about to patch it later as an individual
> project since the changes will involve sport, i2s, ac97 and tdm?

OK, if the hardware is as difficult to use as that I guess the current
situation is adequate.  I'll check over your patch later but the code
was almost ready last time so I don't anticipate any problems.
However...

> >> On the other hand, hardware board connection decides the I2S/TDM mode
> >> directly. It's needless to switch between I2S and TDM dynamically. For
> >> TDM mode, board driver can refer to the TDM instance, for I2S mode,
> >
> > Are you saying that a physically different SPORT or other hardware
> > configuration on the CPU is required to use TDM mode? =A0The impression
> > given by the drivers has always been that this is some kind of generic
> > synchronous serial port and the way the SPORT number is set up seems to
> > support that. =A0Could you go into more detail here, please - this would
> > be a very unusual implementation decision for a CPU.

> Here I means the different hardware configuration, and the semantic of
> pins has some differences too for I2S and TDM.

...are you sure there's a different meaning for the external pins - what
are these differences?  If they're not just related to the number of bit
clock cycles per frame clock then are you sure it will interoperate with
other DSP mode devices?
