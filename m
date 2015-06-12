From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] genalloc: rename of_get_named_gen_pool() to
 of_gen_pool_get()
Date: Fri, 12 Jun 2015 14:54:24 +0530
Message-ID: <20150612092424.GF28601@localhost>
References: <1434029192-7082-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1434029312-7288-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434029312-7288-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2015 at 04:28:32PM +0300, Vladimir Zapolskiy wrote:
> To be consistent with other kernel interface namings, rename
> of_get_named_gen_pool() to of_gen_pool_get(). In the original
> function name "_named" suffix references to a device tree property,
> which contains a phandle to a device and the corresponding
> device driver is assumed to register a gen_pool object.
> 
> Due to a weak relation and to avoid any confusion (e.g. in future
> possible scenario if gen_pool objects are named) the suffix is
> removed.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/dma/mmp_tdma.c                    | 2 +-
For this:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
