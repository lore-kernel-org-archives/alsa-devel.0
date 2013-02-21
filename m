From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] compress: make variable 'running' as
	unsigned
Date: Thu, 21 Feb 2013 15:51:58 +0530
Message-ID: <20130221102158.GB8451@intel.com>
References: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA4C264F1A
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 11:22:39 +0100 (CET)
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
 r1LALxFK008721
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 15:52:00 +0530
Received: (from vkoul@localhost)
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r1LALwsX008719
 for alsa-devel@alsa-project.org; Thu, 21 Feb 2013 15:51:58 +0530
Content-Disposition: inline
In-Reply-To: <1361196915-12121-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2013 at 07:45:12PM +0530, Vinod Koul wrote:
> as we never expect this to be negative
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Applied, all...

> ---
>  compress.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/compress.c b/compress.c
> index 19d618a..a8964f4 100644
> --- a/compress.c
> +++ b/compress.c
> @@ -83,7 +83,7 @@ struct compress {
>  	__u64 buffer_size;
>  	char error[COMPR_ERR_MAX];
>  	struct compr_config *config;
> -	int running:1;
> +	unsigned int running:1;
>  };
>  
>  static int oops(struct compress *compress, int e, const char *fmt, ...)
> -- 
> 1.7.0.4
> 
