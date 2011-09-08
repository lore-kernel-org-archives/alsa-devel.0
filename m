From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] [PATCH 02/62] mpu401:snd_mpu401_uart_new():
 split semantic of irq_flags
Date: Thu, 08 Sep 2011 12:53:14 +0200
Message-ID: <4E689E9A.8000407@ladisch.de>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-3-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id D366824A03
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 12:52:50 +0200 (CEST)
In-Reply-To: <1315383059-3673-3-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>, Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Julia Lawall <julia@diku.dk>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Joe Perches <joe@perches.com>, tglx@linutronix.de, mingo@elte.hu
List-Id: alsa-devel@alsa-project.org

Yong Zhang wrote:
> Now snd_mpu401_uart_new() parameter 'irq_flags' take two role
> in it: one is the condition to request_irq and the other is
> the real irq_flags which will be transfered to request_irq().
> 
> So add another parameter 'want_irq' to take the role of the
> first one, this will make it easy to remove IRQF_DISABLED.

Please note that the irq number is also intended to pass this
information:

>   * @irq: the irq number, -1 if no interrupt for mpu
> ...
> -	if (irq >= 0 && irq_flags) {
>  		if (request_irq(irq, snd_mpu401_uart_interrupt, irq_flags,

Of course, most of snd_mpu401_uart_new()'s users get this wrong and use
0 instead of -1, relying on the irq_flags parameter only.  But if these
are fixed to use irq == -1, we get the same effect without having to
introduce another parameter.


Regards,
Clemens
