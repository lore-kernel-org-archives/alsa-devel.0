From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/2] ASoC: Intel: Add Kabylake machine
 driver for RT5663
Date: Thu, 27 Jul 2017 13:50:29 +0530
Message-ID: <20170727082029.GO3053@localhost>
References: <20170727025400.6426-1-kevin.cheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4701B266998
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 10:17:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170727025400.6426-1-kevin.cheng@intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 27, 2017 at 10:53:58AM +0800, Kevin Cheng wrote:
> Add kabylake machine driver & corresponding driver entry in machine table for
> rt5663 codec.
> 
> For this particular machine,
>  the RT5663 is a headset codec connected on ssp1.
>   there is no dmic and speaker connected.
> 
> Modify the machine driver in kbl_rt5663_max98927 to reuse the
>   common codes.

Hello Kevin,

The patch series looks good to me, but will unfortunately get ignored as you
have not CCed maintainers.

Please resend it and CC Takash and Mark

> 
> V2: adjust the code order.
> 
> Kevin Cheng (2):
>   ASoC: Intel: Add Kabylake machine driver for RT5663
>   ASoC: Intel: Add Kabylake RT5663 machine driver entry
> 
>  sound/soc/intel/boards/kbl_rt5663_max98927.c | 246 +++++++++++++++++++++++----
>  sound/soc/intel/skylake/skl.c                |   5 +
>  2 files changed, 214 insertions(+), 37 deletions(-)
> 
> -- 
> 2.12.2
> 

-- 
~Vinod
