From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: export
 dapm_kcontrol_set/get_value functions
Date: Fri, 30 May 2014 11:39:18 +0530
Message-ID: <20140530060918.GN21128@intel.com>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <5387120B.6090100@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 99607261B14
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 08:26:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5387120B.6090100@metafoo.de>
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
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 29, 2014 at 12:55:07PM +0200, Lars-Peter Clausen wrote:
> On 05/29/2014 12:03 PM, Vinod Koul wrote:
> >The DSPs like Intel ones use the DPCM to represent the DSP toplogy. So when DAPM
> >triggers the widget, the DSP needs to know the kcontrol values and pass on to DSP
> >firmware, so export these for driver use
> >
> 
> As I said I feel a bit uneasy about exporting these and I'd rather
> much prefer to see this patch in context (i.e. in the same series as
> its user).
I am still working on that series. The core patches could have gone ahead so
posted.

Here is the code snippet that will come in subsequent series:

int sst_mix_put(struct snd_kcontrol *kcontrol,
        struct snd_ctl_elem_value *ucontrol)
{
        struct snd_soc_dapm_widget_list *wlist =
			dapm_kcontrol_get_wlist(kcontrol);
        struct snd_soc_dapm_widget *widget = wlist->widgets[0];
        struct soc_mixer_control *mc =
                (struct soc_mixer_control *)kcontrol->private_value;
        struct sst_data *sst = snd_soc_platform_get_drvdata(widget->platform);
        unsigned int mask = (1 << fls(mc->max)) - 1;
        unsigned int val;
        int connect;
        struct snd_soc_dapm_update update;

        val = sst_reg_write(sst, mc->reg, mc->shift, mc->max,
				ucontrol->value.integer.value[0]);
        connect = !!val;

        dapm_kcontrol_set_value(kcontrol, val);
        update.kcontrol = kcontrol;
        update.reg = mc->reg;
        update.mask = mask;
        update.val = val;

        snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol, connect, &update);
        return 0;
}

-- 
~Vinod
