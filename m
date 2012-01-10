From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040 - Add method to query
	optimum PDM_DL1	gain
Date: Tue, 10 Jan 2012 19:29:57 +0000
Message-ID: <20120110192957.GJ7164@opensource.wolfsonmicro.com>
References: <1326111082-11678-1-git-send-email-lrg@ti.com>
	<20120110004428.GL30766@opensource.wolfsonmicro.com>
	<1326193389.3944.8.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E22A103AF6
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 20:29:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326193389.3944.8.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 10, 2012 at 11:03:09AM +0000, Liam Girdwood wrote:
> On Tue, 2012-01-10 at 00:44 +0000, Mark Brown wrote:
> > On Mon, Jan 09, 2012 at 12:11:22PM +0000, Liam Girdwood wrote:

> > > The DL1 PDM interface adds a little gain depending on the output device.
> > > Add a method to retrieve the gain value for machine driver usage.

> > I'm having a hard time understanding how the machine driver would use
> > this information...

> It's intended that the machine driver would use this information to
> configure the ABE to compensate any attenuation so that the output
> volume level was constant.

So if you turn on some of the outputs in the CODEC the CODEC will apply
a gain to the signal coming in on DL1 which affects other CODEC outputs
and this needs to be worked around in the ABE so the machine driver is
doing that?

> > > +int twl6040_get_dl1_gain(struct snd_soc_codec *codec)
> > > +{
> > > +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> > > +
> > > +	if (snd_soc_dapm_get_pin_status(dapm, "EP"))
> > > +		return -1; /* -1dB */

> > Shouldn't this be being done by reading the CODEC register settings to
> > know which output DL1 is connected to?

> The DL1 path output devices can all operate at the same time and may or
> may not be connected by the machine drivers.

But surely the paths from DL1 to the various outputs within the CODEC
are controlled by registers in the CODEC?  I don't understand why the
CODEC needs to query DAPM here.
