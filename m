From: Kim Taylor <kmtaylor@gmx.com>
Subject: Serial MIDI driver for PL011 - as found on BCM2835
	hardware
Date: Tue, 21 Oct 2014 10:40:59 +1100
Message-ID: <1413848459.13334.9.camel@linux-host>
References: <1413847835.13334.8.camel@linux-host>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 2951A2606E9
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 01:41:59 +0200 (CEST)
Received: from [140.159.160.7] ([140.159.160.7]) by mail.gmx.com (mrgmxus001)
 with ESMTPSA (Nemesis) id 0LjZRW-1YHc9F1QTY-00bexW for
 <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 01:41:58 +0200
In-Reply-To: <1413847835.13334.8.camel@linux-host>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've written a driver for raw MIDI using the PL011. It is obviously
based on the snd-serial-u16550 module, with a couple of improvements:

 - I've implemented a drain() callback.

 - I've also implemented a half duplex mode based on a timer callback
which was necessary for reliable communication with my eMagic Unitor 8
hardware. (Testing with a serial link to other hardware shows that the
full duplex mode is also working.)

It can be found here:
https://github.com/kmtaylor/rpi_patches/blob/master/serial-pl011.c

If you think it should be included in the ALSA repository, please let me
know what to do next.

Regards,

Kim
