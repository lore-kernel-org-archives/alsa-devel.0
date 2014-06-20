From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 13/19] ASoC: Intel: mrfld: add bytes
 control for modules
Date: Fri, 20 Jun 2014 10:11:23 +0200
Message-ID: <53A3ECAB.404@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-14-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-238.synserver.de
 [212.40.185.238])
 by alsa0.perex.cz (Postfix) with ESMTP id D294E2619DB
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 10:11:25 +0200 (CEST)
In-Reply-To: <1402662848-24534-14-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/13/2014 02:34 PM, Vinod Koul wrote:
[...]
> +
> +static int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_info *uinfo)
> +{
> +	struct sst_algo_control *bc = (void *)kcontrol->private_value;
> +	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);

This won't work in asoc/for-next. Use snd_soc_kcontrol_platform(kcontrol).

> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
> +	uinfo->count = bc->max;
> +
> +	/* allocate space to cache the algo parameters in the driver */
> +	if (bc->params == NULL) {
> +		bc->params = devm_kzalloc(platform->dev, bc->max, GFP_KERNEL);
> +		if (bc->params == NULL) {
> +			pr_err("kzalloc failed\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int sst_algo_control_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
[...]
> +}
> +
> +static int sst_algo_control_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
[...]
> +}

You probably want some kind of locking around the put and get handlers.

> +
> +static const struct snd_kcontrol_new sst_algo_controls[] = {
> +	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "fir", 272, SST_MODULE_ID_FIR_24,
> +		 SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
> +	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "iir", 300, SST_MODULE_ID_IIR_24,
> +		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> +	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "mdrp", 286, SST_MODULE_ID_MDRP,
> +		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
> +	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "fir", 272, SST_MODULE_ID_FIR_24,
> +		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
> +	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "iir", 300, SST_MODULE_ID_IIR_24,
> +		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> +	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "mdrp", 286, SST_MODULE_ID_MDRP,
> +		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
> +	SST_ALGO_KCONTROL_BYTES("sprot_loop_out", "lpro", 192, SST_MODULE_ID_SPROT,
> +		SST_PATH_INDEX_SPROT_LOOP_OUT, 0, SST_TASK_SBA, SBA_VB_LPRO),
> +	SST_ALGO_KCONTROL_BYTES("codec_in0", "dcr", 52, SST_MODULE_ID_FILT_DCR,
> +		SST_PATH_INDEX_CODEC_IN0, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> +	SST_ALGO_KCONTROL_BYTES("codec_in1", "dcr", 52, SST_MODULE_ID_FILT_DCR,
> +		SST_PATH_INDEX_CODEC_IN1, 0, SST_TASK_SBA, SBA_VB_SET_IIR),


You are creating a lot of global non-const variables here that are later 
modified in the put and get handlers and also elsewhere.

> +
> +};
