From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v8 2/7] ALSA: Jack: refactoring
 snd_kctl_jack_new to support embedded kctl
Date: Wed, 22 Apr 2015 13:56:25 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551E2F2@SHSMSX101.ccr.corp.intel.com>
References: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
 <1429682633-10765-3-git-send-email-yang.jie@intel.com>
 <s5hbnigmm8p.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90551E24D@SHSMSX101.ccr.corp.intel.com>
 <s5h383smiab.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 68CDD260587
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 15:56:32 +0200 (CEST)
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
> From: Jie, Yang
> Sent: Wednesday, April 22, 2015 9:23 PM
> To: 'Takashi Iwai'
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> tanu.kaskinen@linux.intel.com
> Subject: RE: [PATCH v8 2/7] ALSA: Jack: refactoring snd_kctl_jack_new to
> support embedded kctl
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Wednesday, April 22, 2015 8:58 PM
> > To: Jie, Yang
> > Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> > tanu.kaskinen@linux.intel.com
> > Subject: Re: [PATCH v8 2/7] ALSA: Jack: refactoring snd_kctl_jack_new
> > to support embedded kctl
> >
> > At Wed, 22 Apr 2015 12:40:43 +0000,
> > Jie, Yang wrote:
> > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Wednesday, April 22, 2015 7:33 PM
> > > > To: Jie, Yang
> > > > Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood,
> > > > Liam R; tanu.kaskinen@linux.intel.com
> > > > Subject: Re: [PATCH v8 2/7] ALSA: Jack: refactoring
> > > > snd_kctl_jack_new to support embedded kctl
> > > >
> > > > At Wed, 22 Apr 2015 14:03:48 +0800, Jie Yang wrote:
> > > > >
> > > > > Move available index get part into snd_kctl_jack_new(), also add
> > > > > kctl name regenerating func to remove redundant " Jack" which is
> > > > > passed in wrongly in some cases.
> > > >
> > > > The subject doesn't match with this description well.
> > >
> > > How about changing them as below:
> > >
> > > ALSA: Jack: handle jack embedded kcontrol creating within ctljack
> > >
> > > In ctljack.c, add function get_available_index() to allocate index
> > > for new kcontrol, and jack_kctl_name_gen() to remove redundant "
> Jack"
> > > which is passed in wrongly in some cases.
> > >
> > > >
> > > >
> > > > > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > > > > ---
> > > > >  include/sound/control.h  |  2 +-
> > > > >  sound/core/ctljack.c     | 39
> > +++++++++++++++++++++++++++++++++++-
> > > > ---
> > > > >  sound/core/jack.c        |  2 +-
> > > > >  sound/pci/hda/hda_jack.c |  2 +-
> > > > >  4 files changed, 38 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/include/sound/control.h b/include/sound/control.h
> > > > > index
> > > > > 75f3054..58751a0 100644
> > > > > --- a/include/sound/control.h
> > > > > +++ b/include/sound/control.h
> > > > > @@ -252,7 +252,7 @@ void snd_ctl_sync_vmaster(struct
> > > > > snd_kcontrol
> > > > *kctl, bool hook_only);
> > > > >   * Helper functions for jack-detection controls
> > > > >   */
> > > > >  struct snd_kcontrol *
> > > > > -snd_kctl_jack_new(const char *name, int idx, void
> > > > > *private_data);
> > > > > +snd_kctl_jack_new(const char *name, struct snd_card *card);
> > > > >  void snd_kctl_jack_report(struct snd_card *card,
> > > > >  			  struct snd_kcontrol *kctl, bool status);
> > > > >
> > > > > diff --git a/sound/core/ctljack.c b/sound/core/ctljack.c index
> > > > > e4b38fb..b631996 100644
> > > > > --- a/sound/core/ctljack.c
> > > > > +++ b/sound/core/ctljack.c
> > > > > @@ -31,15 +31,46 @@ static struct snd_kcontrol_new
> > > > > jack_detect_kctl
> > = {
> > > > >  	.get = jack_detect_kctl_get,
> > > > >  };
> > > > >
> > > > > +static int get_available_index(struct snd_card *card, const
> > > > > +char
> > > > > +*name) {
> > > > > +	struct snd_ctl_elem_id sid;
> > > > > +
> > > > > +	memset(&sid, 0, sizeof(sid));
> > > > > +
> > > > > +	sid.index = 0;
> > > > > +	sid.iface = SNDRV_CTL_ELEM_IFACE_CARD;
> > > > > +	strlcpy(sid.name, name, sizeof(sid.name));
> > > > > +
> > > > > +	while (snd_ctl_find_id(card, &sid))
> > > > > +		sid.index++;
> > > > > +
> > > > > +	return sid.index;
> > > > > +}
> > > > > +
> > > > > +static void jack_kctl_name_gen(char *name, const char
> > > > > +*src_name, int
> > > > > +size) {
> > > > > +	size_t count = strlen(src_name);
> > > > > +	bool need_cat = true;
> > > > > +
> > > > > +	/* remove redundant " Jack" from src_name */
> > > > > +	if (count >= 5)
> > > > > +		need_cat = strncmp(&src_name[count - 5], " Jack",
> 5) ? true :
> > > > > +false;
> > > > > +
> > > > > +	snprintf(name, size, need_cat ? "%s Jack" : "%s", src_name);
> > > > > +
> > > > > +}
> > > > > +
> > > > >  struct snd_kcontrol *
> > > > > -snd_kctl_jack_new(const char *name, int idx, void
> > > > > *private_data)
> > > > > +snd_kctl_jack_new(const char *name, struct snd_card *card)
> > > > >  {
> > > > >  	struct snd_kcontrol *kctl;
> > > > > -	kctl = snd_ctl_new1(&jack_detect_kctl, private_data);
> > > > > +
> > > > > +	kctl = snd_ctl_new1(&jack_detect_kctl, card);
> > > >
> > > > Why changing the private data?  Did it really work...?
 

Hi, Takashi, I recalled that why I need change it to 'card' here: we need
it in the new added function get_available_index().

when I look more into snd_ctl_new1() and the private_data
usage in hda_jack.c(private_data is not really used there),  so, I prefer
to keep this change, and change the calling in hda_jack.c as below:

-	kctl = snd_kctl_jack_new(name, codec);
+ 	kctl = snd_kctl_jack_new(name, codec->bus->card);

This should fix both issues.

What's your opinion on it?

> > >
> > > After this refactoring series, only jack.c:snd_jack_kctl_new() will
> > > call this
> > > snd_kctl_jack_new() with struct snd_card * passed in, so I changed
> > > it here, to make it easier for reading.
> > >
> > > Here struct snd_card * will be cast to void * in snd_ctl_new1().
> > >
> > > Actually, I can keep it as before, then struct snd_card * will be
> > > cast to void * in snd_kctl_jack_new().
> > >
> > > Seems no big difference with these two method? If you like, I can
> > > change It back.
> >
> > You break the bisectionability in your series.
> >
> > Try to build and test at *each* commit whether it works as expected.
> > Since snd_kctl_jack_new() is still called from hda_jack.c at this
> > commit, it'll certainly crash when the jack is actually handled.
> > Or, maybe it's even before that -- it may result in double jacks.
> 
> Thanks for pointing out this, cast codec to card is really a risk here, will change
> it back.
> 
> >
> > Especially test with several kconfigs to build (with and without
> > CONFIG_SND_HDA_INPUT_JACK and CONFIG_SND_JACK), and test with
> the
> > actual HD-audio driver.
> 
> Um, I tested the building for each commit with, but not run for each. Will
> notice it next time.
> 
> >
> > Keeping things working isn't an easy task, but it's often worthwhile.
> > Once when you have done, you have idea how to manage a patch series.
> 
> That's true. Thanks for guiding patiently. :)
> 
> >
> >
> > Takashi
