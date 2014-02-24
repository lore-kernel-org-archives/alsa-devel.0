From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 3/6] ASoC: Intel: Add Haswell and Broadwell
 PCM platform driver
Date: Mon, 24 Feb 2014 20:00:50 +0000
Message-ID: <1393272050.2323.68.camel@loki>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-3-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140221051603.GC25940@sirena.org.uk> <s5htxbtvt2n.wl%tiwai@suse.de>
 <20140223031958.GX25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E775261ADC
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 21:01:25 +0100 (CET)
In-Reply-To: <20140223031958.GX25940@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2014-02-23 at 12:19 +0900, Mark Brown wrote:
> On Fri, Feb 21, 2014 at 08:11:12AM +0100, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > Interesting one here.  On the one hand we always say to present the
> > > hardware features as directly as possible to the application layer.  On
> > > the other hand I'd not be surprised if some userspaces failed to deal
> > > constructively with a full 31 bits of linearly mapped volume control
> > > (but I'm not sure how common they are and really they ought to be
> > > fixed).  Anyway, not a problem more just a comment.
> 
> > A straightforward implementation would be just to expose this 31bit
> > raw value and declare it as a linear dB via TLV.  The proper dB
> > conversion is done in alsa-lib.
> 
> Yes, exactly.  This should work well with most userspaces, the only
> thing that would worry me would be something basic that makes the user
> manually step through thousands of tiny volume steps.  I don't think any
> modern application layer should have an issue there though and I'm not
> sure if I'd care about such application layers myself.
> 
> > BTW, you need no table for this volume value at all.  volume_map[] can
> > be replaced like
> > 	#define volume_map(i)	((1U << (i) - 1)
> 
> It does mean it's easier to update the chosen steps in future though.
> 

Fwiw, the table was going to be replaced with a similar table that did
not have exact power of 2 values. This was just temporary until I had
some more time to build the correct table.

I should get some time to add the table after BYT upstream.

> > > > +	if (!pcm_data->stream) {
> > > > +		pcm_data->volume[0] =
> > > > +			hsw_mixer_to_ipc(ucontrol->value.integer.value[0]);
> > > > +		pcm_data->volume[1] =
> > > > +			hsw_mixer_to_ipc(ucontrol->value.integer.value[1]);
> > > > +		mutex_unlock(&pcm_data->mutex);
> > > > +		return 0;
> > > > +	}
> 
> > > It looks like we only record the volume when the stream is idle.  What
> > > happens if the user changes the volume while it's idle, starts playing,
> > > changes again then stops playing?  It's possible I missed the bit where
> > > it gets saved but I did look.
> 
> > This seems restored in hsw_pcm_open().
> 
> Yes, it's restored there - what concerned me was that the variables
> didn't seem to be being updated while the stream was running, it only
> wrote to the hardware so if the volume had subsequently been changed on
> a running stream then the older value from a closed stream would be
> written out.  It'd at least be more obviously correct to just update the
> variables no matter what.

Will check and fix this, it may be a regression at my end.

Liam 
