From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [for-next] NULL pointer dereference in codec probe
Date: Thu, 30 Apr 2015 13:53:52 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9055239BC@SHSMSX101.ccr.corp.intel.com>
References: <87fv7i9bgu.fsf@intel.com>	<s5hr3r1ewyt.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A905523951@SHSMSX101.ccr.corp.intel.com>
 <s5hfv7heo96.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id ACF322618ED
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 15:53:58 +0200 (CEST)
In-Reply-To: <s5hfv7heo96.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: "Nikula, Jani" <jani.nikula@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Tian,
 YeX" <yex.tian@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, April 30, 2015 9:32 PM
> To: Jie, Yang
> Cc: Nikula, Jani; Jaroslav Kysela; alsa-devel@alsa-project.org; Tian, YeX
> Subject: Re: [for-next] NULL pointer dereference in codec probe
> 
> At Thu, 30 Apr 2015 12:27:52 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Jie, Yang
> > > Sent: Thursday, April 30, 2015 7:08 PM
> > > To: 'Takashi Iwai'; Nikula, Jani
> > > Cc: Jaroslav Kysela; alsa-devel@alsa-project.org; Tian, YeX
> > > Subject: RE: [for-next] NULL pointer dereference in codec probe
> > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Thursday, April 30, 2015 6:23 PM
> > > > To: Nikula, Jani
> > > > Cc: Jaroslav Kysela; alsa-devel@alsa-project.org; Tian, YeX; Jie,
> > > > Yang
> > > > Subject: Re: [for-next] NULL pointer dereference in codec probe
> > > >
> > > > At Thu, 30 Apr 2015 13:06:41 +0300, Jani Nikula wrote:
> > > > >
> > > > >
> > > > > Hi all, our graphics QA found an issue [1] with the for-next
> > > > > branch of [2] merged on top of v4.1-rc1. Backtrace in the bug. I
> > > > > didn't really have time to look into the details, but just letting you
> know.
> > > >
> > > > Looks like the new jack stuff broke something.  Keyon, could you
> > > > take a
> > > look?
> > >
> > > I noticed this today and root caused it. Will provide a patch for it
> tomorrow.
> >
> > I just worked out a patch[1] to fix it. no chance to test it yet.
> > will send it to ML once it passed my testing tomorrow.
> >
> > [1] https://bugs.freedesktop.org/attachment.cgi?id=115474
> 
> I could reproduce the problem on my machine, and checked your patch.
> It's good per se, but it doesn't suffice.  We have to cover all
> jack->input_dev accesses.  The additional fix patch is attached
> below.
> 
> Since the bug is fixed by these patches, I'm going to queue them to
> topic/jack and for-next branch.
 
Cool! Thank you Takashi! Then I don't need go to work on May Day.
I can try those patches next Monday.

~Keyon

> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: jack: Fix another NULL dereference due to empty
> input  jack
> 
> Another fixes for NULL jack->input_dev in some places in jack.c.
> 
> Fixes: 2ba2dfa1fcc7 ('ALSA: hda - Update to use the new jack kctls method')
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/jack.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/core/jack.c b/sound/core/jack.c index
> 0dbd618e3c94..eb66327b5f1c 100644
> --- a/sound/core/jack.c
> +++ b/sound/core/jack.c
> @@ -87,6 +87,10 @@ static int snd_jack_dev_register(struct snd_device
> *device)
> 
>  	snprintf(jack->name, sizeof(jack->name), "%s %s",
>  		 card->shortname, jack->id);
> +
> +	if (!jack->input_dev)
> +		return 0;
> +
>  	jack->input_dev->name = jack->name;
> 
>  	/* Default to the sound card device. */ @@ -278,6 +282,8 @@
> EXPORT_SYMBOL(snd_jack_new);  void snd_jack_set_parent(struct
> snd_jack *jack, struct device *parent)  {
>  	WARN_ON(jack->registered);
> +	if (!jack->input_dev)
> +		return;
> 
>  	jack->input_dev->dev.parent = parent;
>  }
> --
> 2.3.6
