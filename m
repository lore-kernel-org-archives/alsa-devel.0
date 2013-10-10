From: John Spencer <maillist-alsa@barfooze.de>
Subject: Re: [PATCH] pcm.h: include sys/types.h,
 necessary for u_int_XX types
Date: Thu, 10 Oct 2013 15:25:17 +0200
Message-ID: <5256AABD.2040204@barfooze.de>
References: <1381411060-15484-1-git-send-email-maillist-alsa@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 73A602610C5
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 15:29:03 +0200 (CEST)
Received: from xdsl-188-155-204-150.adslplus.ch ([188.155.204.150]
 helo=[10.1.1.4])
 by furnace.wzff.de with esmtpsa (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
 (Exim 4.80.1 (FreeBSD)) (envelope-from <maillist-alsa@barfooze.de>)
 id 1VUGIY-00029P-Qk
 for alsa-devel@alsa-project.org; Thu, 10 Oct 2013 15:29:03 +0200
In-Reply-To: <1381411060-15484-1-git-send-email-maillist-alsa@barfooze.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

oops, forgot Signed-off-by, resending...

On 10/10/2013 03:17 PM, John Spencer wrote:
> fixes compilation on musl libc.
> ---
>   include/pcm.h |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/include/pcm.h b/include/pcm.h
> index 95b8aed..7ea9e84 100644
> --- a/include/pcm.h
> +++ b/include/pcm.h
> @@ -29,6 +29,8 @@
>   #ifndef __ALSA_PCM_H
>   #define __ALSA_PCM_H
>
> +#include<sys/types.h>
> +
>   #ifdef __cplusplus
>   extern "C" {
>   #endif
