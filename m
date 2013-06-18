From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: firewire: fix error return code in
	scs_probe()
Date: Tue, 18 Jun 2013 16:02:29 +0200
Message-ID: <51C06875.8080208@ladisch.de>
References: <CAPgLHd-HMw40igirFvFHtN3HNy2utXHVAVERxKQ-vwF9ecUaSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 6AFFA265159
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2013 16:02:39 +0200 (CEST)
In-Reply-To: <CAPgLHd-HMw40igirFvFHtN3HNy2utXHVAVERxKQ-vwF9ecUaSw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: yongjun_wei@trendmicro.com.cn, Wei Yongjun <weiyj.lk@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Wei Yongjun wrote:
> Fix to return -ENOMEM in the kmalloc() error handling
> case instead of 0, as done elsewhere in this function.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

>  	scs->buffer = kmalloc(HSS1394_MAX_PACKET_SIZE, GFP_KERNEL);
> -	if (!scs->buffer)
> +	if (!scs->buffer) {
> +		err = -ENOMEM;
>  		goto err_card;
> +	}
