Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 202782625DB
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 12:15:54 +0200 (CEST)
Date: Thu, 31 Jul 2014 15:24:42 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140731095435.GA32213@vinod.koul@linux.intel.com>
References: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
 <1406725350-23275-7-git-send-email-subhransu.s.prusty@intel.com>
 <s5hfvhjrm5n.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5hfvhjrm5n.wl%tiwai@suse.de>
Subject: Re: [alsa-devel] [v3 06/13] ASoC: Intel: mrfld: add bytes control
 for	modules
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-ID: <alsa-devel@alsa-project.org>

On Wed, Jul 30, 2014 at 03:50:12PM +0200, Takashi Iwai wrote:
> At Wed, 30 Jul 2014 18:32:23 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Vinod Koul <vinod.koul@intel.com>
> > 
> > This patch add support for various modules like eq etc for mrfld DSP. All these
> > modules will be exposed to usermode as bytes controls.
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > ---
> >  sound/soc/intel/sst-atom-controls.c | 176 ++++++++++++++++++++++++++++++++++++
> >  sound/soc/intel/sst-atom-controls.h | 130 ++++++++++++++++++++++++++
> >  2 files changed, 306 insertions(+)
> > 
> > diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
> > index 38731e3e5e95..9b878c17d10a 100644
> > --- a/sound/soc/intel/sst-atom-controls.c
> > +++ b/sound/soc/intel/sst-atom-controls.c
> > @@ -25,6 +25,180 @@
> >  #include "sst-mfld-platform.h"
> >  #include "sst-atom-controls.h"
> >  
> > +static inline void sst_fill_byte_control(char *param,
> > +					 u8 ipc_msg, u8 block,
> > +					 u8 task_id, u8 pipe_id,
> > +					 u16 len, void *cmd_data)
> > +{
> > +
> > +	struct snd_sst_bytes_v2 *byte_data = (struct snd_sst_bytes_v2 *)param;
> > +
> > +	byte_data->type = SST_CMD_BYTES_SET;
> > +	byte_data->ipc_msg = ipc_msg;
> > +	byte_data->block = block;
> > +	byte_data->task_id = task_id;
> > +	byte_data->pipe_id = pipe_id;
> > +
> > +	if (len > SST_MAX_BIN_BYTES - sizeof(*byte_data)) {
> > +		pr_err("%s: command length too big (%u)", __func__, len);
> > +		len = SST_MAX_BIN_BYTES - sizeof(*byte_data);
> > +		WARN_ON(1); /* this happens only if code is wrong */
> > +	}
> 
> Better to use simply WARN() for the condition and the message.
Ok

> 
> 
> > +static void sst_send_algo_cmd(struct sst_data *drv,
> > +			      struct sst_algo_control *bc)
> > +{
> > +	int len;
> > +	struct sst_cmd_set_params *cmd;
> > +
> > +	if (bc->params == NULL)
> > +		return;
> > +
> > +	/* bc->max includes sizeof algos + length field */
> > +	len = sizeof(cmd->dst) + sizeof(cmd->command_id) + bc->max;
> > +
> > +	cmd = kzalloc(len, GFP_KERNEL);
> > +	if (cmd == NULL) {
> > +		pr_err("Failed to send cmd, kzalloc failed\n");
> 
> Superfluous error message (in other places, too).
Sure will remove these.
> 
> > +static int sst_algo_control_set(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(kcontrol);
> > +	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
> > +	struct sst_algo_control *bc = (void *)kcontrol->private_value;
> > +
> > +	pr_debug("in %s control_name=%s\n", __func__, kcontrol->id.name);
> > +	mutex_lock(&drv->lock);
> > +	switch (bc->type) {
> > +	case SST_ALGO_PARAMS:
> > +		if (bc->params)
> > +			memcpy(bc->params, ucontrol->value.bytes.data, bc->max);
> > +		break;
> > +	case SST_ALGO_BYPASS:
> > +		bc->bypass = !!ucontrol->value.integer.value[0];
> > +		break;
> > +	default:
> > +		mutex_unlock(&drv->lock);
> > +		pr_err("Invalid Input- algo type:%ld\n", ucontrol->value.integer.value[0]);
> 
> Shouldn't this be bc->type?
Yes
> 
> 
> Takashi

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
