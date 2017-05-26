From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ASoC: Intel: Skylake: Add enum control
 for	mic selection
Date: Fri, 26 May 2017 13:05:41 +0530
Message-ID: <20170526073540.GF15061@localhost>
References: <1495768803-24217-1-git-send-email-vinod.koul@intel.com>
 <1495768803-24217-3-git-send-email-vinod.koul@intel.com>
 <s5h7f14jeaf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BDBB0266B88
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 09:33:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7f14jeaf.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, "Kranthikumar, GudishaX" <gudishax.kranthikumar@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 26, 2017 at 08:57:44AM +0200, Takashi Iwai wrote:
> On Fri, 26 May 2017 05:20:02 +0200,
> Vinod Koul wrote:
> > 
> > From: "Kranthikumar, GudishaX" <gudishax.kranthikumar@intel.com>
> > 
> > User may prefer to select data from particular mics. A mic-select module
> > in DSP allows this selection.
> > 
> > Create possible enum controls to allow user to select a combination of
> > mics to capture data from. Based on the user selection, parameters are
> > generated and passed to mic-select module during init.
> > 
> > Signed-off-by: Kranthikumar, GudishaX <gudishax.kranthikumar@intel.com>
> > Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/intel/skylake/skl-topology.c       | 143 +++++++++++++++++++++++++++
> >  sound/soc/intel/skylake/skl-topology.h       |  20 ++++
> >  sound/soc/intel/skylake/skl-tplg-interface.h |   1 +
> >  3 files changed, 164 insertions(+)
> > 
> > diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> > index b687ae455a61..141cfbe40c3a 100644
> > --- a/sound/soc/intel/skylake/skl-topology.c
> > +++ b/sound/soc/intel/skylake/skl-topology.c
> > @@ -36,6 +36,19 @@
> >  #define SKL_IN_DIR_BIT_MASK		BIT(0)
> >  #define SKL_PIN_COUNT_MASK		GENMASK(7, 4)
> >  
> > +static const int mic_mono_list[] = {
> > +0, 1, 2, 3,
> > +};
> > +static const int mic_stereo_list[][SKL_CH_STEREO] = {
> > +{0, 1}, {0, 2}, {0, 3}, {1, 2}, {1, 3}, {2, 3},
> > +};
> > +static const int mic_trio_list[][SKL_CH_TRIO] = {
> > +{0, 1, 2}, {0, 1, 3}, {0, 2, 3}, {1, 2, 3},
> > +};
> > +static const int mic_quatro_list[][SKL_CH_QUATRO] = {
> > +{0, 1, 2, 3},
> > +};
> > +
> >  void skl_tplg_d0i3_get(struct skl *skl, enum d0i3_capability caps)
> >  {
> >  	struct skl_d0i3_data *d0i3 =  &skl->skl_sst->d0i3;
> > @@ -1314,6 +1327,98 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
> >  	return 0;
> >  }
> >  
> > +static int skl_tplg_mic_control_get(struct snd_kcontrol *kcontrol,
> > +		struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
> > +	struct skl_module_cfg *mconfig = w->priv;
> > +	struct soc_enum *ec = (struct soc_enum *)kcontrol->private_value;
> > +	u32 ch_type = *((u32 *)ec->dobj.private);
> > +
> > +	if (mconfig->dmic_ch_type == ch_type)
> > +		ucontrol->value.integer.value[0] = mconfig->dmic_ch_combo_index;
> > +	else
> > +		ucontrol->value.integer.value[0] = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int skl_fill_mic_sel_params(struct skl_module_cfg *mconfig,
> > +	struct skl_mic_sel_config *mic_cfg, struct device *dev)
> > +{
> > +	struct skl_specific_cfg *sp_cfg = &mconfig->formats_config;
> > +
> > +	sp_cfg->caps_size = sizeof(struct skl_mic_sel_config);
> > +	sp_cfg->set_params = SKL_PARAM_SET;
> > +	sp_cfg->param_id = 0x00;
> > +	if (!sp_cfg->caps) {
> > +		sp_cfg->caps = devm_kzalloc(dev, sp_cfg->caps_size, GFP_KERNEL);
> > +		if (!sp_cfg->caps)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	mic_cfg->mic_switch = SKL_MIC_SEL_SWITCH;
> > +	mic_cfg->flags = 0;
> > +	memcpy(sp_cfg->caps, mic_cfg, sp_cfg->caps_size);
> > +
> > +	return 0;
> > +}
> > +
> > +static int skl_tplg_mic_control_set(struct snd_kcontrol *kcontrol,
> > +			struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
> > +	struct skl_module_cfg *mconfig = w->priv;
> > +	struct skl_mic_sel_config mic_cfg = {0};
> > +	struct soc_enum *ec = (struct soc_enum *)kcontrol->private_value;
> > +	u32 ch_type = *((u32 *)ec->dobj.private);
> > +	const int *list;
> > +	u8 in_ch, out_ch, index;
> > +
> > +	mconfig->dmic_ch_type = ch_type;
> > +	mconfig->dmic_ch_combo_index = ucontrol->value.integer.value[0];
> > +
> > +	/* enum control index 0 is INVALID, so no channels to be set */
> > +	if (mconfig->dmic_ch_combo_index == 0)
> > +		return 0;
> > +
> > +	/* No valid channel selection map for index 0, so offset by 1 */
> > +	index = mconfig->dmic_ch_combo_index - 1;
> > +
> > +	switch (ch_type) {
> > +	case SKL_CH_MONO:
> > +		list = &mic_mono_list[index];
> > +		break;
> > +
> > +	case SKL_CH_STEREO:
> > +		list = mic_stereo_list[index];
> > +		break;
> > +
> > +	case SKL_CH_TRIO:
> > +		list = mic_trio_list[index];
> > +		break;
> > +
> > +	case SKL_CH_QUATRO:
> > +		list = mic_quatro_list[index];
> > +		break;
> 
> How do you guarantee that index is in the array range?
> It looks easy to make things vulnerable with a firmware.

Yes a good catch, we should right check the index here and see if it is
within bounds, will fix it and update

Thanks
-- 
~Vinod
