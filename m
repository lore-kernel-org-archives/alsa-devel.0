From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [PATCH] ALSA: xen-front: fix a loop timeout
Date: Thu, 31 May 2018 09:44:39 +0300
Message-ID: <ff39a5c2-545a-3017-71c4-d8dca73e8129@epam.com>
References: <20180531062507.ajgs4splaboukp2v@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0079.outbound.protection.outlook.com [104.47.1.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D342678A7
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 08:44:46 +0200 (CEST)
In-Reply-To: <20180531062507.ajgs4splaboukp2v@kili.mountain>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 05/31/2018 09:25 AM, Dan Carpenter wrote:
> We want the loop to exit when "to" is set to zero, but in the current
> code it's set to -1.  Also I tweaked the indenting so it doesn't look
> like we're passing "--to" to xenbus_read_unsigned().
>
> Fixes: cc3196ae197c ("ALSA: xen-front: Introduce Xen para-virtualized sound frontend driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
> index c18973a9bc9b..b089b13b5160 100644
> --- a/sound/xen/xen_snd_front.c
> +++ b/sound/xen/xen_snd_front.c
> @@ -334,7 +334,7 @@ static int xen_drv_remove(struct xenbus_device *dev)
>   	 */
>   	while ((xenbus_read_unsigned(front_info->xb_dev->otherend, "state",
>   				     XenbusStateUnknown) != XenbusStateInitWait) &&
> -				     to--)
> +	       --to)
>   		msleep(10);
>   
>   	if (!to) {
Thank you for your patch,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
