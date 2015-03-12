From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: control: Add sanity checks for user
 ctl id name string
Date: Thu, 12 Mar 2015 09:08:31 +0900
Message-ID: <5500D8FF.9000505@sakamocchi.jp>
References: <1426094114-32111-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A4B26547A
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 01:08:37 +0100 (CET)
In-Reply-To: <1426094114-32111-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Iwai-san,

I have some questions for this patch.

On Mar 12 2015 02:15, Takashi Iwai wrote:
> There was no check about the id string of user control elements, so we
> accepted even a control element with an empty string, which is
> obviously bogus.  This patch adds more sanity checks of id strings.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/control.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 35324a8e83c8..7ed2b214b16d 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1170,6 +1170,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>  
>  	if (info->count < 1)
>  		return -EINVAL;
> +	if (*info->id.name)
> +		return -EINVAL;

This evaluates the first byte of 'struct snd_ctl_elem_id.name[44]' and
return -EINVAL if the byte is non-zero. This means that userspace
application cannot set arbitrary strings into this member because the
first byte should be zero.

> +	if (strnlen(info->id.name, sizeof(info->id.name)) > sizeof(info->id.name))
> +		return -EINVAL;
>  	access = info->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
>  		(info->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
>  				 SNDRV_CTL_ELEM_ACCESS_INACTIVE|
> 

The strnlen() return the length excluding terminator (\0). Even if all
of the 44 bytes are filled without terminator, this conditional
statement doesn't return -EINVAL. But I think this is the case that we
should prevent in this patch.

Therefore, 'if (strnlen(info->id.name, sizeof(info->id.name)) >=
sizeof(info->id.name))' fully satisfies the aim of this patch.


Regards

Takashi Sakamoto
