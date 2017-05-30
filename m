From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: Intel: Skylake: Add enum
 control for mic selection
Date: Tue, 30 May 2017 19:11:08 +0530
Message-ID: <20170530134108.GB16927@subhransu-desktop>
References: <1496145781-23434-1-git-send-email-subhransu.s.prusty@intel.com>
 <1496145781-23434-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5hefv64iqj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BEF9C266E30
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 15:55:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hefv64iqj.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 30, 2017 at 02:44:20PM +0200, Takashi Iwai wrote:
> On Tue, 30 May 2017 14:03:00 +0200,
> Subhransu S. Prusty wrote:
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
> 
> Is this enum kctl or not?  If it is, you're accessing to the wrong
> field, as already mentioned.  ucontrol->value.integer.xxx is for
> volumes and switches.

Sent the wrong patches. Fixed it in a different branch. Sorry for
inconvinience. Will resend it.

> 
> Ditto for skl_tplg_mic_control_set().
> 
> > +static const struct snd_soc_tplg_kcontrol_ops skl_tplg_kcontrol_ops[] = {
> > +	{SKL_CONTROL_TYPE_MIC_SELECT, skl_tplg_mic_control_get,
> > +					skl_tplg_mic_control_set},
> > +};
> 
> Better to do in C99 init style.

Sure.

Regards,
Subhransu

> 
> 
> thanks,
> 
> Takashi

-- 
