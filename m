From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [patch 3/3] Staging: sst: fixups in
	SNDRV_SST_STREAM_DECODE
Date: Thu, 21 Oct 2010 19:46:34 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BE8125B7@bgsmsx502.gar.corp.intel.com>
References: <20101019055748.GE5839@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id D8E692447B
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 16:16:44 +0200 (CEST)
In-Reply-To: <20101019055748.GE5839@bicker>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> This is another patch about copying data to the kernel before using it.
> 
> SNDRV_SST_STREAM_DECODE is sort of tricky because we need to do a
> copy_from_user() that gives us another two pointers and we have copy
> those.  Those again give us some more pointers that we have to copy.
> 
> Besides those problems, the code had a stack overflow:
> -	struct snd_sst_buff_entry ibuf_temp[param->ibufs->entries],
> -		obuf_temp[param->obufs->entries];
> param->ibufs->entries comes from the user.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
