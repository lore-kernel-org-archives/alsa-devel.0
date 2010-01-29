From: javier Martin <javier.martin@vista-silicon.com>
Subject: AT91 AC97 Support broken in menuconfig.
Date: Fri, 29 Jan 2010 15:28:17 +0100
Message-ID: <eedb5541001290628k57edd1e9n7f75ddfef9c24c8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id A0253103927
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 15:28:18 +0100 (CET)
Received: by fxm4 with SMTP id 4so3166203fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 06:28:18 -0800 (PST)
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

Hello,
I was trying to get AC97 support for an AT91SAM9G45 in kernel 2.6.32 and I
have noticed that it requires that AVR32 is selected, however the following
commit states that driver for AVR32 was adapted for AT91 too:

commit d9fbd9a2cd5ac1b286a7d7cdb1a180ce1edaee2f
Merge: f25f60b... baea7b9...
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Sep 24 17:06:51 2009 -0700

    Merge branch 'for-linus' of master.kernel.org:/home/rmk/linux-2.6-arm

    * 'for-linus' of master.kernel.org:/home/rmk/linux-2.6-arm: (103
commits)
      ....
      ARM: 5710/1: at91: add AC97 support to at91sam9rl and at91sam9rlek
board
      ARM: 5709/1: at91: add AC97 support to at91sam9g45 series and
at91sam9m10g45ek board
      ARM: 5621/1: at91/dmaengine: integration of at_hdmac driver in
at91sam9g45 series
      ARM: 5620/1: at91/dmaengine: integration of at_hdmac driver in
at91sam9rl
      ...

I just wanted to know if this is just an error in Kconfig tree or the driver
under "sound/atmel/" does not support at91sam9g54.

Thanks.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
