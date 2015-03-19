From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ALSA: jack: create jack kcontrols for
 every jack input device
Date: Thu, 19 Mar 2015 14:04:33 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDA394@SHSMSX101.ccr.corp.intel.com>
References: <1426754418-13477-1-git-send-email-yang.jie@intel.com>
 <s5hh9thw990.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDA362@SHSMSX101.ccr.corp.intel.com>
 <s5h4mpht7ao.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F499260525
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 15:04:39 +0100 (CET)
In-Reply-To: <s5h4mpht7ao.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, March 19, 2015 10:02 PM
> To: Jie, Yang
> Cc: perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-project.org;
> Girdwood, Liam R; Liam Girdwood
> Subject: Re: [PATCH] ALSA: jack: create jack kcontrols for every jack input
> device
> 
> At Thu, 19 Mar 2015 13:53:17 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Thursday, March 19, 2015 6:51 PM
> > > To: Jie, Yang
> > > Cc: perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-project.org;
> > > Girdwood, Liam R; Liam Girdwood
> > > Subject: Re: [PATCH] ALSA: jack: create jack kcontrols for every
> > > jack input device
> > >
> > > At Thu, 19 Mar 2015 16:40:18 +0800,
> > > Jie Yang wrote:
> > > >
> > > > From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > > >
> > > > Currently the ALSA jack core registers only input devices for each
> > > > jack registered. These jack input devices are not readable by
> > > > userspace devices that run as non root.
> > > >
> > > > This patch adds support for additionally registering jack kcontrol
> > > > devices for every input jack registered. This allows non root
> > > > userspace to read jack status.
> > > >
> > > > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > > > Modified-by: Jie Yang <yang.jie@intel.com>
> > > > Signed-off-by: Jie Yang <yang.jie@intel.com>
> > > > Reveiwed-by: Mark Brown <broonie@kernel.org>
> > > > ---
> > > >  include/sound/control.h |  2 ++
> > > >  include/sound/jack.h    |  2 ++
> > > >  sound/core/jack.c       | 89
> > > +++++++++++++++++++++++++++++++++++++++++++++++--
> > > >  3 files changed, 91 insertions(+), 2 deletions(-)  mode change
> > > > 100644 => 100755 sound/core/jack.c
> > > >
> > > > diff --git a/include/sound/control.h b/include/sound/control.h
> > > > index 75f3054..023b70a 100644
> > > > --- a/include/sound/control.h
> > > > +++ b/include/sound/control.h
> > > > @@ -66,6 +66,7 @@ struct snd_kcontrol_volatile {
> > > >
> > > >  struct snd_kcontrol {
> > > >  	struct list_head list;		/* list of controls */
> > > > +	struct list_head jack_list;		/* list of controls belong to
> > > the same jack*/
> > > >  	struct snd_ctl_elem_id id;
> > > >  	unsigned int count;		/* count of same elements */
> > > >  	snd_kcontrol_info_t *info;
> > > > @@ -75,6 +76,7 @@ struct snd_kcontrol {
> > > >  		snd_kcontrol_tlv_rw_t *c;
> > > >  		const unsigned int *p;
> > > >  	} tlv;
> > > > +	unsigned int jack_bit_idx;	/*the corresponding jack type bit
> > > index */
> > > >  	unsigned long private_value;
> > > >  	void *private_data;
> > > >  	void (*private_free)(struct snd_kcontrol *kcontrol);
> > >
> > > NAK for these additions.  There must be a way to implement without
> > > such
> > > *generic* additions in kcontrol.
> > [Keyon] how about define another struct jack_kcontrol in jack.h like below?
> >
> > struct jack_kcontrol {
> > 	struct snd_kcontrol * kctl;
> > 	struct list_head jack_list;		/* list of controls belong to
> >  the same jack*/
> > 	unsigned int jack_bit_idx;	/*the corresponding jack type bit
> >  index */
> > }
> 
> Yes, and point it from kctl->private_data.
[Keyon] OK, will change like that in v2. Thanks.
> 
> 
> Takashi
