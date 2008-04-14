From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Releasing IRQs in older kernels
Date: Mon, 14 Apr 2008 23:48:15 +0300
Message-ID: <46e1c7760804141348g11097cfcte0c06c204d7d28cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 976652460C
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 22:48:28 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so484236ana.80
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 13:48:16 -0700 (PDT)
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

I'd like to bring up a problem with using alsa-driver on older
kernels. I already made a bug report regarding snd-powermac:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3883. It's
possible that other drivers suffer from this, too.

If I've understood it right, 1.0.16 should be usable on 2.2 kernels
and newer. Well, it woudn't compile on 2.6.15-26-powerpc (Ubuntu
6.06.1 Dapper) without some patching.

However, the real problem began, when I tried to unload the module. It
seems that something has changed (when?) in the kernel's IRQ
interface, and ALSA tries to make old code compatible with it by
introducing snd_request/free_irq, to be used with older kernels. The
idea is to distuingish between IRQs by the last parameter, usually
chip's address. This leads to trouble when several IRQs come from the
same chip, as is the case with snd-powermac.

My conclusion: the drivers suffering from this should be identified,
and some alternative way of handling IRQs correctly on different
kernel versions should be developed.

Risto
