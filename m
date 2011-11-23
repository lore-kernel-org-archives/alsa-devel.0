From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Tegra: Add support of tegra boards
 based	on ALC5632 codec
Date: Wed, 23 Nov 2011 21:58:44 +0000
Message-ID: <20111123215844.GB32201@opensource.wolfsonmicro.com>
References: <1321906088-29964-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C817@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 553BE103D7D
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 22:58:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C817@HQMAIL01.nvidia.com>
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

On Wed, Nov 23, 2011 at 01:50:39PM -0800, Stephen Warren wrote:
> Leon Romanovsky wrote at Monday, November 21, 2011 1:08 PM:

> > +	switch (srate) {
> > +	case 64000:
> > +	case 88200:
> > +	case 96000:
> > +		mclk = 128 * srate;
> > +		break;
> > +	default:
> > +		mclk = 512 * srate;
> > +		break;
> > +	}
> > +	/* FIXME: Codec only requires >= 3MHz if OSR==0 */
> > +	while (mclk < 6000000)
> > +		mclk *= 2;

> That is identical to the code in tegra_wm8903. Are you sure it's correct
> for the ALC5632? At the very least, I think the comment is wrong; OSR is
> a WM8903 register field, which I doubt exists on the ALC5632.

I wouldn't be surprised if it were actually - the requirements for
CODECs are generally much of a muchness, there's good sensible DSP and
electrical engineering requirmenents for them.

> Mark Brown wrote here:
> > These should use the .dai_fmt member in the dai_link struct.

> Mark, I guess you mean that we should remove those two snd_soc_dai_set_fmt
> calls, and just set .dai_fmt to a constant value? If so, that should be
> applied to the other two Tegra machine drivers too.

Yes.

> That said, while these values are constant right now, I think they won't
> always be; I think we'll need to switch between DSP mode for mono and
> I2S mode for stereo here; at least I /think/ that's what I remember our
> downstream drivers doing...

That would be a surprising restriction for your hardware to have.  From
the CODEC point of view it really doesn't care at all, all the interface
formats are interchangable.

> > +static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpios[] = {
> > +	{

...

> Do you need to call something in the ALC5632 codec driver here to start
> mic detection? The tegra_wm8903 driver calls wm8903_mic_detect() here.

It's not using the CODEC for detection, it's using a simple GPIO for tip
detect.

> > +MODULE_LICENSE("GPL");

> The comment at the top would imply "GPL v2", since no "or later" is
> mentioned there. Yes, the existing Tegra code is probably wrong here too.

GPL v2 is the standard interpretation for GPL within the kernel given
that that is the license of the kernel itself.  I'd only bother saying
anything different if the license were different but it won't do any
harm.
