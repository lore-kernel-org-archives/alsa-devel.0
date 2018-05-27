From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH][next] ALSA: xen-front: remove redundant error check on
 ret
Date: Mon, 28 May 2018 07:42:12 +0900
Message-ID: <ee539e2d-568e-4bfa-a4aa-4a9b39bc1bd8@sakamocchi.jp>
References: <20180527212312.23997-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180527212312.23997-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 28 2018 06:23, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error for a -ve value in ret is redundant as all previous
> assignments to ret have an associated -ve check and hence it
> is impossible for ret to be less that zero at the point of the
> check.  Remove this redundant error check.
> 
> Detected by CoveritScan, CID#1469407 ("Logically Dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/xen/xen_snd_front_evtchnl.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/sound/xen/xen_snd_front_evtchnl.c b/sound/xen/xen_snd_front_evtchnl.c
> index d70a62e7f910..102d6e096cc8 100644
> --- a/sound/xen/xen_snd_front_evtchnl.c
> +++ b/sound/xen/xen_snd_front_evtchnl.c
> @@ -351,8 +351,6 @@ int xen_snd_front_evtchnl_create_all(struct xen_snd_front_info *front_info,
>   			}
>   		}
>   	}
> -	if (ret < 0)
> -		goto fail;
>   
>   	front_info->num_evt_pairs = num_streams;
>   	return 0;

Yep. All branches for error path on the nested for loop have goto 
statement, thus no need to check error outer the loop.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Takashi Sakamoto
