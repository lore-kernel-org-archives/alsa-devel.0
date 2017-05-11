From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] sound: Disable the build of OSS drivers
Date: Thu, 11 May 2017 16:50:36 -0700
Message-ID: <b2e30dfe-78a2-2d9f-5b0c-e60188a018bb@infradead.org>
References: <20170511205827.16446-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id EC7A92669D8
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 01:50:46 +0200 (CEST)
In-Reply-To: <20170511205827.16446-1-tiwai@suse.de>
Content-Language: en-US
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
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

On 05/11/17 13:58, Takashi Iwai wrote:
> OSS drivers are left as badly unmaintained, and now we're facing a
> problem to clean up the hackish set_fs() usage in their codes.  Since
> most of drivers have been covered by ALSA, and the others are dead old
> and inactive, let's leave them RIP.
> 
> This patch is the first step: disable the build of OSS drivers.
> We'll eventually drop the whole codes and clean up later.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> 
> v1->v2: Smaller changes, as Linus and Randy suggested.
> 	The first dmasound Kconfig inclusion is still commented out since
> 	it's shorter/simpler in the end.
> 
>  sound/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/Kconfig b/sound/Kconfig
> index ee2e69a9ecd1..de23fc39cec8 100644
> --- a/sound/Kconfig
> +++ b/sound/Kconfig
> @@ -54,7 +54,7 @@ config SOUND_OSS_CORE_PRECLAIM
>  
>  	  If unsure, say Y.
>  
> -source "sound/oss/dmasound/Kconfig"
> +# source "sound/oss/dmasound/Kconfig"
>  
>  if !M68K && !UML
>  
> @@ -115,6 +115,7 @@ endif # SND
>  menuconfig SOUND_PRIME
>  	tristate "Open Sound System (DEPRECATED)"
>  	select SOUND_OSS_CORE
> +	depends on BROKEN
>  	help
>  	  Say 'Y' or 'M' to enable Open Sound System drivers.
>  
> 


-- 
~Randy
