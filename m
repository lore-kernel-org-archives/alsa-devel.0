From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [PATCH] ALSA: xen-front: remove unneeded switch
	fall-through
Date: Tue, 19 Feb 2019 06:56:04 +0000
Message-ID: <09d316ae-1545-af2d-29eb-ec77c89beb9e@epam.com>
References: <1550552248-17492-1-git-send-email-lirongqing@baidu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50088.outbound.protection.outlook.com [40.107.5.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F59F265530
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 07:56:05 +0100 (CET)
In-Reply-To: <1550552248-17492-1-git-send-email-lirongqing@baidu.com>
Content-Language: en-US
Content-ID: <56BD7F0708843049912CB39EDAD9D880@eurprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Li RongQing <lirongqing@baidu.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-Id: alsa-devel@alsa-project.org

On 2/19/19 6:57 AM, Li RongQing wrote:
> This case block will be terminated by a break, so not need
> a switch fall-through
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   sound/xen/xen_snd_front.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
> index a9e5c2cd7698..f12fb8eeaa27 100644
> --- a/sound/xen/xen_snd_front.c
> +++ b/sound/xen/xen_snd_front.c
> @@ -250,7 +250,6 @@ static void sndback_changed(struct xenbus_device *xb_dev,
>   	case XenbusStateReconfigured:
>   		/* fall through */
>   	case XenbusStateInitialised:
> -		/* fall through */
>   		break;
>   
>   	case XenbusStateInitialising:
Thank you,
Oleksandr
