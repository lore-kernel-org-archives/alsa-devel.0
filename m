From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/2] ASoC: Intel: Add Kabylake machine
 driver for RT5663
Date: Fri, 28 Jul 2017 08:51:31 +0530
Message-ID: <20170728032130.GT3053@localhost>
References: <20170727083837.3793-1-kevin.cheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 06E0926761A
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 05:18:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170727083837.3793-1-kevin.cheng@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Cheng <kevin.cheng@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 27, 2017 at 04:38:35PM +0800, Kevin Cheng wrote:
> Add kabylake machine driver & corresponding driver entry in machine table for
> rt5663 codec.
> 
> For this particular machine,
>  the RT5663 is a headset codec connected on ssp1.
>   there is no dmic and speaker connected.
> 
> Modify the machine driver in kbl_rt5663_max98927 to reuse the
>   common codes.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
