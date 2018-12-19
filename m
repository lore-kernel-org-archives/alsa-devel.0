From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] ALSA: virtuoso: add de-emphasis control
Date: Wed, 19 Dec 2018 19:00:29 +0100
Message-ID: <bab819ed-38a4-dd8f-5505-663539b80d20@ladisch.de>
References: <6b7d5f70-5e5a-59b4-9daf-315937a49639@ladisch.de>
 <5c16909a.1c69fb81.2150c.9583@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 55B44267B14
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 19:00:54 +0100 (CET)
In-Reply-To: <5c16909a.1c69fb81.2150c.9583@mx.google.com>
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
To: Tom Yan <tom.ty89@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tom.ty89@gmail.com wrote:
> +		(data->pcm1796_regs[0][18 - PCM1796_REG_BASE] &
> +		 PCM1796_DME) != PCM1796_DMF_DISABLED;

DME and DMF are different fields.  Just use !!.

With this fixed:
Acked-by: Clemens Ladisch <clemens@ladisch.de>


Regards,
Clemens
