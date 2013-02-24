From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] tinycompres: remove unused variable
Date: Sun, 24 Feb 2013 19:49:39 +0530
Message-ID: <20130224141939.GD23711@intel.com>
References: <1361557024-24437-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 60F322650BC
 for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2013 15:20:11 +0100 (CET)
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
 r1OEJeQf003432
 for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2013 19:49:40 +0530
Received: (from vkoul@localhost)
 by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r1OEJdm7003431
 for alsa-devel@alsa-project.org; Sun, 24 Feb 2013 19:49:39 +0530
Content-Disposition: inline
In-Reply-To: <1361557024-24437-1-git-send-email-vinod.koul@intel.com>
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

On Fri, Feb 22, 2013 at 11:47:04PM +0530, Vinod Koul wrote:
> cplay.c:210: warning: unused variable i
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Applied

--
~Vinod
> ---
>  cplay.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/cplay.c b/cplay.c
> index e52d641..5b4e83e 100644
> --- a/cplay.c
> +++ b/cplay.c
> @@ -207,7 +207,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
>  	FILE *file;
>  	char *buffer;
>  	int size, num_read, wrote;
> -	unsigned int i, channels, rate, bits;
> +	unsigned int channels, rate, bits;
>  
>  	if (verbose)
>  		printf("%s: entry\n", __func__);
> -- 
> 1.7.0.4
> 
