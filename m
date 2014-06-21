From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 13/19] ASoC: Intel: mrfld: add bytes
 control for modules
Date: Sat, 21 Jun 2014 11:46:05 +0530
Message-ID: <20140621061605.GJ22053@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-14-git-send-email-vinod.koul@intel.com>
 <53A3ECAB.404@metafoo.de> <20140620113013.GH22053@intel.com>
 <53A428C8.9030707@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EBA8C2650C2
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 08:15:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53A428C8.9030707@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 20, 2014 at 02:27:52PM +0200, Lars-Peter Clausen wrote:
> On 06/20/2014 01:30 PM, Vinod Koul wrote:
> >On Fri, Jun 20, 2014 at 10:11:23AM +0200, Lars-Peter Clausen wrote:
> >>On 06/13/2014 02:34 PM, Vinod Koul wrote:
> >>>+static int sst_algo_control_set(struct snd_kcontrol *kcontrol,
> >>>+				struct snd_ctl_elem_value *ucontrol)
> >>>+{
> >>[...]
> >>>+}
> >>
> >>You probably want some kind of locking around the put and get handlers.
> >Is that for prevting get/set races? I though the mixer implemention in
> >sound/core would lock against that?
> 
> There core doesn't do any locking on the put and get handlers. If
> you need locking you need to do it by hand.
> 
> >
> >>>+
> >>>+static const struct snd_kcontrol_new sst_algo_controls[] = {
> >>>+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "fir", 272, SST_MODULE_ID_FIR_24,
> >>>+		 SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
> >>>+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "iir", 300, SST_MODULE_ID_IIR_24,
> >>>+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>>+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "mdrp", 286, SST_MODULE_ID_MDRP,
> >>>+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
> >>>+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "fir", 272, SST_MODULE_ID_FIR_24,
> >>>+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
> >>>+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "iir", 300, SST_MODULE_ID_IIR_24,
> >>>+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>>+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "mdrp", 286, SST_MODULE_ID_MDRP,
> >>>+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
> >>>+	SST_ALGO_KCONTROL_BYTES("sprot_loop_out", "lpro", 192, SST_MODULE_ID_SPROT,
> >>>+		SST_PATH_INDEX_SPROT_LOOP_OUT, 0, SST_TASK_SBA, SBA_VB_LPRO),
> >>>+	SST_ALGO_KCONTROL_BYTES("codec_in0", "dcr", 52, SST_MODULE_ID_FILT_DCR,
> >>>+		SST_PATH_INDEX_CODEC_IN0, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>>+	SST_ALGO_KCONTROL_BYTES("codec_in1", "dcr", 52, SST_MODULE_ID_FILT_DCR,
> >>>+		SST_PATH_INDEX_CODEC_IN1, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>
> >>
> >>You are creating a lot of global non-const variables here that are
> >>later modified in the put and get handlers and also elsewhere.
> >Sorry which ones above are modfied. Above values are information for headers of
> >IPCs which we send to DSPs
> >
> 
> The SST_ALGO_CTL_VALUE() macro uses compound literals to create a
> global (nameless) struct. A pointer to this struct is assigned to
> the kcontrols private_value field. This is later read and the struct
> is modified.
Yes but not the above values as these as IPC header info which DSP needs.

-- 
~Vinod
