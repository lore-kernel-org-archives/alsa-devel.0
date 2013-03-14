From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/2] ALSA: info: Avoid leaking kernel memory
Date: Thu, 14 Mar 2013 07:15:28 +0100
Message-ID: <51416B00.2040406@canonical.com>
References: <1363192600-11832-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 92FA4265E73
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 07:15:26 +0100 (CET)
In-Reply-To: <1363192600-11832-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/13/2013 05:36 PM, Takashi Iwai wrote:
> Make sure that the allocated buffer for reading the proc file won't
> expose the uncleared kernel memory.

This should go to stable too, due to the security implications of 
leaking possibly sensitive information to userspace?

>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/info.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/core/info.c b/sound/core/info.c
> index db308db..58e97b3 100644
> --- a/sound/core/info.c
> +++ b/sound/core/info.c
> @@ -89,7 +89,7 @@ static int resize_info_buffer(struct snd_info_buffer *buffer,
>   	char *nbuf;
>
>   	nsize = PAGE_ALIGN(nsize);
> -	nbuf = krealloc(buffer->buffer, nsize, GFP_KERNEL);
> +	nbuf = krealloc(buffer->buffer, nsize, GFP_KERNEL | __GFP_ZERO);
>   	if (! nbuf)
>   		return -ENOMEM;
>
> @@ -353,7 +353,7 @@ static int snd_info_entry_open(struct inode *inode, struct file *file)
>   				goto __nomem;
>   			data->rbuffer = buffer;
>   			buffer->len = PAGE_SIZE;
> -			buffer->buffer = kmalloc(buffer->len, GFP_KERNEL);
> +			buffer->buffer = kzalloc(buffer->len, GFP_KERNEL);
>   			if (buffer->buffer == NULL)
>   				goto __nomem;
>   		}
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
