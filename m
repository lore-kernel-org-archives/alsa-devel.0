From: Simon Ho <simon.ho.cnxt@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: add support for Conexant
 CX2072X CODEC
Date: Wed, 12 Apr 2017 18:29:43 +0800
Message-ID: <20170412102943.GA11582@GMAIL.COM>
References: <cover.1491382907.git.simon.ho@conexant.com>
 <5b7e78fef2c8e299d39ebaa560d81d66e619e7eb.1491382907.git.simon.ho@conexant.com>
 <s5hwpart6iu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 768D826648D
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 12:29:48 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id i5so4253939pfc.3
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 03:29:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hwpart6iu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 11, 2017 at 03:31:37PM +0200, Takashi Iwai wrote:
> On Wed, 05 Apr 2017 11:07:14 +0200,
> <simon.ho.cnxt@gmail.com> wrote:
> > 
> > --- /dev/null
> > +++ b/sound/soc/codecs/cx2072x.c
> > +/**
> > + * cx2072x_enable_detect - Enable CX2072X jack detection
> > + * @codec : pointer variable to codec having information related to codec
> > + *
> > + */
> > +int cx2072x_enable_detect(struct snd_soc_codec *codec)
> > +{
> .....
> > +}
> > +EXPORT_SYMBOL_GPL(cx2072x_enable_detect);
> > +
> > +/*
> > + * cx2072x_get_jack_state: Return current jack state.
> > + * @codec : pointer variable to codec having information related to codec
> > + *
> > + */
> > +int cx2072x_get_jack_state(struct snd_soc_codec *codec)
> > +{
> ....
> > +}
> > +EXPORT_SYMBOL_GPL(cx2072x_get_jack_state);
> > --- /dev/null
> > +++ b/sound/soc/codecs/cx2072x.h
> ....
> > +enum cx2072x_jack_types {
> > +	CX_JACK_NONE = 0x0000,
> > +	CX_JACK_HEADPHONE = 0x0001,
> > +	CX_JACK_APPLE_HEADSET = 0x0002,
> > +	CX_JACK_NOKIE_HEADSET = 0x0003,
> > +};
> > +
> > +int cx2072x_hs_jack_report(struct snd_soc_codec *codec);
> 
> This function is nowhere defined.  And the new jack functions
> cx2072x_enable_detect() and cx2072x_get_jack_state() are not declared
> here, either.
> 
> 
> Takashi

Sorry, I did not verify this feature after jack sense code changed. 

BTW, the cx2072x_jack_types is no longer used, we can remove it.

Simon
