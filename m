From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 2/4] ALSA: hda - add hdmi_pcm to manage
 hdmi pcm related features
Date: Fri, 8 Jan 2016 02:48:53 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190464D19B@SHSMSX103.ccr.corp.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
 <1451524942-17288-3-git-send-email-libin.yang@linux.intel.com>
 <s5hlh81fq35.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CF50260483
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 03:48:59 +0100 (CET)
In-Reply-To: <s5hlh81fq35.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, January 07, 2016 9:59 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [PATCH 2/4] ALSA: hda - add hdmi_pcm to
> manage hdmi pcm related features
> 
> On Thu, 31 Dec 2015 02:22:20 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Use struct hdmi_pcm wrapper for hdmi pcm management.
> > All PCM related features, like jack,  will be put in this structure.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 44 ++++++++++++++++++++++++------
> --------------
> >  1 file changed, 24 insertions(+), 20 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index 6d6dba4..5549ddf 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -86,7 +86,7 @@ struct hdmi_spec_per_pin {
> >  	struct delayed_work work;
> >  	struct snd_kcontrol *eld_ctl;
> >  	struct snd_jack *acomp_jack; /* jack via audio component */
> > -	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n]
> dynamically*/
> > +	struct hdmi_pcm *pcm; /* pointer to spec->pcm_rec[n]
> dynamically*/
> >  	int pcm_idx; /* which pcm is attached. -1 means no pcm is
> attached */
> >  	int repoll_count;
> >  	bool setup; /* the stream has been set up by prepare callback */
> > @@ -132,6 +132,11 @@ struct hdmi_ops {
> >  	int (*chmap_validate)(int ca, int channels, unsigned char
> *chmap);
> >  };
> >
> > +struct hdmi_pcm {
> > +	struct hda_pcm *pcm;
> > +	struct snd_jack *jack;
> > +};
> > +
> >  struct hdmi_spec {
> >  	int num_cvts;
> >  	struct snd_array cvts; /* struct hdmi_spec_per_cvt */
> > @@ -139,7 +144,7 @@ struct hdmi_spec {
> >
> >  	int num_pins;
> >  	struct snd_array pins; /* struct hdmi_spec_per_pin */
> > -	struct hda_pcm *pcm_rec[16];
> > +	struct hdmi_pcm pcm_rec[16];
> >  	struct mutex pcm_lock;
> >  	/* pcm_bitmap means which pcms have been assigned to pins*/
> >  	unsigned long pcm_bitmap;
> > @@ -403,7 +408,7 @@ static int hinfo_to_pcm_index(struct
> hda_codec *codec,
> >  	int pcm_idx;
> >
> >  	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++)
> > -		if (get_pcm_rec(spec, pcm_idx)->stream == hinfo)
> > +		if (get_pcm_rec(spec, pcm_idx).pcm->stream == hinfo)
> 
> I would change rather get_pcm_rec() itself to point to hda_pcm.
> For referencing to hdmi_pcm, we can introduce another macro, e.g.
> get_hdmi_pcm(spec, idx).  For example:

Get it. It makes sense for compatibility. I will change it.

> 
> /* obtain hdmi_pcm object assigned to idx */
> #define get_hdmi_pcm(spec, idx)	(&(spec)->pcm_rec[idx])
> 
> /* obtain hda_pcm object assigned to idx */
> #define get_pcm_rec(spec, idx)	get_hdmi_pcm(spec, idx)->pcm
> 
> 
> Takashi
