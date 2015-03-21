From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v3 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Sat, 21 Mar 2015 02:22:47 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDBBA0@SHSMSX101.ccr.corp.intel.com>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <1426865953-1606-2-git-send-email-yang.jie@intel.com>
 <s5ha8z7zlrd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CA51C2604BA
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2015 03:23:00 +0100 (CET)
In-Reply-To: <s5ha8z7zlrd.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Tanu Kaskinen (tanu.kaskinen@linux.intel.com)" <tanu.kaskinen@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Saturday, March 21, 2015 12:17 AM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> Liam Girdwood
> Subject: Re: [PATCH v3 1/2] ALSA: jack: create jack kcontrols for every jack
> input device
> 
> At Fri, 20 Mar 2015 23:39:12 +0800,
> Jie Yang wrote:
> >
> > Currently the ALSA jack core registers only input devices for each
> > jack registered. These jack input devices are not readable by
> > userspace devices that run as non root.
> >
> > This patch adds support for additionally registering jack kcontrol
> > devices for every input jack registered. This allows non root
> > userspace to read jack status.
> >
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > Modified-by: Jie Yang <yang.jie@intel.com>
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > Reveiwed-by: Mark Brown <broonie@kernel.org>
> 
> Thanks for a quick update.  It's getting better, but still some points to be fixed.
> Let's see...
> 
> 
> > +struct snd_jack_kctl {
> > +	struct snd_kcontrol *kctl;
> > +	struct list_head jack_list;		/* list of controls belong to
> the same jack*/
> 
> jack_ prefix is superfluous.
[Keyon] OK.
> 
> > +static int jack_ctl_name_found(struct snd_card *card, const char
> > +*name, int index)
> 
> Use bool.
[Keyon] OK, will change it.
> 
> > +{
> > +	struct snd_kcontrol *kctl;
> > +	int len = strlen(name);
> > +
> > +	down_read(&card->controls_rwsem);
> > +
> > +	list_for_each_entry(kctl, &card->controls, list) {
> > +		if (!strncmp(name, kctl->id.name, len) &&
> > +		    !strcmp(" Jack", kctl->id.name + len) &&
> > +		    kctl->id.index == index) {
> 
> This doesn't work when ctl elements are with multiple counts.  A single kctl
> object may contain multiple snd_kcontrol_volatile entries.
> That's why snd_ctl_find_id() checks like:
> 
> 	list_for_each_entry(kctl, &card->controls, list) {
> 		....
> 		if (kctl->id.index > id->index)
> 			continue;
> 		if (kctl->id.index + kctl->count <= id->index)
> 			continue;
> 
> Also, more importantly, your code checks only the name string.  But the
> same name string can be assigned for different iface, device and subdevice
> entries.  You need to compare them as well.
> 
> That said, it'd be even simpler just to call snd_ctl_find_id() after creating a ctl
> id instance instead of writing an own funciton.  It ends up with a bit more
> stack usage, but it should be still acceptable.
[Keyon] Here I did the getting index work by imitating function from
had_jack.c:get_unique_index(), and I also noticed and concerned about
not checking other snd_ctl_elem_id items.

Thank you for explaining this detail, Takashi, will change to use snd_ctl_find_id(). 

> 
> 
> > +static int snd_jack_new_kctl(struct snd_card *card, struct snd_jack
> > +*jack, int type) {
> > +	struct snd_kcontrol *kctl;
> > +	struct snd_jack_kctl *jack_kctl;
> > +	int i, err, index, state = 0 /* use 0 for default state ?? */;
> > +
> > +	INIT_LIST_HEAD(&jack->kctl_list);
> > +	for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
> > +		int testbit = 1 << i;
> > +
> > +		/* we only new headphone kctl for headset jack */
> > +		if ((testbit == SND_JACK_MICROPHONE) &&
> > +				((type & SND_JACK_HEADSET) ==
> SND_JACK_HEADSET))
> > +			continue;
> 
> The parentheses are superfluous.
[Keyon] OK.
> 
> > +		/* we only new lineout kctl for avout jack */
> > +		if ((testbit == SND_JACK_VIDEOOUT) &&
> > +				((type & SND_JACK_AVOUT) ==
> SND_JACK_AVOUT))
> > +			continue;
> > +
> > +		if (type & testbit) {
> 
> This check can be at the beginning of the loop, i.e.
> 
> 		if (!(type & testbit))
> 			continue;
> 
> then you'll reduce one indent level.
[Keyon] good idea. Will change it.
> 
> 
> Now, a bigger question:
> 
> > +			index = get_available_index(card,jack->id);
> > +			kctl = snd_kctl_jack_new(jack->id, index, card);
> 
> So, here you are creating multiple kctl elements with the very same name
> string.  Did you take a look at the actual usages of snd_jack_new(), especially
> snd_soc_card_jack_new()?
[Keyon] yes, I noticed this.  I can also find it at soc/intel/broadwell.c:

        ret = snd_soc_card_jack_new(rtd->card, "Headset",
                SND_JACK_HEADSET | SND_JACK_BTN_0, &broadwell_headset,
                broadwell_headset_pins, ARRAY_SIZE(broadwell_headset_pins));

it will create 2 kctl elements with the same name string "Headset":

numid=12,iface=CARD,name='Headset Jack'
numid=13,iface=CARD,name='Headset Jack',index=1

> 
> Try like
> 
> % git grep -A2 snd_soc_card_jack_new sound/soc/
> 
> sound/soc/fsl/imx-es8328.c:             ret = snd_soc_card_jack_new(rtd->card,
> "Headphone",
> sound/soc/fsl/imx-es8328.c-                                         SND_JACK_HEADPHONE |
> SND_JACK_BTN_0,
> sound/soc/fsl/imx-es8328.c-                                         &headset_jack, NULL, 0);
> --
> sound/soc/fsl/wm1133-ev1.c:     snd_soc_card_jack_new(rtd->card,
> "Headphone", SND_JACK_HEADPHONE,
> sound/soc/fsl/wm1133-ev1.c-                           &hp_jack, hp_jack_pins,
> ARRAY_SIZE(hp_jack_pins));
> sound/soc/fsl/wm1133-ev1.c-     wm8350_hp_jack_detect(codec,
> WM8350_JDR, &hp_jack, SND_JACK_HEADPHONE);
> --
> sound/soc/fsl/wm1133-ev1.c:     snd_soc_card_jack_new(rtd->card,
> "Microphone",
> sound/soc/fsl/wm1133-ev1.c-                           SND_JACK_MICROPHONE |
> SND_JACK_BTN_0, &mic_jack,
> sound/soc/fsl/wm1133-ev1.c-                           mic_jack_pins,
> ARRAY_SIZE(mic_jack_pins));
> .....
> 
> As you'll find through the whole output, many calls are combined with
> SND_JACK_BTN_* bits.  And think again how this will result with your patch.
> A call like
> 
> 	snd_soc_card_jack_new(card, "Headphone",
> 		SND_JACK_HEADPHONE | SND_JACK_BTN_0 |
> SND_JACK_BTN_1, ...)
> 
> would give three kctls, all "Headphone Jack" with indices 0, 1 and 2.
> How user-space knows what is for what?
[Keyon] yes, this is an issue I was thinking about, we need discussing and conclusion
about that, including comments from user-space, here adding Tanu.
Here I am thinking about
1. do we really need kctls for buttons(SND_JACK_BTN_n)? if no, that is simplest, 
we can filter out them at this kctl creating stage.
2. if yes, then we need an name regenerator here, to generate understandable
(for user-space) kctl names for buttons.

> 
> Also, when you look through the grep above, you'll find that many calls
> already contain "Jack" name suffix.  So, they will result in a name like
> "Headset Jack Jack".
[Keyon] do you think we should implement intelligent name regenerator here
to remove this suffix? 

And furthermore, we can check more here, e.g. if the name ("Headset") is 
matched with the type(type should have SND_JACK_HEADSET bits), or 
something like that. 

> 
> One last bit:
> > +			/* set initial jack state */
> > +			snd_kctl_jack_report(card, kctl, state & testbit);
> 
> This can be dropped.  The value is zero as default, so unless the actual value
> is different, you don't need to call it.
[Keyon] OK.
> 
> Or, yet another last bit: remove EXPORT_SYMBOL_GPL() from ctljack.c, as
> they are merely internal functions.  But this can be done another patch later.
[Keyon] OK, I will add this to another patch.
> 
> 
> Takashi
