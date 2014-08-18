From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [v4 05/12] ASoC: Intel: mrfld: add bytes control
	for modules
Date: Mon, 18 Aug 2014 11:06:09 +0530
Message-ID: <491.11923804066$1408341536@news.gmane.org>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140813200012.GO17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 26EB0265473
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 07:57:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140813200012.GO17528@sirena.org.uk>
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

On Wed, Aug 13, 2014 at 09:00:12PM +0100, Mark Brown wrote:
> On Mon, Aug 04, 2014 at 03:15:56PM +0530, Subhransu S. Prusty wrote:
> 
> > From: Vinod Koul <vinod.koul@intel.com>
> 
> > This patch add support for various modules like eq etc for mrfld DSP. All these
> > modules will be exposed to usermode as bytes controls.
> 
> Indeed they are actually exposed by this code.
> 
> > +static inline void sst_fill_byte_control(char *param,
> > +					 u8 ipc_msg, u8 block,
> > +					 u8 task_id, u8 pipe_id,
> > +					 u16 len, void *cmd_data)
> 
> Let the compiler figure out if this should be inline, this doesn't seem
> something that should obviously be inline and isn't in a header.
Ok
> 
> > +	if (len > SST_MAX_BIN_BYTES - sizeof(*byte_data)) {
> > +		WARN(1, "%s: command length too big (%u)", __func__, len); /* this happens only if code is wrong */
> > +		len = SST_MAX_BIN_BYTES - sizeof(*byte_data);
> > +	}
> 
> Coding style, 80 columns.  Since the only caller can return an error
> code you could do that here too.
Yes.
> 
> > +static int sst_fill_and_send_cmd_unlocked(struct sst_data *drv,
> > +				 u8 ipc_msg, u8 block, u8 task_id, u8 pipe_id,
> > +				 void *cmd_data, u16 len)
> > +{
> > +	sst_fill_byte_control(drv->byte_stream, ipc_msg, block, task_id, pipe_id,
> > +			      len, cmd_data);
> > +	return sst->ops->send_byte_stream(sst->dev,
> > +			(struct snd_sst_bytes_v2 *)drv->byte_stream);
> > +}
> 
> There's a lot of casting going on in this code.
Not required. Should have been removed.
> 
> > +static int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
> > +			    struct snd_ctl_elem_info *uinfo)
> > +{
> > +	struct sst_algo_control *bc = (void *)kcontrol->private_value;
> > +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> > +
> > +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
> > +	uinfo->count = bc->max;
> > +
> > +	/* allocate space to cache the algo parameters in the driver */
> > +	if (bc->params == NULL) {
> > +		bc->params = devm_kzalloc(component->dev, bc->max, GFP_KERNEL);
> > +		if (bc->params == NULL)
> > +			return -ENOMEM;
> > +	}
> > +	return 0;
> > +}
> 
> I wouldn't expect an info call to be allocating anything - why is it
> doing that?  It's not looking at the alocated data except to see if the
> allocation succeeded.  What happens if someone manages to do a get or
> set without having first done an info and why aren't we doing any
> allocation on initialisation?

Will move after control initialization.
> 
> > +	case SST_ALGO_BYPASS:
> > +		ucontrol->value.integer.value[0] = bc->bypass ? 1 : 0;
> > +		pr_debug("%s: bypass  %d\n", __func__, bc->bypass);
> > +		break;
> 
> Is bypass not a boolean value already, and shouldn't these just end up
> with controls called something "Switch" - they look to be just directly
> usable switches?
Actually BYPASS is not required. Will remove.
> 
> > +	default:
> > +		pr_err("Invalid Input- algo type:%d\n", bc->type);
> 
> dev_err().
We are using pr_err() in all the error conditions for our driver. If it is
really required to change, we can submit a single patch to change to
dev_err() once the patches are merged.
> 
> > +	switch (bc->type) {
> > +	case SST_ALGO_PARAMS:
> > +		if (bc->params)
> > +			memcpy(bc->params, ucontrol->value.bytes.data, bc->max);
> > +		break;
> 
> So if bc->params didn't get allocated somehow we just silently drop the
> set?
With above params initialization changes this check will not be required any
more.
> 
> > +	/*if pipe is enabled, need to send the algo params from here */
> > +	if (bc->w && bc->w->power)
> > +		sst_send_algo_cmd(drv, bc);
> 
> sst_send_algo_cmd() should be returning an eror code (it doesn't but the
> functions it calls can).
> 
> I'm not seeing any code to restore these controls on power up here.

Will take care of the return code.

sst_find_and_send_pipe_algo takes care of restoring the controls on power
up.

-- 
