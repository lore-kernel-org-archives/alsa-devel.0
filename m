From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 13/19] ASoC: Intel: mrfld: add bytes
 control for modules
Date: Fri, 20 Jun 2014 14:27:52 +0200
Message-ID: <53A428C8.9030707@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-14-git-send-email-vinod.koul@intel.com>
 <53A3ECAB.404@metafoo.de> <20140620113013.GH22053@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-018.synserver.de
 [212.40.185.18])
 by alsa0.perex.cz (Postfix) with ESMTP id ED0562650F0
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 14:27:52 +0200 (CEST)
In-Reply-To: <20140620113013.GH22053@intel.com>
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

On 06/20/2014 01:30 PM, Vinod Koul wrote:
> On Fri, Jun 20, 2014 at 10:11:23AM +0200, Lars-Peter Clausen wrote:
>> On 06/13/2014 02:34 PM, Vinod Koul wrote:
>>> +static int sst_algo_control_set(struct snd_kcontrol *kcontrol,
>>> +				struct snd_ctl_elem_value *ucontrol)
>>> +{
>> [...]
>>> +}
>>
>> You probably want some kind of locking around the put and get handlers.
> Is that for prevting get/set races? I though the mixer implemention in
> sound/core would lock against that?

There core doesn't do any locking on the put and get handlers. If you need 
locking you need to do it by hand.

>
>>> +
>>> +static const struct snd_kcontrol_new sst_algo_controls[] = {
>>> +	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "fir", 272, SST_MODULE_ID_FIR_24,
>>> +		 SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
>>> +	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "iir", 300, SST_MODULE_ID_IIR_24,
>>> +		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
>>> +	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "mdrp", 286, SST_MODULE_ID_MDRP,
>>> +		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
>>> +	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "fir", 272, SST_MODULE_ID_FIR_24,
>>> +		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
>>> +	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "iir", 300, SST_MODULE_ID_IIR_24,
>>> +		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
>>> +	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "mdrp", 286, SST_MODULE_ID_MDRP,
>>> +		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
>>> +	SST_ALGO_KCONTROL_BYTES("sprot_loop_out", "lpro", 192, SST_MODULE_ID_SPROT,
>>> +		SST_PATH_INDEX_SPROT_LOOP_OUT, 0, SST_TASK_SBA, SBA_VB_LPRO),
>>> +	SST_ALGO_KCONTROL_BYTES("codec_in0", "dcr", 52, SST_MODULE_ID_FILT_DCR,
>>> +		SST_PATH_INDEX_CODEC_IN0, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
>>> +	SST_ALGO_KCONTROL_BYTES("codec_in1", "dcr", 52, SST_MODULE_ID_FILT_DCR,
>>> +		SST_PATH_INDEX_CODEC_IN1, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
>>
>>
>> You are creating a lot of global non-const variables here that are
>> later modified in the put and get handlers and also elsewhere.
> Sorry which ones above are modfied. Above values are information for headers of
> IPCs which we send to DSPs
>

The SST_ALGO_CTL_VALUE() macro uses compound literals to create a global 
(nameless) struct. A pointer to this struct is assigned to the kcontrols 
private_value field. This is later read and the struct is modified.

- Lars
