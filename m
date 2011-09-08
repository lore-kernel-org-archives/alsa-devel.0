From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] [PATCH 02/62] mpu401:snd_mpu401_uart_new():
 split semantic of irq_flags
Date: Thu, 08 Sep 2011 22:27:43 +0200
Message-ID: <4E69253F.3090705@ladisch.de>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-3-git-send-email-yong.zhang0@gmail.com>
	<4E689E9A.8000407@ladisch.de> <20110908133700.GB2310@zhy>
	<4E68CA15.8000504@ladisch.de> <20110908144519.GB3069@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E4DF724D55
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 22:28:11 +0200 (CEST)
In-Reply-To: <20110908144519.GB3069@zhy>
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
> On Thu, Sep 08, 2011 at 03:58:45PM +0200, Clemens Ladisch wrote:
> > ...
> > Here, "no interrupt" and "already reserved" actually mean the same thing,
> > i.e., that the interrupt handling is the responsibility of some other
> > driver.

Sorry, after checking the code, I've realized that my description was
wrong.  irq_flags==0 ("already reserved") means that snd_mpu401_uart_new
should not try to allocate the interrupt, while irq==-1 ("no interrupt")
means that the device never issues mpu401 interrupts, so that the mpu401
code must use a timer to poll the device.

I'll write a patch that changes this function so that irq<0 means
"already reserved", and that "no interrupt" gets another bit in the
info_flags parameter.


Regards,
Clemens
