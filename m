From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Wed, 17 Sep 2014 16:25:57 +0530
Message-ID: <27592.0688909993$1410952752@news.gmane.org>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 43C04265334
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 13:18:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140916193053.GD7960@sirena.org.uk>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 16, 2014 at 12:30:53PM -0700, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 03:11:28PM +0530, Subhransu S. Prusty wrote:
> 
> > +	mutex_lock(&drv->lock);
> > +	map = is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
> > +
> > +	val = 1 << ctl_no;
> > +	mux = ucontrol->value.enumerated.item[0];
> > +	if (mux > e->max - 1) {
> > +		mutex_unlock(&drv->lock);
> > +		return -EINVAL;
> > +	}
> 
> This is still in parameter validation so we don't need to have the lock
> yet at all.
Yes will move it.
> 
> > +	/*first clear all registers of this bit*/
> > +	for (i = 0; i < e->max; i++)
> > +		map[i] &= ~val;
> > +
> > +	if (mux == 0) /*kctl set to 'none'*/
> > +		return 0;
> 
> This is returning with the lock still held AFAICT.  I'm a bit surprised
> that we don't need to interact with the hardware if we've disabled
> everything, shouldn't this have some effect on the hardware?
> 
> Also the coding style thing with the comments again.
Will fix the locking and comment.

Regarding interaction with the driver, the slot map is cached and sent in
sst_set_be_modules event. This is sent only when that particular BE is
active, otherwise driver will happily cache these values.
This is the reason why we don't see trigger to DSP when usermode fiddles
around.

In our model only when a particular FE/BE/Mixer/Pipe is active we forward
the settings and parameters, rest we keep the values  in driver and forward
when DAPM enables them.

I think we can add this explanation here at top of this file to help.

> 
> > +static void sst_find_and_send_pipe_algo(struct sst_data *drv,
> > +					const char *pipe, struct sst_ids *ids)
> > +{
> > +	struct sst_algo_control *bc;
> > +	struct sst_module *algo = NULL;
> > +
> > +	dev_dbg(&drv->pdev->dev, "Enter: widget=%s\n", pipe);
> > +
> > +	list_for_each_entry(algo, &ids->algo_list, node) {
> > +		bc = (void *)algo->kctl->private_value;
> > +
> > +		dev_dbg(&drv->pdev->dev, "Found algo control name=%s pipe=%s\n",
> > +				algo->kctl->id.name, pipe);
> > +		sst_send_algo_cmd(drv, bc);
> > +	}
> > +}
> 
> I'm not seeing any handling if we failed to find anything here.
> 
> > +	[SST_IP_MEDIA2]		= SST_SWM_IN_MEDIA2,
> > +	[SST_IP_MEDIA3]		= SST_SWM_IN_MEDIA3,
> > +};
> > +static void sst_set_pipe_gain(struct sst_ids *ids,
> 
> Coding style - no blank line.  This is quite common in this patch and
> something that's been an issue in previous versions of this series too.
Will fix.
> 
> > +	if (enable)
> > +		sst->ops->power(sst->dev, true);
> > +
> > +	mutex_lock(&drv->lock);
> > +	if (enable)
> > +		timer_usage++;
> > +	else
> > +		timer_usage--;
> 
> This seems a bit strange.  We're doing the enable outside the lock, then
> taking the lock, then doing some refcounting outside the lock.
lock is required only to protect the timer_usage counter update, where as
the power ops is to power up the DSP. If the DSP is already up, enable
command is not sent and the counter is updated. DSP disable command is not
sent until the last disable.
Yes we need to add the error handling for power ops.
> 
> > +	mutex_unlock(&drv->lock);
> > +
> > +	if (!enable)
> > +		sst->ops->power(sst->dev, false);
> 
> Same thing here.  How does the power management work here, it doesn't
> seem joined up?  I'd really like to see some comments explaining what's
> going on with this stuff.

Power ops in SST takes care of the PM handling.
Following comment is already added in the code which explains.
"Send the command only if this call is the first enable or last disable"

Let us know if it is not clear enough.
> 
> > +static bool is_sst_dapm_widget(struct snd_soc_dapm_widget *w)
> > +{
> > +	if ((w->id == snd_soc_dapm_pga) ||
> > +	    (w->id == snd_soc_dapm_aif_in) ||
> > +	    (w->id == snd_soc_dapm_aif_out) ||
> > +	    (w->id == snd_soc_dapm_input) ||
> > +	    (w->id == snd_soc_dapm_output) ||
> > +	    (w->id == snd_soc_dapm_mixer))
> > +		return true;
> > +	else
> > +		return false;
> > +}
> 
> Use a switch statement please.
Sure.


-- 
