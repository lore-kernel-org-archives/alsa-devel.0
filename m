From: Azizul Hakim <azizulfahim2002@gmail.com>
Subject: Re: Audio Driver Works In Ubuntu but Crash in Debian
 After 2nd Run
Date: Tue, 16 Jun 2015 15:30:22 -0400
Message-ID: <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
 <557FD536.3020906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 333A726593A
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 21:30:24 +0200 (CEST)
Received: by oial131 with SMTP id l131so18863198oia.3
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 12:30:23 -0700 (PDT)
In-Reply-To: <557FD536.3020906@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So I've three possible scenario:

Driver didn't start the DMA: Not sure how to track on this point. Any
suggestion?

Interrupt do not arrive correctly: Is this the hardware issue or ALSA
issue?

.pointer callback is buggy: It makes some sense to me but I'm confused
about it though. Will check on this point.

Thanks
Azizul Hakim wrote:
> kernel: ALSA sound/core/pcm_lib.c:1910 playback write error (DMA or IRQ
trouble?)

This message means that the playback position did not advance.

This typically indicates that your driver did not actually start the
DMA, or that interrupts do not arrive correctly, or that your .pointer
callback is buggy.


Regards,
Clemens
