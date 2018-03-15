From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel][PATCH v2 1/3] sndif: Introduce
	protocol version
Date: Thu, 15 Mar 2018 16:14:40 -0400
Message-ID: <20180315201440.GM10870@char.us.oracle.com>
References: <1521043365-26813-1-git-send-email-andr2000@gmail.com>
 <1521043365-26813-2-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 644C2267282
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 21:14:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1521043365-26813-2-git-send-email-andr2000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: tiwai@suse.de, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 14, 2018 at 06:02:43PM +0200, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Protocol version was referenced in the protocol description,
> but missed its definition. Fix this by adding a constant
> for current protocol version.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  xen/include/public/io/sndif.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/xen/include/public/io/sndif.h b/xen/include/public/io/sndif.h
> index c5c1978406b3..667e610fda2b 100644
> --- a/xen/include/public/io/sndif.h
> +++ b/xen/include/public/io/sndif.h
> @@ -38,6 +38,13 @@
>  
>  /*
>   ******************************************************************************
> + *                           Protocol version
> + ******************************************************************************
> + */
> +#define XENSND_PROTOCOL_VERSION         1
> +
> +/*
> + ******************************************************************************
>   *                  Feature and Parameter Negotiation
>   ******************************************************************************
>   *
> -- 
> 2.7.4
> 
