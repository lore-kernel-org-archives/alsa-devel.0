From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH alsa-lib] hwdep: add OXFW driver support
Date: Sun, 26 Oct 2014 22:43:00 +0900
Message-ID: <544CFA64.9050807@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
 <1414330185-14100-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F9B52606A9
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 14:43:05 +0100 (CET)
In-Reply-To: <1414330185-14100-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Oct 26 2014 22:29, Takashi Sakamoto wrote:
> Linux 3.19 newly support this driver. By hardware dependent interface,
> userspace applications can get hardware information, lock/unlock kernel
> streaming and receive lock status event.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/hwdep.h        | 3 ++-
>  include/sound/asound.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

This patch is for alsa-lib. I forgot to address it...

> diff --git a/include/hwdep.h b/include/hwdep.h
> index ad8bb49..3d3c31b 100644
> --- a/include/hwdep.h
> +++ b/include/hwdep.h
> @@ -73,8 +73,9 @@ typedef enum _snd_hwdep_iface {
>  	SND_HWDEP_IFACE_FW_DICE,	/**< TC DICE FireWire device */
>  	SND_HWDEP_IFACE_FW_FIREWORKS,	/**< Echo Audio Fireworks based device */
>  	SND_HWDEP_IFACE_FW_BEBOB,	/**< BridgeCo BeBoB based device */
> +	SND_HWDEP_IFACE_FW_OXFW,	/**< Oxford OXFW970/971 based device */
>  
> -	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_BEBOB  /**< last known hwdep interface */
> +	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_FW_OXFW	/**< last known hwdep interface */
>  } snd_hwdep_iface_t;
>  
>  /** open for reading */
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index 6ee5867..c30a4d4 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -96,9 +96,10 @@ enum {
>  	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
>  	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
>  	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
> +	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
>  
>  	/* Don't forget to change the following: */
> -	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_BEBOB
> +	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_OXFW
>  };
>  
>  struct snd_hwdep_info {
> 
