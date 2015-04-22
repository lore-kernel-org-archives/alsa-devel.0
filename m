From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v7 3/7] ALSA: jack: extend snd_jack_new to
 support phantom jack
Date: Wed, 22 Apr 2015 02:51:45 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551CDD5@SHSMSX101.ccr.corp.intel.com>
References: <1429603545-21063-1-git-send-email-yang.jie@intel.com>
 <1429603545-21063-4-git-send-email-yang.jie@intel.com>
 <s5hoamhztvt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0DE26047F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 04:51:53 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Jie, Yang
> Sent: Wednesday, April 22, 2015 10:07 AM
> To: 'Takashi Iwai'
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: RE: [PATCH v7 3/7] ALSA: jack: extend snd_jack_new to support
> phantom jack
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Tuesday, April 21, 2015 5:57 PM
> > To: Jie, Yang
> > Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> > Subject: Re: [PATCH v7 3/7] ALSA: jack: extend snd_jack_new to support
> > phantom jack
> >
> > At Tue, 21 Apr 2015 16:05:41 +0800,
> > Jie Yang wrote:
> > >
> > > For phantom jack, we won't create real jack device, but jack kctl
> > > may be needed.
> > >
> > > Here, we extend snd_jack_new() to support phantom jack creating:
> > > pass in a bool param for [non-]phantom flag, and a non-Null param
> > > (struct snd_jack_kctl **) to indicate that we need create kctl at
> > > this jack creating stage.
> > >
> > > We can also add kctl to a jack after the jack is created.
> > >
> > > This make the integrating the existing HDA jack kctl and soc jack
> > > kctl possible.
> > >
> > > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > > ---
> > >  include/sound/jack.h            |  4 +--
> > >  sound/core/jack.c               | 56 +++++++++++++++++++++++++------------
> --
> > --
> > >  sound/pci/hda/hda_jack.c        |  2 +-
> > >  sound/pci/oxygen/xonar_wm87x6.c |  2 +-
> > >  sound/soc/soc-jack.c            |  2 +-
> > >  5 files changed, 39 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/include/sound/jack.h b/include/sound/jack.h index
> > > 9781e75..34b6849 100644
> > > --- a/include/sound/jack.h
> > > +++ b/include/sound/jack.h
> > > @@ -93,7 +93,7 @@ struct snd_jack_kctl {  #ifdef CONFIG_SND_JACK
> > >
> > >  int snd_jack_new(struct snd_card *card, const char *id, int type,
> > > -		 struct snd_jack **jack);
> > > +		 struct snd_jack **jack, bool phantom_jack, struct
> > snd_jack_kctl
> > > +**jjack_kctl);
> > >  int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name,
> > > int mask);  void snd_jack_set_parent(struct snd_jack *jack, struct
> > > device *parent);  int snd_jack_set_key(struct snd_jack *jack, enum
> > > snd_jack_types type, @@ -103,7 +103,7 @@ void snd_jack_report(struct
> > > snd_jack *jack, int status);
> > >
> > >  #else
> > >  static inline int snd_jack_new(struct snd_card *card, const char
> > > *id, int
> > type,
> > > -			       struct snd_jack **jack)
> > > +			       struct snd_jack **jack, bool phantom_jack, struct
> > > +snd_jack_kctl **jjack_kctl)
> > >  {
> > >  	return 0;
> > >  }
> > > diff --git a/sound/core/jack.c b/sound/core/jack.c index
> > > b13d0b1..edd55c8 100644
> > > --- a/sound/core/jack.c
> > > +++ b/sound/core/jack.c
> > > @@ -198,6 +198,10 @@ EXPORT_SYMBOL(snd_jack_add_new_kctl);
> > >   * @type:  a bitmask of enum snd_jack_type values that can be
> > > detected
> > by
> > >   *         this jack
> > >   * @jjack: Used to provide the allocated jack object to the caller.
> > > + * @phantom_jack: for phantom jack, only create needed kctl, won't
> > create
> > > + *         real jackdevice
> > > + * @jjack_kctl: create kctl if non-NULL pointer passed in, and provide it
> to
> > > + *         the caller. also add it to the non-phantom jack kctl list
> > >   *
> > >   * Creates a new jack object.
> > >   *
> > > @@ -205,7 +209,7 @@ EXPORT_SYMBOL(snd_jack_add_new_kctl);
> > >   * On success @jjack will be initialised.
> > >   */
> > >  int snd_jack_new(struct snd_card *card, const char *id, int type,
> > > -		 struct snd_jack **jjack)
> > > +		 struct snd_jack **jjack, bool phantom_jack, struct
> > snd_jack_kctl
> > > +**jjack_kctl)
> >
> > The caller doesn't need to get struct snd_jack_kctl.  Instead, it's
> > better to get struct snd_kcontrol.  In that way, you can move the
> > definition of struct snd_jack_kctl locally into jack.c.  It's merely
> > an internal object only for jack after all.
> 
> That's good. Will change it.
 
We can change it more, caller even don't need struct snd_kcontrol,
I am think of using a bool initial_kctl to indicate if we need create
kcontrol with jack id at this jack creating stage.

Then Jack will handle kcontrol totally, caller don't need care them
at all.

> 
> >
> > >  {
> > >  	struct snd_jack *jack;
> > >  	int err;
> > > @@ -216,35 +220,43 @@ int snd_jack_new(struct snd_card *card, const
> > char *id, int type,
> > >  		.dev_disconnect = snd_jack_dev_disconnect,
> > >  	};
> > >
> > > -	jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
> > > -	if (jack == NULL)
> > > -		return -ENOMEM;
> > > +	if (jjack_kctl)
> > > +		*jjack_kctl = snd_jack_kctl_new(card, id, type);
> > >
> > > -	jack->id = kstrdup(id, GFP_KERNEL);
> > > +	/* don't creat real jack device for phantom jack */
> > > +	if (!phantom_jack) {
> > > +		jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
> >
> > We need to create a jack object even for a phantom jack.  It's the
> > place managing the list of kctls.  Otherwise we can't track these kctls.
> >
> > Just skip creating jack->input_dev for phantom jacks.
> 
> Sounds good, if the extra jack devices have no side effect.
> 
> >
> >
> > Takashi
