From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Copy ALSA buffer to the buffer allocated in my
	driver.
Date: Fri, 29 Jul 2011 16:58:11 +0200
Message-ID: <4E32CA83.10102@ladisch.de>
References: <4E32C3F4.4050105@globaledgesoft.com>
	<CAB+ez9vcA5NAqLco8up2oVNpRX=dLd1N_du0QuAQ_aBD0XC3Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 13ED11037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 16:54:37 +0200 (CEST)
In-Reply-To: <CAB+ez9vcA5NAqLco8up2oVNpRX=dLd1N_du0QuAQ_aBD0XC3Xg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: `/ET!-i1S!-i <yethish7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

`/ET!-i1S!-i wrote:
> I'm writing a virtual ALSA driver for a playback device, with the help of
> dummy driver available at the linux kernel source code.
> ...
> Is it ok to use the hrtimer interrupts (which is used in dummy driver) or
> mutex / spinlocks for my driver.

What is the actual destination of your virtual device?  (I.e., can it be
used as a timing source?)


Regards,
Clemens
