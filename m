From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 13/19] ASoC: Intel: mrfld: add bytes
 control for modules
Date: Mon, 23 Jun 2014 09:45:00 +0530
Message-ID: <20140623041500.GN22053@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-14-git-send-email-vinod.koul@intel.com>
 <53A3ECAB.404@metafoo.de> <20140620113013.GH22053@intel.com>
 <53A428C8.9030707@metafoo.de> <20140621061605.GJ22053@intel.com>
 <53A523E1.1080808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 87033260864
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 06:15:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53A523E1.1080808@metafoo.de>
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

On Sat, Jun 21, 2014 at 08:19:13AM +0200, Lars-Peter Clausen wrote:
> >>>>>+static const struct snd_kcontrol_new sst_algo_controls[] = {
> >>>>>+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "fir", 272, SST_MODULE_ID_FIR_24,
> >>>>>+		 SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "iir", 300, SST_MODULE_ID_IIR_24,
> >>>>>+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "mdrp", 286, SST_MODULE_ID_MDRP,
> >>>>>+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "fir", 272, SST_MODULE_ID_FIR_24,
> >>>>>+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "iir", 300, SST_MODULE_ID_IIR_24,
> >>>>>+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "mdrp", 286, SST_MODULE_ID_MDRP,
> >>>>>+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("sprot_loop_out", "lpro", 192, SST_MODULE_ID_SPROT,
> >>>>>+		SST_PATH_INDEX_SPROT_LOOP_OUT, 0, SST_TASK_SBA, SBA_VB_LPRO),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("codec_in0", "dcr", 52, SST_MODULE_ID_FILT_DCR,
> >>>>>+		SST_PATH_INDEX_CODEC_IN0, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>>>>+	SST_ALGO_KCONTROL_BYTES("codec_in1", "dcr", 52, SST_MODULE_ID_FILT_DCR,
> >>>>>+		SST_PATH_INDEX_CODEC_IN1, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
> >>>>
> >>>>
> >>>>You are creating a lot of global non-const variables here that are
> >>>>later modified in the put and get handlers and also elsewhere.
> >>>Sorry which ones above are modfied. Above values are information for headers of
> >>>IPCs which we send to DSPs
> >>>
> >>
> >>The SST_ALGO_CTL_VALUE() macro uses compound literals to create a
> >>global (nameless) struct. A pointer to this struct is assigned to
> >>the kcontrols private_value field. This is later read and the struct
> >>is modified.
> >Yes but not the above values as these as IPC header info which DSP needs.
> >
> 
> The SST_ALGO_KCONTROL_BYTES() macro calls SST_ALGO_KCONTROL() which
> in return calls SST_ALGO_CTL_VALUE()
Yes and 
#define SST_ALGO_CTL_VALUE(xcount, xtype, xpipe, xmod, xtask, xcmd)	\
        (struct sst_algo_control){					\
                .max = xcount + sizeof(u16), .type = xtype, .module_id = xmod,\
                .pipe_id = xpipe, .task_id = xtask, .cmd_id = xcmd,\
        }

So these values passed above are filled here and put in private_data as you
rightly noticed. But later on get/put handlers will not modify these specfic
value but other private value. Above are used _only_ for IPC headers to DSP so
we cant afford to modify them. We cna try making these values above as
consts, static

-- 
~Vinod
