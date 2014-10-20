From: Kim Taylor <kim.taylor4@live.vu.edu.au>
Subject: Serial MIDI driver for PL011 - as found on BCM2835
	hardware
Date: Tue, 21 Oct 2014 10:30:35 +1100
Message-ID: <1413847835.13334.8.camel@linux-host>
Reply-To: kim.taylor4@research.vu.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0134.outbound.protection.outlook.com [134.170.140.134])
 by alsa0.perex.cz (Postfix) with ESMTP id D48302606B9
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 01:31:38 +0200 (CEST)
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
