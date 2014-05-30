From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: export
 dapm_kcontrol_set/get_value functions
Date: Fri, 30 May 2014 15:59:44 +0530
Message-ID: <20140530102944.GP21128@intel.com>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <5387120B.6090100@metafoo.de> <20140530060918.GN21128@intel.com>
 <5388319F.9030703@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A6B261735
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 12:46:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5388319F.9030703@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org, Kp Jeeja <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 30, 2014 at 09:22:07AM +0200, Lars-Peter Clausen wrote:
> On 05/30/2014 08:09 AM, Vinod Koul wrote:
> >On Thu, May 29, 2014 at 12:55:07PM +0200, Lars-Peter Clausen wrote:
> >>On 05/29/2014 12:03 PM, Vinod Koul wrote:
> >>>The DSPs like Intel ones use the DPCM to represent the DSP toplogy. So when DAPM
> >>>triggers the widget, the DSP needs to know the kcontrol values and pass on to DSP
> >>>firmware, so export these for driver use
> >>>
> >>
> >>As I said I feel a bit uneasy about exporting these and I'd rather
> >>much prefer to see this patch in context (i.e. in the same series as
> >>its user).
> >I am still working on that series. The core patches could have gone ahead so
> >posted.
> >
> >Here is the code snippet that will come in subsequent series:
> >
> >int sst_mix_put(struct snd_kcontrol *kcontrol,
> >         struct snd_ctl_elem_value *ucontrol)
> >{
> >         struct snd_soc_dapm_widget_list *wlist =
> >			dapm_kcontrol_get_wlist(kcontrol);
> >         struct snd_soc_dapm_widget *widget = wlist->widgets[0];
> >         struct soc_mixer_control *mc =
> >                 (struct soc_mixer_control *)kcontrol->private_value;
> >         struct sst_data *sst = snd_soc_platform_get_drvdata(widget->platform);
> >         unsigned int mask = (1 << fls(mc->max)) - 1;
> >         unsigned int val;
> >         int connect;
> >         struct snd_soc_dapm_update update;
> >
> >         val = sst_reg_write(sst, mc->reg, mc->shift, mc->max,
> >				ucontrol->value.integer.value[0]);
> >         connect = !!val;
> >
> >         dapm_kcontrol_set_value(kcontrol, val);
> 
> This looks similar to what I discussed with Peter the other day. You
> do not really need to call dapm_kcontrol_set_value() for controls
> that are not a virtual control or a auto-muted control. Neither is
> probably the case here. The conclusion of our discussion also was to
> move the dapm_kcontrol_set_value() call into
> snd_soc_dapm_mixer_update_power(), in case it ever becomes mandatory
> for other types of controls as well, because this means that not
> every custom put callback has to call the function on it's own.
Yes I agree that if this is the approach we take we can remove the code snippet
here, which would make sense IMO
>
> Btw. in this case I think you should just use the default DAPM
> kcontrol put callback. There doesn't seem to be anything special in
> here and with the DAPM componentization series the default handler
> is also able to handle platforms.
Not for this version sure, but future platforms of our need some custom stuff to
be done. I will try to minimize those ones and once your component work is
complete redo these bits. Would be too happy to remove if it works out that way,
which is not the case with today. So till then we need these bits and exporting
of the dapm_kcontrol_set_value()

-- 
~Vinod
