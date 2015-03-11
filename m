From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH v2 4/8] ASoC: Intel: add kcontrol to
 enable/disable sound effect module waves
Date: Wed, 11 Mar 2015 07:07:12 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A8373CC6@SHSMSX101.ccr.corp.intel.com>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
 <1425955287-29661-4-git-send-email-han.lu@intel.com>
 <20150310203730.GN28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DCDAE2650FF
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 08:07:21 +0100 (CET)
In-Reply-To: <20150310203730.GN28806@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, March 11, 2015 4:38 AM
> To: Lu, Han
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH v2 4/8] ASoC: Intel: add kcontrol to enable/disable
> sound effect module waves
> 
> On Tue, Mar 10, 2015 at 10:41:23AM +0800, han.lu@intel.com wrote:
> 
> > +static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol) {
> > +	struct snd_soc_platform *platform =
> snd_soc_kcontrol_platform(kcontrol);
> > +	struct hsw_priv_data *pdata =
> snd_soc_platform_get_drvdata(platform);
> > +	struct sst_hsw *hsw = pdata->hsw;
> > +	int ret = 0;
> > +	enum sst_hsw_module_id id = SST_HSW_MODULE_WAVES;
> > +	bool switch_on = (bool)ucontrol->value.integer.value[0];
> > +
> > +	if (sst_hsw_is_module_loaded(hsw, id)) {
> > +		if (switch_on == sst_hsw_is_module_active(hsw, id))
> > +			return 0;
> > +
> > +		/* ipc is valid only when module is loaded */
> > +		if (switch_on)
> > +			ret = sst_hsw_module_enable(hsw, id, 0);
> > +		else
> > +			ret = sst_hsw_module_disable(hsw, id, 0);
> > +	}
> 
> I'm not clear how this setting is saved when the module is not in RAM on the
> DSP.  If the module enable/disable calls do that that's fine but I'd expect the
> function to return an error if the module isn't loaded (or better yet for the
> control not to be made visible to userspace at all) - we shouldn't be silently
> ignoring what the user is setting.

[Han] if module is not in RAM on the DSP, sst_hsw_is_module_loaded() will return false. Also sst_hsw_module_enable() and sst_hsw_module_disable() will check the module status in DSP before send IPC commands to DSP.
In case sst_hsw_is_module_loaded() return false, (eg. System go RTD3 and modules in DSP RAM be unloaded) the user setting will be stored in variant u32 enabled_modules_rtd3, which is implemented in patch 0005. So which is better for next version of patch, to add error return here, merge patch 0005 with 0004, or  do not change this part? Thanks.
