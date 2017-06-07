From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: dapm: Add new widget type for
 constructing DAPM graphs on DSPs.
Date: Wed, 07 Jun 2017 21:00:51 +0100
Message-ID: <1496865651.31880.133.camel@loki>
References: <1496760282-6147-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20170607192304.thekfsvzy7mc7lgl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C108B267193
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 22:01:00 +0200 (CEST)
In-Reply-To: <20170607192304.thekfsvzy7mc7lgl@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2017-06-07 at 20:23 +0100, Mark Brown wrote:
> On Tue, Jun 06, 2017 at 03:44:42PM +0100, Liam Girdwood wrote:
> 
> > +	snd_soc_dapm_buffer,		/* DSP/CODEC internal buffer */
> > +	snd_soc_dapm_pipeline,		/* DSP/CODEC internal pipeline */
> > +	snd_soc_dapm_effect,		/* DSP/CODEC effect component */
> 
> What's the difference between a buffer and a pipeline, or between a
> pipeline and an effect?  We should have clear documentation, if they're
> different we're probably going to end up using them differently in the
> core at some point and if people use the wrong widget type it might end
> up breaking things.

Yes, that's a good point. I'll do a V2 that includes some documentation.

> 
> > +	snd_soc_dapm_codec,		/* FW/SW coder/decoder component */
> 
> Can we call this a fmt_conv or something?  CODEC is unfortunately a bit
> overloaded.

True, what about snd_soc_dapm_media_codec ? or _sw_codec ? or
_media_decoder ?

Liam

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
