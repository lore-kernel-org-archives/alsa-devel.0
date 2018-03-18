From: Matt Porter <mporter@konsulko.com>
Subject: Re: [PATCH 2/2] ASoC: add tda7419 audio processor
	driver
Date: Sun, 18 Mar 2018 13:21:59 -0400
Message-ID: <20180318172159.cp3qfyprfkk6rueb@bacon.ohporter.com>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-3-mporter@konsulko.com>
 <20180228110038.GA6722@sirena.org.uk>
 <20180309143548.xuajwfhiwuua7jg5@bacon.ohporter.com>
 <20180309152912.GF5252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 42FA6266F1C
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 18:22:03 +0100 (CET)
Received: by mail-io0-f195.google.com with SMTP id m22so17995155iob.12
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 10:22:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180309152912.GF5252@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 09, 2018 at 03:29:12PM +0000, Mark Brown wrote:
> On Fri, Mar 09, 2018 at 09:35:48AM -0500, Matt Porter wrote:
> > On Wed, Feb 28, 2018 at 11:00:38AM +0000, Mark Brown wrote:
> > > On Tue, Feb 27, 2018 at 05:51:28PM -0500, Matt Porter wrote:
> 
> > > > +static struct snd_kcontrol_new tda7419_controls[] = {
> > > > +SOC_ENUM("Main Source Select", soc_enum_main_src_sel),
> 
> > > Should this be a DAPM route?
> 
> > Ultimately yes. I initially took the path of ignoring DAPM support in
> > interests of getting some clean done. Is it ok to merge DAPM support
> > later or do you prefer just having it in the intitial driver? For
> > routes, it'll include Main/Second source selects, the Rear Source
> > switch, and Mix enable at least.
> 
> You definitely shouldn't be implementing things that should be in DAPM
> as non-DAPM controls.

Ok, I addressed this by adding DAPM support in v2.

> > > > +	regmap_write(tda7419->regmap, TDA7419_ATTENUATOR_SUB_REG, 0xe0);
> 
> > > This looks like it's setting default volumes - just leave those at the
> > > chip defaults and let userspace handle setting them, what works for one
> > > board may be totally inappropriate on another board and using the chip
> > > default means we've got some fixed thing we don't need to discuss.
> 
> > This is actually setting the default/cache to the first mute value due
> > to the assumption in my implementation of the tda7419-specific get/set
> > for these registers. It simplified the code a bit to have these
> > initialized like this. e.g. for the attenuator group of registers,
> > x11xxxxx are all mute values, so 0xe0 is setting these regs to that
> > first mute value to simplify things. I'll take another look at
> > eliminating this. As it is, it does not change the fact that the actual
> > reset value of 0xff is also mute from a user POV.
> 
> If it is useful it definitely needs a comment explaining what's
> happening and that there's no practical change to the configuration.  It
> would be nicer to be robust against the device getting a wider range of
> values in the register but that seems plausible.

I did some rework to make this unnecessary in v2.

Thanks,
Matt
