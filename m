From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ucm: Set uc_mgr->ctl to NULL after closing
	it.
Date: Mon, 28 Jan 2013 09:19:03 +0000
Message-ID: <1359364743.2532.1.camel@localhost.localdomain>
References: <1359202820-9896-1-git-send-email-tanuk@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D2A261672
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 10:19:06 +0100 (CET)
In-Reply-To: <1359202820-9896-1-git-send-email-tanuk@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: Luke Yelavich <themuso@ubuntu.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2013-01-26 at 14:20 +0200, Tanu Kaskinen wrote:
> Fixes a double-free bug.
> 
> Signed-off-by: Tanu Kaskinen <tanuk@iki.fi>
> ---
>  src/ucm/main.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/ucm/main.c b/src/ucm/main.c
> index 0d7d841..d8b8ada 100644
> --- a/src/ucm/main.c
> +++ b/src/ucm/main.c
> @@ -145,6 +145,7 @@ static int open_ctl(snd_use_case_mgr_t *uc_mgr,
>  		free(uc_mgr->ctl_dev);
>  		uc_mgr->ctl_dev = NULL;
>  		snd_ctl_close(uc_mgr->ctl);
> +		uc_mgr->ctl = NULL;
>  	
>  	}
>  	err = snd_ctl_open(ctl, ctl_dev, 0);

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
