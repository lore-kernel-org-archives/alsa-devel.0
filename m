Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F17A4265114
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:41:03 +0200 (CEST)
Date: Mon, 1 Sep 2014 17:48:50 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140901121850.GD12898@vinod.koul@linux.intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140827204147.GZ17528@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140827204147.GZ17528@sirena.org.uk>
Subject: Re: [alsa-devel] [v3 05/11] ASoC: Intel: sst: add stream operations
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
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Wed, Aug 27, 2014 at 09:41:47PM +0100, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 06:20:44PM +0530, Subhransu S. Prusty wrote:
> 
> > +	/*allocate device type context*/
> > +	sst_init_stream(&sst_drv_ctx->streams[str_id], alloc_param.codec_type,
> > +			str_id, alloc_param.operation, 0);
> > +	/* send msg to FW to allocate a stream */
> 
> /*spaces around the edge of comments like the second not the first*/
> 
> This is an issue in quite a lot of places.
> 
will remove.
> > +
> > +/**
> > +* sst_start_stream - Send msg for a starting stream
> 
> /*
>  *
> 
> > +		sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
> > +				str_info->task_id, 1, pvt_id);
> > +		msg->mrfld_header.p.header_high.part.res_rqd = 1;
> > +		len = sizeof(dsp_hdr);
> > +		msg->mrfld_header.p.header_low_payload = len;
> > +		sst_fill_header_dsp(&dsp_hdr,
> > +					IPC_IA_RESUME_STREAM_MRFLD,
> > +					str_info->pipe_id, 0);
> > +		memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
> > +		sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
> > +		retval = sst_wait_timeout(sst_drv_ctx, block);
> > +		sst_free_block(sst_drv_ctx, block);
> 
> Can any of this be factored out?  Seems like a lot of duplication in
> these operations.
Will check.


-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
