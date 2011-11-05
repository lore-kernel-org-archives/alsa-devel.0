From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: control: remove compilation warning
 on 32-bit
Date: Sat, 05 Nov 2011 23:00:09 +0100
Message-ID: <4EB5B1E9.9080401@ladisch.de>
References: <1320460125-20881-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 4F0EF103807
	for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2011 23:00:16 +0100 (CET)
In-Reply-To: <1320460125-20881-1-git-send-email-olof@lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Olof Johansson wrote:
> This was introduced by 'ALSA: control: add support for ENUMERATED user
> space controls' which adds a u64 variable that gets cast to a pointer:
>
> sound/core/control.c: In function 'snd_ctl_elem_init_enum_names':
> sound/core/control.c:1089: warning: cast to pointer from integer of different size
>
> Since we don't support 64-bit userspace on 32-bit kernel, it's safe to
> cast to long before casting to pointer to avoid the warning.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  sound/core/control.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied (with uintptr_t instead of long); thanks!


Clemens


> diff --git a/sound/core/control.c b/sound/core/control.c
> index 978fe1a..d09c335 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1081,12 +1081,12 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
>  	char *names, *p;
>  	size_t buf_len, name_len;
>  	unsigned int i;
> +	const long user_ptrval = ue->info.value.enumerated.names_ptr;
>
>  	if (ue->info.value.enumerated.names_length > 64 * 1024)
>  		return -EINVAL;
>
> -	names = memdup_user(
> -		(const void __user *)ue->info.value.enumerated.names_ptr,
> +	names = memdup_user((const void __user *)user_ptrval,
>  		ue->info.value.enumerated.names_length);
>  	if (IS_ERR(names))
>  		return PTR_ERR(names);
