From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] emu10k1: Fix coccicheck warning
Date: Sun, 10 Mar 2013 17:32:07 +0100
Message-ID: <513CB587.5010304@ladisch.de>
References: <1362919067-17250-1-git-send-email-cvicentiu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
 [80.67.29.28]) by alsa0.perex.cz (Postfix) with ESMTP id 8387426514E
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 17:33:17 +0100 (CET)
In-Reply-To: <1362919067-17250-1-git-send-email-cvicentiu@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vicentiu Ciorbaru <cvicentiu@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, wfp5p@virginia.edu, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Vicentiu Ciorbaru wrote:
> Removed redundant cast of kmalloc return pointer.

> -	    (icode->gpr_map = (u_int32_t __user *)
> -	     kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t),
> -		     GFP_KERNEL)) == NULL ||
> +	    (icode->gpr_map = kcalloc(512 + 256 + 256 + 2 * 1024,
> +				sizeof(u_int32_t), GFP_KERNEL)) == NULL ||

Why would casting to __user be redundant?


Regards,
Clemens
