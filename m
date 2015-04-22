From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v7 2/7] ALSA: Jack: refactoring
 snd_kctl_jack_new to support embedded kctl
Date: Wed, 22 Apr 2015 05:33:45 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551DE61@SHSMSX101.ccr.corp.intel.com>
References: <1429603545-21063-1-git-send-email-yang.jie@intel.com>
 <1429603545-21063-3-git-send-email-yang.jie@intel.com>
 <s5hpp6xzu2f.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90551BD87@SHSMSX101.ccr.corp.intel.com>
 <s5h4mo8ohi1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C28412657E5
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 07:33:51 +0200 (CEST)
In-Reply-To: <s5h4mo8ohi1.wl-tiwai@suse.de>
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
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, April 22, 2015 1:32 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH v7 2/7] ALSA: Jack: refactoring snd_kctl_jack_new to
> support embedded kctl
> 
> At Wed, 22 Apr 2015 00:51:56 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Tuesday, April 21, 2015 5:53 PM
> > > To: Jie, Yang
> > > Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam
> > > R
> > > Subject: Re: [PATCH v7 2/7] ALSA: Jack: refactoring
> > > snd_kctl_jack_new to support embedded kctl
> > >
> > > At Tue, 21 Apr 2015 16:05:40 +0800,
> > > Jie Yang wrote:
> > > >
> > > > Move available index get part into snd_kctl_jack_new(), also add
> > > > kctl name regenerating func to remove redundant " Jack" which is
> > > > passed in wrongly in some cases.
> > > >
> > > > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > > > ---
> > > >  include/sound/control.h  |  2 +-
> > > >  sound/core/ctljack.c     | 39
> +++++++++++++++++++++++++++++++++++-
> > > ---
> > > >  sound/core/jack.c        |  2 +-
> > > >  sound/pci/hda/hda_jack.c |  2 +-
> > > >  4 files changed, 38 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/sound/control.h b/include/sound/control.h
> > > > index
> > > > 75f3054..58751a0 100644
> > > > --- a/include/sound/control.h
> > > > +++ b/include/sound/control.h
> > > > @@ -252,7 +252,7 @@ void snd_ctl_sync_vmaster(struct snd_kcontrol
> > > *kctl, bool hook_only);
> > > >   * Helper functions for jack-detection controls
> > > >   */
> > > >  struct snd_kcontrol *
> > > > -snd_kctl_jack_new(const char *name, int idx, void *private_data);
> > > > +snd_kctl_jack_new(const char *name, struct snd_card *card);
> > > >  void snd_kctl_jack_report(struct snd_card *card,
> > > >  			  struct snd_kcontrol *kctl, bool status);
> > > >
> > > > diff --git a/sound/core/ctljack.c b/sound/core/ctljack.c index
> > > > e4b38fb..b631996 100644
> > > > --- a/sound/core/ctljack.c
> > > > +++ b/sound/core/ctljack.c
> > > > @@ -31,15 +31,46 @@ static struct snd_kcontrol_new jack_detect_kctl
> = {
> > > >  	.get = jack_detect_kctl_get,
> > > >  };
> > > >
> > > > +static int get_available_index(struct snd_card *card, const char
> > > > +*name) {
> > > > +	struct snd_ctl_elem_id sid;
> > > > +
> > > > +	memset(&sid, 0, sizeof(sid));
> > > > +
> > > > +	sid.index = 0;
> > > > +	sid.iface = SNDRV_CTL_ELEM_IFACE_CARD;
> > > > +	strlcpy(sid.name, name, sizeof(sid.name));
> > > > +
> > > > +	while (snd_ctl_find_id(card, &sid))
> > > > +		sid.index++;
> > > > +
> > > > +	return sid.index;
> > > > +}
> > > > +
> > > > +static void jack_kctl_name_gen(char *name, const char *src_name,
> > > > +int
> > > > +size) {
> > > > +	size_t count = strlen(src_name);
> > > > +	bool need_cat = true;
> > > > +
> > > > +	/* remove redundant " Jack" from src_name */
> > > > +	if (count >= 5)
> > > > +		need_cat = strncmp(&src_name[count - 5], " Jack", 5) ? true :
> > > > +false;
> > > > +
> > > > +	snprintf(name, size, need_cat ? "%s Jack" : "%s", src_name);
> > > > +
> > > > +}
> > > > +
> > > >  struct snd_kcontrol *
> > > > -snd_kctl_jack_new(const char *name, int idx, void *private_data)
> > > > +snd_kctl_jack_new(const char *name, struct snd_card *card)
> > > >  {
> > > >  	struct snd_kcontrol *kctl;
> > > > -	kctl = snd_ctl_new1(&jack_detect_kctl, private_data);
> > > > +
> > > > +	kctl = snd_ctl_new1(&jack_detect_kctl, card);
> > > >  	if (!kctl)
> > > >  		return NULL;
> > > > -	snprintf(kctl->id.name, sizeof(kctl->id.name), "%s Jack", name);
> > > > -	kctl->id.index = idx;
> > > > +
> > > > +	jack_kctl_name_gen(kctl->id.name, name, sizeof(kctl->id.name));
> > > > +	kctl->id.index = get_available_index(card, name);
> > > >  	kctl->private_value = 0;
> > > >  	return kctl;
> > > >  }
> > > > diff --git a/sound/core/jack.c b/sound/core/jack.c index
> > > > 741db7c..b13d0b1 100644
> > > > --- a/sound/core/jack.c
> > > > +++ b/sound/core/jack.c
> > > > @@ -141,7 +141,7 @@ static struct snd_jack_kctl *
> > > snd_jack_kctl_new(struct snd_card *card, const cha
> > > >  	struct snd_jack_kctl *jack_kctl;
> > > >  	int err;
> > > >
> > > > -	kctl = snd_kctl_jack_new(name, 0, card);
> > > > +	kctl = snd_kctl_jack_new(name, card);
> > > >  	if (!kctl)
> > > >  		return NULL;
> > > >
> > > > diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
> > > > index e664307..a046e2f 100644
> > > > --- a/sound/pci/hda/hda_jack.c
> > > > +++ b/sound/pci/hda/hda_jack.c
> > > > @@ -402,7 +402,7 @@ static int __snd_hda_jack_add_kctl(struct
> > > hda_codec *codec, hda_nid_t nid,
> > > >  		return 0;
> > > >  	if (jack->kctl)
> > > >  		return 0; /* already created */
> > > > -	kctl = snd_kctl_jack_new(name, idx, codec);
> > > > +	kctl = snd_kctl_jack_new(name, codec);
> > > >  	if (!kctl)
> > > >  		return -ENOMEM;
> > > >  	err = snd_hda_ctl_add(codec, nid, kctl);
> > >
> > > And you can get rid of the same local functions in hda_jack.c.
> > > Now they are superfluous.
> >
> > When I grep and found there are 14 other calling to the function
> > snd_hda_ctl_add(), seems the func is still needed for non-jack controls?
> 
> No, I meant to remove get_unique_index() and relevant codes in hda_jack.c.
 
Got it, will update it soon.

> 
> 
> Takashi
