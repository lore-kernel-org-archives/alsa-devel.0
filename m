From: Tapio Vihuri <tapio.vihuri@nokia.com>
Subject: Re: [PATCH v4 1/3] ECI: input: introduce ECI accessory
 input driver
Date: Thu, 20 Jan 2011 14:17:33 +0200
Message-ID: <1295525853.26257.21.camel@dell>
References: <1295438816-27937-1-git-send-email-tapio.vihuri@nokia.com>
	<1295438816-27937-2-git-send-email-tapio.vihuri@nokia.com>
	<20110119174412.GB29107@core.coreip.homeip.net>
	<1295510248.26257.7.camel@dell>
	<20110120081117.GB2498@core.coreip.homeip.net>
Reply-To: tapio.vihuri@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A8AF103A5B
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 13:17:49 +0100 (CET)
In-Reply-To: <20110120081117.GB2498@core.coreip.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, samu.p.onkalo@nokia.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-20 at 00:11 -0800, ext Dmitry Torokhov wrote:
> > How about KE_VSW case ? Shouldn't it be in the sparse_keymap_setup
> {}
> > also ?
> > 
> 
> Indeed. Does the patch below fix it?
> 

Hi.

Yes it does, thank you.

Patch working (as it obviously should) OK in my environment, so


> Thanks.
> 
> -- 
> Dmitry
> 
> Input: sparse-keymap - fix KEY_VSW handling in sparse_keymap_setup
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> We were forgetting to set up device capabilities for KEY_VSW entries.
> 
> Reported-by: Tapio Vihuri <tapio.vihuri@nokia.com> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Tested-by: Tapio Vihuri <tapio.vihuri@nokia.com> 

> ---
> 
>  drivers/input/sparse-keymap.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/input/sparse-keymap.c
> b/drivers/input/sparse-keymap.c
> index a29a7812..7729e54 100644
> --- a/drivers/input/sparse-keymap.c
> +++ b/drivers/input/sparse-keymap.c
> @@ -201,6 +201,7 @@ int sparse_keymap_setup(struct input_dev *dev,
>                         break;
>  
>                 case KE_SW:
> +               case KE_VSW:
>                         __set_bit(EV_SW, dev->evbit);
>                         __set_bit(entry->sw.code, dev->swbit);
>                         break;
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel 
-- 
Tapsa
050 4876788
