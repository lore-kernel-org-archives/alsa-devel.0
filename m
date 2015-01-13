From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH] ALSA: compress_driver.h: include sound/core.h explicitly
Date: Tue, 13 Jan 2015 11:42:07 +0000
Message-ID: <54B5048F.2070709@imgtec.com>
References: <1418989110-10011-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418989110-10011-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ping

On 12/19/2014 11:38 AM, Qais Yousef wrote:
> Fixes the following compilation error:
>
>     include/sound/compress_driver.h: In function =E2=80=98snd_compr_d=
rain_notify=E2=80=99:
>     include/sound/compress_driver.h:177:2: error: implicit declaratio=
n of function =E2=80=98snd_BUG_ON=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
>       if (snd_BUG_ON(!stream))
>
> snd_BUG_ON() is defined in sound/core.h but the file is not included =
explicitly,
> so include it.
>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: linux-kernel@vger.kernel.org
>
> ---
>   include/sound/compress_driver.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/sound/compress_driver.h b/include/sound/compress=
_driver.h
> index 396e8f73670a..1e2531058b7e 100644
> --- a/include/sound/compress_driver.h
> +++ b/include/sound/compress_driver.h
> @@ -27,6 +27,7 @@
>  =20
>   #include <linux/types.h>
>   #include <linux/sched.h>
> +#include <sound/core.h>
>   #include <sound/compress_offload.h>
>   #include <sound/asound.h>
>   #include <sound/pcm.h>
