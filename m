From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] fix one memory leak in sound jack
Date: Mon, 21 Feb 2011 13:56:45 +0800
Message-ID: <20110221055645.GA7972@localhost>
References: <1298267104-28697-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 3541C103803
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 06:56:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298267104-28697-1-git-send-email-guanqun.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lu, Guanqun" <guanqun.lu@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "tj@kernel.org" <tj@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "mranostay@embeddedalley.com" <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Guanqun, it helps to point out the commit that first introduced the
problem.

Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>

On Mon, Feb 21, 2011 at 01:45:04PM +0800, Lu Guanqun wrote:
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> ---
>  sound/core/jack.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/core/jack.c b/sound/core/jack.c
> index 4902ae5..53b53e9 100644
> --- a/sound/core/jack.c
> +++ b/sound/core/jack.c
> @@ -141,6 +141,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
>  
>  fail_input:
>  	input_free_device(jack->input_dev);
> +	kfree(jack->id);
>  	kfree(jack);
>  	return err;
>  }
> -- 
> 1.7.2.3
