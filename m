From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 08/11] ALSA: vsnd: Add timer for period
 interrupt emulation
Date: Mon, 7 Aug 2017 12:27:01 +0200
Message-ID: <ba0dd78b-8853-5cf9-197f-bed3b9f4bdb8@ladisch.de>
References: <1502091796-14413-1-git-send-email-andr2000@gmail.com>
 <1502091796-14413-9-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 150F12669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 12:27:07 +0200 (CEST)
In-Reply-To: <1502091796-14413-9-git-send-email-andr2000@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
List-Id: alsa-devel@alsa-project.org

Oleksandr Andrushchenko wrote:
> Front sound driver has no real interrupts, so
> playback/capture period passed interrupt needs to be emulated:
> this is done via timer. Add required timer operations,
> this is based on sound/drivers/dummy.c.

A 'real' sound card use the interrupt to synchronize the stream position
between the hardware and the driver.  The hardware triggers an interrupt
immediately after a period has been completely read (for playback) from
the ring buffer by the DMA unit; this tells the driver that it is now
again allowed to write to that part of the buffer.

The dummy driver has no hardware that accesses the buffer, so the period
interrupts are not synchronized to anything.  This is not a suitable
implementation when the samples are actually used.

If you issue interrupts based on the system timer, the position reported
by the .pointer callback and the position where the hardware (backend)
actually accesses the buffer will diverge, which will eventually corrupt
data.

You have to implement period interrupts (and the .pointer callback)
based on when the samples are actually moved from/to the backend.


Regards,
Clemens
