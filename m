From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ALSA: pcsp: Use common error handling code
 in snd_card_pcsp_probe()
Date: Tue, 22 Aug 2017 15:16:25 +0300
Message-ID: <20170822121625.syvr64kwyh5xjexg@mwanda>
References: <08ee0d6b-788b-2845-6964-e1e55c2d2292@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 7552D266D1A
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:16:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <08ee0d6b-788b-2845-6964-e1e55c2d2292@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

  	err = snd_card_register(card);
> -	if (err < 0) {
> +	if (err) {
> +free_card:
>  		snd_card_free(card);
>  		return err;
>  	}

I thought we agreed, yesterday, to never use this style of error
handling?

regards,
dan carpenter
