From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: RE: [PATCH] ASoC: Add max98088 CODEC driver
Date: Wed, 29 Sep 2010 17:52:08 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D46F2D9E9@ITSVLEX06.it.maxim-ic.internal>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
 <20100929033757.GB29975@opensource.wolfsonmicro.com>
 <B2150E1E4418E1438554A300EA5040E40D46F2D8D8@ITSVLEX06.it.maxim-ic.internal>
 <20100929221826.GC31934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100929221826.GC31934@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 29, 2010, Mark Brown wrote:
> On Wed, Sep 29, 2010 at 02:42:32PM -0700, Peter Hsiang wrote:
> > On Wed, Sep 29, 2010, Mark Brown wrote:
> > > On Tue, Sep 28, 2010 at 07:34:34PM -0700, Peter Hsiang wrote:
> 
> > > You should add value muxes like we have for DAPM.
> 
> > Please clarify what you mean by referencing the specific
> > code usage case in the dapm source module.
> 
> You're looking for the non-DAPM equivalent of SND_SOC_DAPM_VALUE_MUX().

This is a simple table lookup of a register value from the index
number given by SOC_ENUM, the same way it's been done in other drivers.

I found a "case snd_soc_dapm_value_mux:" in dapm_set_path_status()
Is this what you are referring to?
How is the code there relevant to this?

> 
> > > > +       /* powering down headphone gracefully */
> > > > +       status = snd_soc_read(codec, M98088_REG_4D_PWR_EN_OUT);
> > > > +       if ((status & M98088_HPEN) == M98088_HPEN) {
> > > > +               max98088_hw_write(codec, M98088_REG_4D_PWR_EN_OUT,
> > > > +                       (status & ~M98088_HPEN));
> > > > +       }
> > > > +       schedule_timeout(msecs_to_jiffies(20));
> 
> > > This looks rather like it should just be a post event implementing a
> > > timeout?
> 
> > This needs to work as a pre event.
> 
> Again, why is this?

When powering down the headphone, the way that DAPM works is it
likes to power off one item at a time, for example, the left channel,
then right channel.  The headphone hardware likes to see the 
headphone bits L and R be powered down together, for optimum result.
This works best with the pre method.  Powering up one channel at a 
time later is fine, when DAPM resumes.

> 
> > > > +       case SND_SOC_BIAS_STANDBY:
> > > > +               max98088_sync_cache(codec);
> > > > +               snd_soc_update_bits(codec, M98088_REG_4C_PWR_EN_IN,
> > > > +                               M98088_MBEN, M98088_MBEN);
> > > > +               break;
> 
> > > Do you really want to sync the cache *every* time you go into standby?
> 
> > The sync_cache function itself will just return if the
> > codec->cache_sync flag is cleared from the first time it ran.
> > You do the exact same thing in your codec driver...
> > What is the change that you are suggesting?
> 
> The cache syncs should be part of some operation which would make it
> useful to sync the cache rather than just located at some point in the
> driver without any particular reason.  For example, with the drivers
> I've worked on the cache is synced after we enable the supplies for the
> device since the CODEC may have been powered off and therefore lost any
> register settings that might have been done.  If the cache sync is not
> associated with any such event then it's at best redundant and at worst
> the driver will loose some robustness since it becomes unclear if the
> events which cause a cache sync to be required are joined up with the
> triggering of a sync.

I see :)

> 
> > > > +module_init(max98088_init);
> 
> > > Normally this would be next to the function it references.
> 
> > Is this a new formatting style of the kernel now all across,
> > or is this a personal preference?
> 
> It's a global style for the kernel, though not enforced with 100%
> success.

Haha, got it. I will help you with this statistic from now on.
