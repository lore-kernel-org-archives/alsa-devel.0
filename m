From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - re-apply fixup when
 resuming haswell hdmi codec
Date: Tue, 7 May 2013 14:10:08 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8823C52@SHSMSX102.ccr.corp.intel.com>
References: <1367944461-24456-1-git-send-email-mengdong.lin@intel.com>
 <s5hr4hj11em.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 5532F265065
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 16:10:21 +0200 (CEST)
In-Reply-To: <s5hr4hj11em.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, May 07, 2013 7:21 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH v2] ALSA: hda - re-apply fixup when resuming haswell hdmi
> codec
> 
> At Tue,  7 May 2013 12:34:21 -0400,
> mengdong.lin@intel.com wrote:
> >
> > From: Mengdong Lin <mengdong.lin@intel.com>
> >
> > This patch is a supplement to a previous patch:
> > "ALSA: hda - Add fixup for Haswell to enable all pin and convertor widgets".
> >
> > Some Haswell BIOS will disable the 2nd and 3rd pin/covertor widgets
> > when the HD-A controller changes state from D3 to D0. So when the
> > controller resumes after a system or runtime suspend, these widgets
> > are disabled and programming these widgets to D0 will cause H/W error and
> codec will not respond.
> >
> > So this patch adds a "set_power_state" ops for Haswell codec. Before
> > setting the codec to D0, this function will apply a BIOS-specific
> > fixup to enable the 2nd & 3rd pins/cvts if need.
> >
> > And since BIOS will also disable DP1.2, so this function will check
> > and enable
> > DP1.2 mode if need.
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index adb5dce..080398e 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -1842,7 +1842,7 @@ static void intel_haswell_enable_all_pins(struct
> > hda_codec *codec,  {
> >  	unsigned int vendor_param;
> >
> > -	if (action != HDA_FIXUP_ACT_PRE_PROBE)
> > +	if (action != HDA_FIXUP_ACT_PRE_PROBE && action !=
> > +HDA_FIXUP_ACT_INIT)
> >  		return;
> >  	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
> >  				INTEL_GET_VENDOR_VERB, 0);
> > @@ -1855,7 +1855,8 @@ static void intel_haswell_enable_all_pins(struct
> hda_codec *codec,
> >  	if (vendor_param == -1)
> >  		return;
> >
> > -	snd_hda_codec_update_widgets(codec);
> > +	if (action == HDA_FIXUP_ACT_PRE_PROBE)
> > +		snd_hda_codec_update_widgets(codec);
> >  	return;
> >  }
> >
> > @@ -1874,7 +1875,24 @@ static void
> intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
> >  				INTEL_SET_VENDOR_VERB, vendor_param);  }
> >
> > +static void haswell_set_power_state(struct hda_codec *codec, hda_nid_t fg,
> > +				unsigned int power_state)
> > +{
> > +	if (AC_PWRST_D0 == power_state) {
> > +		snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
> 
> Here is no right place to apply the fixup.  If needed, call it generic_hdmi_init(),
> for example.

Hi Takashi,

These widgets need to be enabled before hda_set_power_state(codec, AC_PWRST_D0) programs these widgets to D0.
Otherwise, audio driver would program these disabled widgets to D0. The codec will not respond when audio driver tries to sync power state. And later verb execution will fail.

In hda_call_codec_resume(), generic_hdmi_init() is called from codec->patch_ops.init, after setting power state to D0. It would be too late.
Is it okay to add a new ops like "pre_resume" to apply the fixup?

Thanks
Mengdong
