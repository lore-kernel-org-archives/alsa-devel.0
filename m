From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] include/uapi/sound/firewire.h: use "_UAPI"
 instead of "UAPI"
Date: Thu, 07 Nov 2013 08:54:46 +0100
Message-ID: <527B4746.90009@ladisch.de>
References: <527B0595.5030108@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B58902610A8
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 08:55:21 +0100 (CET)
In-Reply-To: <527B0595.5030108@asianux.com>
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
Cc: Chen Gang <gang.chen@asianux.com>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Chen Gang wrote:
> When installing, "scripts/headers_install.sh" will strip guard macro'
> "_UAPI" to prevent from appearing it to users. And also, all another
> files which need uapi prefix always use "_UAPI", not "UAPI".
>
> So use "_UAPI" instead of "UAPI" on the guard macro, and also give a
> comment for "#endif".
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  include/uapi/sound/firewire.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
> index e86131c..59f5961 100644
> --- a/include/uapi/sound/firewire.h
> +++ b/include/uapi/sound/firewire.h
> @@ -1,5 +1,5 @@
> -#ifndef UAPI_SOUND_FIREWIRE_H_INCLUDED
> -#define UAPI_SOUND_FIREWIRE_H_INCLUDED
> +#ifndef _UAPI_SOUND_FIREWIRE_H_INCLUDED
> +#define _UAPI_SOUND_FIREWIRE_H_INCLUDED
>
>  #include <linux/ioctl.h>
>
> @@ -48,4 +48,4 @@ struct snd_firewire_get_info {
>   * Returns -EBUSY if the driver is already streaming.
>   */
>
> -#endif
> +#endif /* _UAPI_SOUND_FIREWIRE_H_INCLUDED */
