From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] [PATCH 02/62] mpu401:snd_mpu401_uart_new():
 split semantic of irq_flags
Date: Tue, 13 Sep 2011 10:17:24 +0200
Message-ID: <4E6F1194.80106@ladisch.de>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>	<1315383059-3673-3-git-send-email-yong.zhang0@gmail.com>	<4E689E9A.8000407@ladisch.de>	<20110908133700.GB2310@zhy>	<4E68CA15.8000504@ladisch.de>	<20110908144519.GB3069@zhy>	<4E69253F.3090705@ladisch.de>	<20110909013143.GB18249@zhy>	<4E6CCF6C.2020301@ladisch.de>	<s5hvcsy6nr2.wl%tiwai@suse.de>	<4E6E061E.2010000@ladisch.de>	<4E6E6A34.8060104@ladisch.de>
	<s5hvcswvrty.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id D137424526
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 10:17:05 +0200 (CEST)
In-Reply-To: <s5hvcswvrty.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Yong Zhang <yong.zhang0@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > ALSA: mpu401: clean up interrupt specification
> > 
> > The semantics of snd_mpu401_uart_new()'s interrupt parameters are
> > somewhat counterintuitive:  To prevent the function from allocating its
> > own interrupt, either the irq number must be invalid, or the irq_flags
> > parameter must be zero.  At the same time, the irq parameter being
> > invalid specifies that the mpu401 code has to work without an interrupt
> > allocated by the caller.  This implies that, if there is an interrupt
> > and it is allocated by the caller, the irq parameter must be set to
> > a valid-looking number which then isn't actually used.
> > 
> > With the removal of IRQF_DISABLED, zero becomes a valid irq_flags value,
> > which forces us to handle the parameters differently.
> > 
> > This patch introduces a new flag MPU401_INFO_IRQ_HOOK for when the
> > device interrupt is handled by the caller, and makes the allocation of
> > the interrupt to depend only on the irq parameter.
> > 
> > Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> 
> This patch looks better indeed.
> 
> However, if we are going to remove IRQF_DISABLED in near future, and
> all the callers use IRQF_DISABLED when requesting an irq, why not
> remove this argument now?  Then the IRQF_DISABLED-removal patch will
> touch less code.

I wanted to change only the minimum amount of code needed to make the
IRQF_DISABLED-removal patch possible, and wait with further cleanups of
snd_mpu401_uart_new() until after that patch to avoid conflicts.

However, moving the IRQF_DISABLED into snd_mpu401_uart_new() avoids
those conflicts, so it's clearly better.


Regards,
Clemens
