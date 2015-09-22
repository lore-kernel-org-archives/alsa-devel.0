From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] sound: oss: ad1848: Fix returned errno
 code in ad1848_init()
Date: Tue, 22 Sep 2015 22:16:42 +0530
Message-ID: <20150922164642.GA14353@sudip-pc>
References: <1442936257-8988-1-git-send-email-luisbg@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E336264ED4
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 18:46:53 +0200 (CEST)
Received: by pacex6 with SMTP id ex6so13930560pac.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 09:46:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442936257-8988-1-git-send-email-luisbg@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 22, 2015 at 04:37:37PM +0100, Luis de Bethencourt wrote:
> The driver is using -1 instead of the -ENOMEM defined macro to specify
> that a buffer allocation failed. Since the error number is propagated,
> the caller will get a -EPERM which is the wrong error condition.
> 
> Smatch tool warning:
> ad1848_init() warn: returning -1 instead of -ENOMEM is sloppy
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
>  sound/oss/ad1848.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
> index 10c8de1..6b35656 100644
> --- a/sound/oss/ad1848.c
> +++ b/sound/oss/ad1848.c
> @@ -1992,7 +1992,7 @@ int ad1848_init (char *name, struct resource *ports, int irq, int dma_playback,
>  	portc = kmalloc(sizeof(ad1848_port_info), GFP_KERNEL);
>  	if(portc==NULL) {
>  		release_region(devc->base, 4);
> -		return -1;
> +		return -ENOMEM;
 The return value of ad1848_init is stored in hw_config->slots[0].
And in sound/oss/pss.c hw_config->slots[0] is checked like: 
if (hw_config->slots[0] != -1)

So, you just changed the functionality of the driver.

regards
sudip
