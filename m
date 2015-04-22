From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v8 3/7] ALSA: jack: extend snd_jack_new to
 support phantom jack
Date: Wed, 22 Apr 2015 12:49:15 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551E265@SHSMSX101.ccr.corp.intel.com>
References: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
 <1429682633-10765-4-git-send-email-yang.jie@intel.com>
 <s5hd22wmmcn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 19B98260586
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 14:56:20 +0200 (CEST)
In-Reply-To: <s5hd22wmmcn.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tanu.kaskinen@linux.intel.com" <tanu.kaskinen@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, April 22, 2015 7:31 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> tanu.kaskinen@linux.intel.com
> Subject: Re: [PATCH v8 3/7] ALSA: jack: extend snd_jack_new to support
> phantom jack
> 
> At Wed, 22 Apr 2015 14:03:49 +0800,
> Jie Yang wrote:
> >
> > diff --git a/sound/core/jack.c b/sound/core/jack.c index
> > b13d0b1..6c729ef 100644
> > --- a/sound/core/jack.c
> > +++ b/sound/core/jack.c
> > @@ -198,6 +198,9 @@ EXPORT_SYMBOL(snd_jack_add_new_kctl);
> >   * @type:  a bitmask of enum snd_jack_type values that can be detected
> by
> >   *         this jack
> >   * @jjack: Used to provide the allocated jack object to the caller.
> > + * @phantom_jack: for phantom jack, only create needed kctl, won't
> create
> > + *         input device
> > + * @initial_kctl: create kctl if true, also add it to the non-phantom
> > + jack kctl list
> 
> Better to align with the actual argument order.
 
OK, will update it, together with that for documentation in patch 7/7.

> 
> >   *
> >   * Creates a new jack object.
> >   *
> > @@ -205,9 +208,10 @@ EXPORT_SYMBOL(snd_jack_add_new_kctl);
> >   * On success @jjack will be initialised.
> >   */
> >  int snd_jack_new(struct snd_card *card, const char *id, int type,
> > -		 struct snd_jack **jjack)
> > +		 struct snd_jack **jjack, bool initial_kctl, bool phantom_jack)
> >  {
> >  	struct snd_jack *jack;
> > +	struct snd_jack_kctl *jack_kctl = NULL;
> >  	int err;
> >  	int i;
> >  	static struct snd_device_ops ops = { @@ -216,26 +220,33 @@ int
> > snd_jack_new(struct snd_card *card, const char *id, int type,
> >  		.dev_disconnect = snd_jack_dev_disconnect,
> >  	};
> >
> > +	if (initial_kctl)
> > +		jack_kctl = snd_jack_kctl_new(card, id, type);
> > +
> 
> The function should return -ENOMEM if snd_jack_kctl_new() fails.
> 
> >  	jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
> >  	if (jack == NULL)
> >  		return -ENOMEM;
> >
> >  	jack->id = kstrdup(id, GFP_KERNEL);
> >
> > -	jack->input_dev = input_allocate_device();
> > -	if (jack->input_dev == NULL) {
> > -		err = -ENOMEM;
> > -		goto fail_input;
> > -	}
> > +	/* don't creat input device for phantom jack */
> > +	if (!phantom_jack) {
> > +		jack->input_dev = input_allocate_device();
> > +		if (jack->input_dev == NULL) {
> > +			err = -ENOMEM;
> > +			goto fail_input;
> > +		}
> >
> > -	jack->input_dev->phys = "ALSA";
> > +		jack->input_dev->phys = "ALSA";
> >
> > -	jack->type = type;
> > +		jack->type = type;
> >
> > -	for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
> > -		if (type & (1 << i))
> > -			input_set_capability(jack->input_dev, EV_SW,
> > -					     jack_switch_types[i]);
> > +		for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
> > +			if (type & (1 << i))
> > +				input_set_capability(jack->input_dev,
> EV_SW,
> > +						     jack_switch_types[i]);
> > +
> > +	}
> >
> >  	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
> >  	if (err < 0)
> > @@ -244,6 +255,9 @@ int snd_jack_new(struct snd_card *card, const char
> *id, int type,
> >  	jack->card = card;
> >  	INIT_LIST_HEAD(&jack->kctl_list);
> >
> > +	if (initial_kctl && jack_kctl)
> 
> ... then here no need to check both.
 
Good, will change it soon.

> 
> 
> Takashi
