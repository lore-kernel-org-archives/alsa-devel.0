From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda/hdmi - apply Valleyview fix-ups
 to Cherryview display codec
Date: Tue, 19 Aug 2014 00:17:27 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1955D731@SHSMSX103.ccr.corp.intel.com>
References: <1408351447-132394-1-git-send-email-libin.yang@intel.com>
 <s5hbnriw4mk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DC1612654C2
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 02:17:35 +0200 (CEST)
In-Reply-To: <s5hbnriw4mk.wl-tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, August 18, 2014 5:04 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong
> Subject: Re: [PATCH] ALSA: hda/hdmi - apply Valleyview fix-ups to
> Cherryview display codec
> 
> At Mon, 18 Aug 2014 16:44:07 +0800,
> libin.yang@intel.com wrote:
> >
> > From: Libin Yang <libin.yang@intel.com>
> >
> > Valleyview and Cherryview have the same behavior on display audio. So
> > this patch defines is_valleyview_plus() to include codecs for both
> > Valleyview and its successor Cherryview, and apply Valleyview fix-ups to
> Cherryview.
> >
> > Signed-off-by: Libin Yang <libin.yang@intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 36badba..99d7d7f 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -50,6 +50,8 @@ MODULE_PARM_DESC(static_hdmi_pcm, "Don't
> restrict
> > PCM parameters per ELD info");  #define is_haswell_plus(codec)
> > (is_haswell(codec) || is_broadwell(codec))
> >
> >  #define is_valleyview(codec) ((codec)->vendor_id == 0x80862882)
> > +#define is_cherryview(codec) ((codec)->vendor_id == 0x80862883)
> > +#define is_valleyview_plus(codec) (is_valleyview(codec) ||
> > +is_cherryview(codec))
> >
> >  struct hdmi_spec_per_cvt {
> >  	hda_nid_t cvt_nid;
> > @@ -1459,7 +1461,7 @@ static int hdmi_pcm_open(struct
> hda_pcm_stream *hinfo,
> >  			    mux_idx);
> >
> >  	/* configure unused pins to choose other converters */
> > -	if (is_haswell_plus(codec) || is_valleyview(codec))
> > +	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
> >  		intel_not_share_assigned_cvt(codec, per_pin->pin_nid,
> mux_idx);
> >
> >  	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid); @@
> > -1598,7 +1600,8 @@ static bool hdmi_present_sense(struct
> hdmi_spec_per_pin *per_pin, int repoll)
> >  		 *   and this can make HW reset converter selection on a pin.
> >  		 */
> >  		if (eld->eld_valid && !old_eld_valid && per_pin->setup) {
> > -			if (is_haswell_plus(codec) || is_valleyview(codec)) {
> > +			if (is_haswell_plus(codec) ||
> > +				is_valleyview_plus(codec)) {
> >  				intel_verify_pin_cvt_connect(codec,
> per_pin);
> >  				intel_not_share_assigned_cvt(codec,
> pin_nid,
> >  							per_pin->mux_idx);
> > @@ -1779,7 +1782,7 @@ static int
> generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> >  	bool non_pcm;
> >  	int pinctl;
> >
> > -	if (is_haswell_plus(codec) || is_valleyview(codec)) {
> > +	if (is_haswell_plus(codec) || is_valleyview_plus(codec)) {
> >  		/* Verify pin:cvt selections to avoid silent audio after S3.
> >  		 * After S3, the audio driver restores pin:cvt selections
> >  		 * but this can happen before gfx is ready and such selection
> @@
> > -2330,9 +2333,8 @@ static int patch_generic_hdmi(struct hda_codec
> *codec)
> >  		intel_haswell_fixup_enable_dp12(codec);
> >  	}
> >
> > -	if (is_haswell(codec) || is_valleyview(codec)) {
> > +	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
> 
> This hunk changes is_haswell() to is_haswell_plus() without explanation.  If
> it's really needed, split the patch, one to fix
> is_haswell() call here, and another to replace is_valleyview() with
> is_valleyview_plus().
> 
> Fixing some bug is good, but silently fixing something else isn't :)

OK, I will split it into 2 patches. :)

> 
> 
> thanks,
> 
> Takashi
> 
> 
> >  		codec->depop_delay = 0;
> > -	}
> >
> >  	if (hdmi_parse_codec(codec) < 0) {
> >  		codec->spec = NULL;
> > --
> > 1.9.1
> >
