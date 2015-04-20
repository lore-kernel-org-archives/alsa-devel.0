From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v6 1/6] ALSA: jack: create jack kcontrols
 for every jack input
Date: Mon, 20 Apr 2015 07:52:20 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551344F@SHSMSX101.ccr.corp.intel.com>
References: <1429351460-15932-1-git-send-email-yang.jie@intel.com>
 <1429351460-15932-2-git-send-email-yang.jie@intel.com>
 <s5ha8y4wmlq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B34A42605D3
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 09:52:51 +0200 (CEST)
In-Reply-To: <s5ha8y4wmlq.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tanu.kaskinen@linux.intel.com" <tanu.kaskinen@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Sunday, April 19, 2015 4:26 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> tanu.kaskinen@linux.intel.com; Liam Girdwood
> Subject: Re: [PATCH v6 1/6] ALSA: jack: create jack kcontrols for every jack
> input
> 
> At Sat, 18 Apr 2015 18:04:15 +0800,
> Jie Yang wrote:
> >
> > Currently the ALSA jack core registers only input devices for each
> > jack registered. These jack input devices are not readable by
> > userspace devices that run as non root.
> >
> > This patch adds support for additionally registering jack kcontrol
> > devices for every input jack registered. This allows non root
> > userspace to read jack status.
> 
> Please give more description what you really changed.  It's not only doing the
> additional kctl creation.  Also, a brief introduction about what will follow in
> the patchset would be nice for readers.
 
Ah, forgot to update this as it has been change a lot from the v1, will do that.

> 
> >
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > Modified-by: Jie Yang <yang.jie@intel.com>
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > Reveiwed-by: Mark Brown <broonie@kernel.org>
> > ---
> >  include/sound/jack.h  |  17 +++++-
> >  sound/core/Kconfig    |   3 --
> >  sound/core/Makefile   |   3 +-
> >  sound/core/jack.c     | 141
> +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  sound/pci/hda/Kconfig |   1 -
> >  5 files changed, 157 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/sound/jack.h b/include/sound/jack.h index
> > 2182350..8337000 100644
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
> > @@ -82,10 +84,19 @@ struct snd_jack {
> >  	void (*private_free)(struct snd_jack *);  };
> >
> > +struct snd_jack_kctl {
> > +	struct snd_kcontrol *kctl;
> > +	struct list_head list;		/* list of controls belong to the same
> jack */
> > +	unsigned int mask_bits;	/* one of the corresponding bits of
> status change will report to this kctl */
> > +	void *private_data;
> > +	void (*private_free)(struct snd_jack_kctl *jack_kctl); };
> 
> You don't have to expose this.  The hda_jack.c doesn't actually need these
> whole bits, as it supposes 1:1 as jack:kctl mapping.  You can get rid of
> hda_jack->kctl since snd_jack_report() does it already, thus the private_data
> and the destructor can be dropped, too.
 
The patch 3/6 removes had_jack->kctl, here I added priate destructor for HDA
jack to reset hda_jack_tbl jacks->nid and jacks->jack to 0.
Seems these are needed for HDA jack logic, otherwise, I can already dropped
them. :(

> 
> That said, the kctl management internal isn't the thing the driver needs to
> care.
> 
> 
> >  #ifdef CONFIG_SND_JACK
> >
> >  int snd_jack_new(struct snd_card *card, const char *id, int type,
> >  		 struct snd_jack **jack);
> > +int snd_jack_add_new_kctls(struct snd_jack *jack, const char * name,
> > +int mask);
> 
> It adds a single kctl.  Using a plural (kctl"s") is confusing.

OK, will change to 'kctl'.

> 
> 
> > +static int snd_jack_get_available_index(struct snd_card *card, const
> > +char *name) {
> > +	struct snd_ctl_elem_id sid;
> > +
> > +	memset(&sid, 0, sizeof(sid));
> > +
> > +	sid.index = 0;
> > +	sid.iface = SNDRV_CTL_ELEM_IFACE_CARD;
> > +	strlcpy(sid.name, name, sizeof(sid.name));
> > +
> > +	while (snd_ctl_find_id(card, &sid)) {
> > +		sid.index++;
> > +	}
> 
> Drop braces for a single line loop.
 
OK.

> 
> > +	return sid.index;
> > +}
> 
> IMO, this function should be rather put to ctljack.c.  It's kctl specific, and not
> really defining the jack implementation itself.
 
Good idea, will consider this in next version.

> 
> 
> > +
> > +static void snd_jack_kctl_private_free(struct snd_kcontrol *kctl) {
> > +	struct snd_jack_kctl *jack_kctl;
> > +
> > +	if (kctl) {
> 
> This NULL check is superfluous.

OK, will remove it. 

> 
> > +		jack_kctl = kctl->private_data;
> > +		if (jack_kctl) {
> > +			if (jack_kctl->private_free)
> > +				jack_kctl->private_free(jack_kctl);
> > +			list_del(&jack_kctl->list);
> > +			kfree(jack_kctl);
> > +		}
> > +	}
> > +
> > +}
> > +
> > +static void snd_jack_kctl_name_gen(char *name, const char *jack_id,
> > +int size) {
> > +	size_t count = strlen(jack_id);
> > +
> > +	/* remove redundant " Jack" from jack_id */
> > +	if (count >= 5)
> > +		count = strncmp(&jack_id[count - 5], " Jack", 5) ? count :
> count -
> > +5;
> > +
> > +	count = (size > count) ? count + 1 : size;
> > +	/* name[count] will be filled to '\0' */
> > +	strlcpy(name, jack_id, count);
> > +}
> 
> This function should be moved to ctljack.c.
> 
> That is, split the code finding a unique index and the removal of superfluous
> jack suffix as another patch.  There fold that code into
 
Agree, will implement this in next version.

> snd_kctl_jack_new() itself.  At the same time, the code doing the same thing
> in hda_jack.c can be removed.  Then the index argument of
 
A little concern that there may be a little difference here:
hda_jack.c:get_unique_index() check the codec kctl list,
but in my patch we check card kctl list, I am afraid that it may influence the
exist HDA usage, wo just keep what HDA did before for HDA jack.

Takashi, do you think it's a risk to change from codec kctl list to card kctl list for
HDA part? 

> snd_kctl_jack_new() can be dropped.
> 
> As a bonus, you can save the stack size, too, by using a single string buffer for
> the name string.  "Jack" suffix manipulation can be simplified there.
 
Agree.

> 
> > +
> > +static void snd_jack_kctl_add(struct snd_jack *jack, struct
> > +snd_jack_kctl *jack_kctl) {
> > +	list_add_tail(&jack_kctl->list, &jack->kctl_list); }
> > +
> > +/**
> > + * snd_jack_kctl_new - Create a new snd_jack_kctl and return it
> > + * @card:  the card instance
> > + * @kctl_name:  the name for the snd_kcontrol object
> > + * @mask:  a bitmask of enum snd_jack_type values that can be detected
> > + *         by this snd_jack_kctl object.
> > + *
> > + * Creates a new snd_kcontrol object, and assign it to the new created
> > + *	     snd_jack_kctl object.
> > + *
> > + * Return: The new created snd_jack_kctl object, or NULL if failed.
> > + */
> > +static struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card
> > +*card, const char *name, unsigned int mask) {
> > +	struct snd_kcontrol *kctl;
> > +	struct snd_jack_kctl *jack_kctl;
> > +	int index, err;
> > +	char jack_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> > +
> > +	index = snd_jack_get_available_index(card, name);
> > +	snd_jack_kctl_name_gen(jack_name, name,
> SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > +	kctl = snd_kctl_jack_new(jack_name, index, card);
> > +	if (!kctl)
> > +		return NULL;
> > +
> > +	jack_kctl = kzalloc(sizeof(*jack_kctl), GFP_KERNEL);
> > +
> > +	if (!jack_kctl)
> > +		goto error;
> > +
> > +	jack_kctl->kctl = kctl;
> > +	jack_kctl->mask_bits = mask;
> > +
> > +	kctl->private_data = jack_kctl;
> > +	kctl->private_free = snd_jack_kctl_private_free;
> > +
> > +	err = snd_ctl_add(card, jack_kctl->kctl);
> > +	if (err < 0)
> > +		goto error;
> > +	return jack_kctl;
> > +error:
> > +	snd_ctl_free_one(kctl);
> 
> This will be a double-free.  snd_ctl_add() itself frees the object at error path.
 
Thanks for reminding. Snd_ctl_free_one() for the first goto is needed, I will
remove it for the second goto.

> 
> 
> Takashi
