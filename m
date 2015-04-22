From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v8 1/7] ALSA: jack: implement kctl creating
 for jack device
Date: Wed, 22 Apr 2015 12:08:35 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551E225@SHSMSX101.ccr.corp.intel.com>
References: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
 <1429682633-10765-2-git-send-email-yang.jie@intel.com>
 <s5hegncmmgz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 52C272655A5
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 14:08:41 +0200 (CEST)
In-Reply-To: <s5hegncmmgz.wl-tiwai@suse.de>
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
> Sent: Wednesday, April 22, 2015 7:28 PM
> To: Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> tanu.kaskinen@linux.intel.com; Liam Girdwood
> Subject: Re: [PATCH v8 1/7] ALSA: jack: implement kctl creating for jack
> device
> 
> At Wed, 22 Apr 2015 14:03:47 +0800,
> Jie Yang wrote:
> >
> > Currently the ALSA jack core registers only input devices for each
> > jack registered. These jack input devices are not readable by
> > userspace devices that run as non root. This patch and the following
> > series patches will implement kctls inside the core jack part,
> > including kctls creating, status changing report, for both HD-Audio
> > and ASoC jack. This allows non root userspace to read jack status and act on
> it.
> >
> > This patch implement snd_jack_add_new_kctl(), which will create a
> > kcontrol, add it to the card, and also attach it to the jack kctl list.
> >
> > The patch also initial the jack kctl list after jack is newed, and
> > report kctl status when doing jack report.
> >
> > In the following patches, We will update snd_jack_new() to support
> > phantom jack creating, and also enable a kcontrol creating at this jack new
> stage.
> > After that, we can remove these part from HDA jack, and leave jack
> > kctls handled by core part thoroughly.
> >
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > Modified-by: Jie Yang <yang.jie@intel.com>
> > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > Reveiwed-by: Mark Brown <broonie@kernel.org>
> > ---
> >  include/sound/jack.h  |  15 +++++++-
> >  sound/core/Kconfig    |   3 --
> >  sound/core/Makefile   |   3 +-
> >  sound/core/jack.c     | 104
> +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  sound/pci/hda/Kconfig |   1 -
> >  5 files changed, 118 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/sound/jack.h b/include/sound/jack.h index
> > 2182350..9781e75 100644
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
> > @@ -82,10 +84,17 @@ struct snd_jack {
> >  	void (*private_free)(struct snd_jack *);  };
> >
> > +struct snd_jack_kctl {
> > +	struct snd_kcontrol *kctl;
> > +	struct list_head list;		/* list of controls belong to the same
> jack */
> > +	unsigned int mask_bits;	/* one of the corresponding bits of
> status change will report to this kctl */
> > +};
> 
> This struct isn't referred outside jack.c, so we can move it to jack.c.  This hides
> the internal implementation details.
 
Also thought of it, will change it soon.

> 
> 
> >  #ifdef CONFIG_SND_JACK
> >
> >  int snd_jack_new(struct snd_card *card, const char *id, int type,
> >  		 struct snd_jack **jack);
> > +int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name,
> > +int mask);
> >  void snd_jack_set_parent(struct snd_jack *jack, struct device
> > *parent);  int snd_jack_set_key(struct snd_jack *jack, enum
> snd_jack_types type,
> >  		     int keytype);
> > @@ -93,13 +102,17 @@ int snd_jack_set_key(struct snd_jack *jack, enum
> > snd_jack_types type,  void snd_jack_report(struct snd_jack *jack, int
> > status);
> >
> >  #else
> > -
> >  static inline int snd_jack_new(struct snd_card *card, const char *id, int
> type,
> >  			       struct snd_jack **jack)
> >  {
> >  	return 0;
> >  }
> >
> > +static inline int snd_jack_add_new_kctl(struct snd_jack *jack, const
> > +char * name, int mask) {
> > +	return 0;
> > +}
> > +
> >  static inline void snd_jack_set_parent(struct snd_jack *jack,
> >  				       struct device *parent)
> >  {
> > diff --git a/sound/core/Kconfig b/sound/core/Kconfig index
> > 313f22e..63cc2e9 100644
> > --- a/sound/core/Kconfig
> > +++ b/sound/core/Kconfig
> > @@ -221,9 +221,6 @@ config SND_PCM_XRUN_DEBUG  config
> SND_VMASTER
> >  	bool
> >
> > -config SND_KCTL_JACK
> > -	bool
> > -
> >  config SND_DMA_SGBUF
> >  	def_bool y
> >  	depends on X86
> > diff --git a/sound/core/Makefile b/sound/core/Makefile index
> > 4daf2f5..e041dc2 100644
> > --- a/sound/core/Makefile
> > +++ b/sound/core/Makefile
> > @@ -7,8 +7,7 @@ snd-y     := sound.o init.o memory.o info.o control.o
> misc.o device.o
> >  snd-$(CONFIG_ISA_DMA_API) += isadma.o
> >  snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o info_oss.o
> >  snd-$(CONFIG_SND_VMASTER) += vmaster.o
> > -snd-$(CONFIG_SND_KCTL_JACK) += ctljack.o
> > -snd-$(CONFIG_SND_JACK)	  += jack.o
> > +snd-$(CONFIG_SND_JACK)	  += ctljack.o jack.o
> 
> I guess this breaks the build when CONFIG_SND_HDA_INPUT_JACK=n.
 
Actually not, just double confirm it.

> 
> 
> Takashi
