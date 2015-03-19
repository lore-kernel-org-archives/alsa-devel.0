From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH] ALSA: jack: create jack kcontrols for
 every jack input device
Date: Thu, 19 Mar 2015 09:02:22 +0000
Message-ID: <1426755742.7258.12.camel@loki>
References: <1426754418-13477-1-git-send-email-yang.jie@intel.com>
 <1426755215.7258.9.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BD9F0260309
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 10:02:29 +0100 (CET)
In-Reply-To: <1426755215.7258.9.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-03-19 at 08:53 +0000, Liam Girdwood wrote:
> On Thu, 2015-03-19 at 16:40 +0800, Jie Yang wrote:
> > From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > 
> 
> I cant claim much credit for this as it's mostly your work now :)
> 
> Liam

Sorry, I had more comments below... also got one more new one

> 
> > Currently the ALSA jack core registers only input devices for each jack
> > registered. These jack input devices are not readable by userspace devices
> > that run as non root.
> > 
> > This patch adds support for additionally registering jack kcontrol devices
> > for every input jack registered. This allows non root userspace to read
> > jack status.
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > Modified-by: Jie Yang <yang.jie@intel.com>
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > Reveiwed-by: Mark Brown <broonie@kernel.org>
> > ---
> >  include/sound/control.h |  2 ++
> >  include/sound/jack.h    |  2 ++
> >  sound/core/jack.c       | 89 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 91 insertions(+), 2 deletions(-)
> >  mode change 100644 => 100755 sound/core/jack.c
> > 
> > diff --git a/include/sound/control.h b/include/sound/control.h
> > index 75f3054..023b70a 100644
> > --- a/include/sound/control.h
> > +++ b/include/sound/control.h
> > @@ -66,6 +66,7 @@ struct snd_kcontrol_volatile {
> >  
> >  struct snd_kcontrol {
> >  	struct list_head list;		/* list of controls */
> > +	struct list_head jack_list;		/* list of controls belong to the same jack*/
> >  	struct snd_ctl_elem_id id;
> >  	unsigned int count;		/* count of same elements */
> >  	snd_kcontrol_info_t *info;
> > @@ -75,6 +76,7 @@ struct snd_kcontrol {
> >  		snd_kcontrol_tlv_rw_t *c;
> >  		const unsigned int *p;
> >  	} tlv;
> > +	unsigned int jack_bit_idx;	/*the corresponding jack type bit index */
> >  	unsigned long private_value;
> >  	void *private_data;
> >  	void (*private_free)(struct snd_kcontrol *kcontrol);
> > diff --git a/include/sound/jack.h b/include/sound/jack.h
> > index 2182350..477dcb4 100644
> > --- a/include/sound/jack.h
> > +++ b/include/sound/jack.h
> > @@ -73,6 +73,8 @@ enum snd_jack_types {
> >  
> >  struct snd_jack {
> >  	struct input_dev *input_dev;
> > +	struct list_head kctl_list;
> > +	struct snd_card *card;
> >  	int registered;
> >  	int type;
> >  	const char *id;
> > diff --git a/sound/core/jack.c b/sound/core/jack.c
> > old mode 100644
> > new mode 100755
> > index 8658578..c067b6a
> > --- a/sound/core/jack.c
> > +++ b/sound/core/jack.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/module.h>
> >  #include <sound/jack.h>
> >  #include <sound/core.h>
> > +#include <sound/control.h>
> >  
> >  static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
> >  	SW_HEADPHONE_INSERT,
> > @@ -54,7 +55,13 @@ static int snd_jack_dev_disconnect(struct snd_device *device)
> >  static int snd_jack_dev_free(struct snd_device *device)
> >  {
> >  	struct snd_jack *jack = device->device_data;
> > +	struct snd_card *card = device->card;
> > +	struct snd_kcontrol *kctl;
> >  
> > +	list_for_each_entry(kctl, &jack->kctl_list, jack_list) {
> > +		list_del(&kctl->jack_list);
> 
> This is not safe, as we cant iterate over a list when we are removing
> items using list_for_each_entry(). There are other list methods in
> list.h to safely iterate and remove items.
> 
> > +		snd_ctl_remove(card, kctl);
> > +	}
> >  	if (jack->private_free)
> >  		jack->private_free(jack);
> >  
> > @@ -100,6 +107,63 @@ static int snd_jack_dev_register(struct snd_device *device)
> >  	return err;
> >  }
> >  
> > +
> > +/* get the first unused/available index number for the given kctl name */
> > +static int get_available_index(struct snd_card *card, const char *name)
> > +{
> > +	struct snd_kcontrol *kctl;
> > +	int idx = 0;
> > +	int len = strlen(name);
> > +
> > +	down_write(&card->controls_rwsem);

I think we are only reading the card state below so we can use
down_read().

> > +	next:
> > +	list_for_each_entry(kctl, &card->controls, list) {
> > +		if (!strncmp(name, kctl->id.name, len) &&
> > +		    !strcmp(" Jack", kctl->id.name + len) &&
> > +		    kctl->id.index == idx) {
> > +			idx++;
> > +			goto next;
> 
> Wont continue work here instead of goto ?
> 
> > +		}
> > +	}
> > +	up_write(&card->controls_rwsem);
> > +	return idx;
> > +}
> > +
> > +static void kctl_private_free(struct snd_kcontrol *kctl)
> > +{
> > +	list_del(&kctl->jack_list);
> > +}
> > +
> > +static int snd_jack_new_kctl(struct snd_card *card, struct snd_jack *jack, int type)
> > +{
> > +	struct snd_kcontrol *kctl;
> > +	int i, err, index, state = 0 /* use 0 for default state ?? */;
> > +
> > +	INIT_LIST_HEAD(&jack->kctl_list);
> > +	for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
> > +		int testbit = 1 << i;
> > +		if (type & testbit) {
> > +			index = get_available_index(card,jack->id);
> > +			kctl = snd_kctl_jack_new(jack->id, index, card);
> > +			if (!kctl)
> > +				return -ENOMEM;
> > +			kctl->private_free = kctl_private_free;
> > +			/* use jack_bit_idx for the kctl type bit */
> > +			kctl->jack_bit_idx = i;
> > +
> 
> This section above could do with some new lines to break the code into
> logical chunks.
> 
> > +			err = snd_ctl_add(card, kctl);
> > +			if (err < 0)
> > +				return err;
> > +			list_add_tail(&kctl->jack_list, &jack->kctl_list);
> > +
> > +			/* set initial jack state */
> > +			snd_kctl_jack_report(card, kctl, state & testbit);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * snd_jack_new - Create a new jack
> >   * @card:  the card instance
> > @@ -138,7 +202,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
> >  	}
> >  
> >  	jack->input_dev->phys = "ALSA";
> > -
> > +	jack->card = card;
> >  	jack->type = type;
> >  
> >  	for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
> > @@ -150,10 +214,17 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
> >  	if (err < 0)
> >  		goto fail_input;
> >  
> > +	/* register jack kcontrols  */
> > +	err = snd_jack_new_kctl(card, jack, type);
> > +	if (err < 0)
> > +		goto fail_kctl;
> > +
> >  	*jjack = jack;
> >  
> >  	return 0;
> >  
> > +fail_kctl:
> > +	snd_device_free(card, jack);
> >  fail_input:
> >  	input_free_device(jack->input_dev);
> >  	kfree(jack->id);
> > @@ -230,6 +301,7 @@ EXPORT_SYMBOL(snd_jack_set_key);
> >   */
> >  void snd_jack_report(struct snd_jack *jack, int status)
> >  {
> > +	struct snd_kcontrol *kctl;
> >  	int i;
> >  
> >  	if (!jack)
> > @@ -245,13 +317,26 @@ void snd_jack_report(struct snd_jack *jack, int status)
> >  
> >  	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++) {
> >  		int testbit = 1 << i;
> > -		if (jack->type & testbit)
> > +		if (jack->type & testbit) {
> >  			input_report_switch(jack->input_dev,
> >  					    jack_switch_types[i],
> >  					    status & testbit);
> > +		}
> >  	}
> >  
> >  	input_sync(jack->input_dev);
> > +
> > +	for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
> > +		int testbit = 1 << i;
> > +		if (jack->type & testbit) {
> > +			list_for_each_entry(kctl, &jack->kctl_list, jack_list) {
> > +				if (kctl->jack_bit_idx == i) {
> > +					snd_kctl_jack_report(jack->card, kctl,
> > +								status & testbit);
> > +				}
> > +			}
> > +		}
> > +	}
> >  }
> >  EXPORT_SYMBOL(snd_jack_report);
> >  

Liam

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
