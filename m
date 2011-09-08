From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [RFC] [PATCH 02/62] mpu401:snd_mpu401_uart_new(): split
 semantic of irq_flags
Date: Thu, 8 Sep 2011 22:45:20 +0800
Message-ID: <20110908144519.GB3069@zhy>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
 <1315383059-3673-3-git-send-email-yong.zhang0@gmail.com>
 <4E689E9A.8000407@ladisch.de>
 <20110908133700.GB2310@zhy>
 <4E68CA15.8000504@ladisch.de>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E68CA15.8000504@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jiri Kosina <jkosina@suse.cz>, Andreas Mohr <andi@lisas.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Julia Lawall <julia@diku.dk>, Ondrej Zary <linux@rainbow-software.org>, Dan Carpenter <error27@gmail.com>, Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 08, 2011 at 03:58:45PM +0200, Clemens Ladisch wrote:
> 
> The MPU-401 in UART mode is a very simple and stupid MIDI interface,
> which is used on very many sound cards.  Depending on the actual
> hardware implementation, it gets its own interrupt which may be
> exclusive or sharable, or it is integrated into the interrupt handling
> of the main sound card which means that the sound driver has to call the
> mpu401 interrupt handler explicitly.
> 
> Here, "no interrupt" and "already reserved" actually mean the same thing,
> i.e., that the interrupt handling is the responsibility of some other
> driver.

Thanks. If my understanding is correct, in below combination:

	irq		irq_flags
1)      >=0             >0          /* valid */
2)      >=0             =0          /* invalid, irq should be '-1' */
3)      -1              >0          /* valid, irq_flags just mean real irq_falgs,
                                       but actually there is no irq */
4)      -1              =0          /* valid */

my comment will be true, and we could simplify snd_mpu401_uart_new()
like below:

-	if (irq >= 0 && irq_flags) {
+	if (irq >= 0) {

right?


And then we should audit all the callers of snd_mpu401_uart_new()
to check if they provide the cerrect irq number, but IMOH, that
would more difficult than keeping 'want_irq/irq_reserved'.

Thanks,
Yong
