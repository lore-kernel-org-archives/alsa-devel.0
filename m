From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: riptide: Use DIV_ROUND_UP
Date: Thu, 30 Jun 2016 11:14:36 +0900
Message-ID: <5774808C.60206@sakamocchi.jp>
References: <20160629145628.GA13915@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160629145628.GA13915@amitoj-Inspiron-3542>
Sender: linux-kernel-owner@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

On Jun 29 2016 23:56, Amitoj Kaur Chawla wrote:
> The kernel.h macro DIV_ROUND_UP performs the computation
> (((n) + (d) - 1) /(d)) but is perhaps more readable.
>
> The Coccinelle script used to make this change is as follows:
> @haskernel@
> @@
>
> #include <linux/kernel.h>
>
> @depends on haskernel@
> expression n,d;
> @@
>
> (
> - (n + d - 1) / d
> + DIV_ROUND_UP(n,d)
> |
> - (n + (d - 1)) / d
> + DIV_ROUND_UP(n,d)
> )
>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>   sound/pci/riptide/riptide.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
> index 94639d6..067a912 100644
> --- a/sound/pci/riptide/riptide.c
> +++ b/sound/pci/riptide/riptide.c
> @@ -1496,7 +1496,7 @@ static int snd_riptide_prepare(struct snd_pcm_substream *substream)
>   		f = PAGE_SIZE;
>   		while ((size + (f >> 1) - 1) <= (f << 7) && (f << 1) > period)
>   			f = f >> 1;
> -		pages = (size + f - 1) / f;
> +		pages = DIV_ROUND_UP(size, f);
>   		data->size = size;
>   		data->pages = pages;
>   		snd_printdd
>

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
