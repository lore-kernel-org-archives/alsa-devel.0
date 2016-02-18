From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - hdmi get jack from
 hda_jack_tbl when not dyn_pcm_assign
Date: Thu, 18 Feb 2016 08:02:24 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1904667B57@shsmsx102.ccr.corp.intel.com>
References: <1455773102-135817-1-git-send-email-libin.yang@linux.intel.com>
 <s5hlh6i314h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 910A7260714
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 09:02:30 +0100 (CET)
In-Reply-To: <s5hlh6i314h.wl-tiwai@suse.de>
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

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, February 18, 2016 3:54 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [PATCH] ALSA: hda - hdmi get jack from hda_jack_tbl when
> not dyn_pcm_assign
> 
> On Thu, 18 Feb 2016 06:25:02 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > On Intel platform, if !dyn_pcm_assign, spec->pcm_rec[].jack is not
> > NULL even after snd_hda_jack_tbl_clear() is called to free snd_jack.
> > This may cause access invalid memory when calling snd_jack_report.
> >
> > Please see more detail from:
> > https://bugs.freedesktop.org/show_bug.cgi?id=94079
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index f4443b5..3b47101 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -1962,6 +1962,7 @@ static void sync_eld_via_acomp(struct
> hda_codec *codec,
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> >  	struct hdmi_eld *eld = &spec->temp_eld;
> > +	struct hda_jack_tbl *jack_tbl;
> >  	struct snd_jack *jack = NULL;
> >  	int size;
> >
> > @@ -1989,10 +1990,21 @@ static void sync_eld_via_acomp(struct
> hda_codec *codec,
> >  	/* pcm_idx >=0 before update_eld() means it is in monitor
> >  	 * disconnected event. Jack must be fetched before update_eld()
> >  	 */
> > -	if (per_pin->pcm_idx >= 0)
> > +	/* if !dyn_pcm_assign, get jack from hda_jack_tbl
> > +	 * in !dyn_pcm_assign case, spec->pcm_rec[].jack is not
> > +	 * NULL even after snd_hda_jack_tbl_clear() is called to
> > +	 * free snd_jack. This may cause access invalid memory
> > +	 * when calling snd_jack_report
> > +	 */
> > +	if (per_pin->pcm_idx >= 0 && spec->dyn_pcm_assign)
> >  		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
> > +	else {
> > +		jack_tbl = snd_hda_jack_tbl_get(codec, per_pin-
> >pin_nid);
> > +		if (jack_tbl)
> > +			jack = jack_tbl->jack;
> > +	}
> >  	update_eld(codec, per_pin, eld);
> > -	if (jack == NULL && per_pin->pcm_idx >= 0)
> > +	if (jack == NULL && per_pin->pcm_idx >= 0 && spec-
> >dyn_pcm_assign)
> >  		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
> >  	if (jack == NULL)
> >  		goto unlock;
> 
> I'd create a separate small helper function, e.g. pin_to_jack()
> doing like:
> 
> pin_idx_to_jack(codec, per_pin)
> {
> 	if (spec->dyn_pcm_assign) {
> 		if (per_pin->pcm_idx < 0)
> 			return NULL;
> 		return spec->pcm_rec[per_pin->pcm_idx].jack;
> 	} else {
> 		jack_tbl = snd_hda_jack_tbl_get(codec, per_pin-
> >pin_nid);
> 		if (!jack_tbl)
> 			return NULL;
> 		return jack_tbl->jack;
> 	}
> }
> 
> Then the code update_eld() will be cleaner,
> 
> 	jack = pin_to_jack(codec, per_pin);
> 	update_eld(codec, per_pin, eld);
> 	if (!jack)
> 		jack = pin_to_jack(codec, per_pin);
> 	if (!jack)
> 		goto unlock;
> 
> Alternatively, assign pcm_rec[].jack beforehand for non-dyn PCM.
> It's fixed, so you can assign it in initialization.

Get it. So your patch will be merged to for-next soon? Thanks.

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
