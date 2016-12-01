From: tndave <tushar.n.dave@oracle.com>
Subject: Re: [patch] dbri: move dereference after check for NULL
Date: Wed, 30 Nov 2016 22:14:26 -0800
Message-ID: <7cd722db-08d4-4c96-9e31-a8d98365e6f3@oracle.com>
References: <20161201054830.GA20077@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20161201054830.GA20077@mwanda>
Sender: sparclinux-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "David S. Miller" <davem@davemloft.net>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, thomas tai <thomas.tai@oracle.com>, alsa-devel@alsa-project.org, sparclinux@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 11/30/2016 09:48 PM, Dan Carpenter wrote:
> We accidentally introduced a dereference before the NULL check in
> xmit_descs() as part of silencing a GCC warning.
>
> Fixes: 16f46050e709 ("dbri: Fix compiler warning")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Goes into the sparc tree.
>
> diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
> index 3fe4468..52063b2 100644
> --- a/sound/sparc/dbri.c
> +++ b/sound/sparc/dbri.c
> @@ -1702,7 +1702,7 @@ interrupts are disabled.
>  static void xmit_descs(struct snd_dbri *dbri)
>  {
>  	struct dbri_streaminfo *info;
> -	u32 dvma_addr = (u32)dbri->dma_dvma;
> +	u32 dvma_addr;
>  	s32 *cmd;
>  	unsigned long flags;
>  	int first_td;
> @@ -1710,6 +1710,7 @@ static void xmit_descs(struct snd_dbri *dbri)
>  	if (dbri == NULL)
>  		return;		/* Disabled */
>
> +	dvma_addr = (u32)dbri->dma_dvma;
>  	info = &dbri->stream_info[DBRI_REC];
>  	spin_lock_irqsave(&dbri->lock, flags);
Thanks for catching this.

-Tushar

>
