From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 4/6] usb: audio: Fix variable length field
 to be variable.
Date: Wed, 29 Nov 2017 12:33:00 +0100
Message-ID: <68216f6d-9795-c501-9512-152294558340@ladisch.de>
References: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
 <20171129105532.15420-5-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CF7D266B67
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 12:32:35 +0100 (CET)
In-Reply-To: <20171129105532.15420-5-jorge.sanjuan@codethink.co.uk>
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
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jorge Sanjuan wrote:
> Make bmaControls be a pointer insted of a fixed size array so it
> can have a variable length.

>  	/* bmaControls is actually u32,
>  	 * but u8 is needed for the hybrid parser */
> -	__u8 bmaControls[0]; /* variable length */
> +	__u8 bmaControls[]; /* variable length */
>  	/* wFeatureDescrStr omitted */
>  } __attribute__((packed));

This is not a pointer but a flexible array member.
And in theory, it does not change anything:
https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html


Regards,
Clemens
