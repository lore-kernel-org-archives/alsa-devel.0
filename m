From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] [PATCH 02/62] mpu401:snd_mpu401_uart_new():
 split semantic of irq_flags
Date: Thu, 08 Sep 2011 15:58:45 +0200
Message-ID: <4E68CA15.8000504@ladisch.de>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-3-git-send-email-yong.zhang0@gmail.com>
	<4E689E9A.8000407@ladisch.de> <20110908133700.GB2310@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id CE79E24B2E
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 15:58:24 +0200 (CEST)
In-Reply-To: <20110908133700.GB2310@zhy>
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
> On Thu, Sep 08, 2011 at 12:53:14PM +0200, Clemens Ladisch wrote:
>> Yong Zhang wrote:
>> > Now snd_mpu401_uart_new() parameter 'irq_flags' take two role
>> > in it: one is the condition to request_irq and the other is
>> > the real irq_flags which will be transfered to request_irq().
>> > 
>> > So add another parameter 'want_irq' to take the role of the
>> > first one, this will make it easy to remove IRQF_DISABLED.
>> 
>> Please note that the irq number is also intended to pass this
>> information:
> 
> Yes.
> 
> this is a bit subtle:
>  * @irq: the irq number, -1 if no interrupt for mpu
>     
> This semantic of 'irq' is kept by the callers IMHO.
> 
>  * @irq_flags: the irq request flags (SA_XXX), 0 if irq was already reserved.
> 
> So irq_flags has other meaning--if the irq is already reserved.
> Maybe my imprecise description make some kind of misunderstanding.

The wording is just sloppy.

> BTW, I'm not familiar with mpu401, so maybe I'm missing something here.

The MPU-401 in UART mode is a very simple and stupid MIDI interface,
which is used on very many sound cards.  Depending on the actual
hardware implementation, it gets its own interrupt which may be
exclusive or sharable, or it is integrated into the interrupt handling
of the main sound card which means that the sound driver has to call the
mpu401 interrupt handler explicitly.

Here, "no interrupt" and "already reserved" actually mean the same thing,
i.e., that the interrupt handling is the responsibility of some other
driver.


Regards,
Clemens
