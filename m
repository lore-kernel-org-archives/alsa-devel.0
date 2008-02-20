From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Regarding pointer callback
Date: Thu, 21 Feb 2008 00:46:30 +0530
Message-ID: <61445c750802201116q7e20083dw6863ac8ee72cf775@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id C60922452E
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 20:16:31 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so4314334wag.8
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 11:16:30 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In Writing an ALSA driver, it is written that
pointer callback is called usually from the buffer-update routine in
the pcm middle layer, which is invoked when snd_pcm_period_elapsed()
is called in the interrupt routine. Then the pcm middle layer updates
the position and calculates the available space, and wakes up the
sleeping poll threads, etc.


I know from a kernel space ALSA driver, the pointer callback is called
after the driver calls snd_pcm_period_elapsed() from the interrupt handler
or after a period is consumed. How pointer function of a user space plugin
is called? I have a user space pcm external plugin which updates the buffer
counter after every period is consumed, but when will it be called? How does
the
ALSA lib know when to call it since there is no snd_pcm_period_elapsed() in
user
space.

-Phraoh.
