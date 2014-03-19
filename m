From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: Pass through return value
 of open ops callback
Date: Wed, 19 Mar 2014 20:06:33 +0530
Message-ID: <20140319143633.GH1976@intel.com>
References: <1395233979-7675-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 89FD72650D1
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 15:42:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1395233979-7675-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 19, 2014 at 12:59:39PM +0000, Charles Keepax wrote:
> The snd_compr_open function would always return 0 even if the compressed
> ops open function failed, obviously this is incorrect. Looks like this
> was introduced by a small typo in:
> 
> commit a0830dbd4e42b38aefdf3fb61ba5019a1a99ea85
> ALSA: Add a reference counter to card instance
> 
> This patch returns the value from the compressed op as it should.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Acked-by: Vinod Koul <vinod.koul@intel..com>

-- 
~Vinod

> ---
>  sound/core/compress_offload.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 7a20897..7403f34 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -133,7 +133,7 @@ static int snd_compr_open(struct inode *inode, struct file *f)
>  		kfree(data);
>  	}
>  	snd_card_unref(compr->card);
> -	return 0;
> +	return ret;
>  }
>  
>  static int snd_compr_free(struct inode *inode, struct file *f)
> -- 
> 1.7.2.5
> 

-- 
