From: Daniel Mack <daniel@zonque.org>
Subject: Re: Serial MIDI driver for PL011 - as found on BCM2835
 hardware
Date: Tue, 21 Oct 2014 09:20:16 +0200
Message-ID: <54460930.6060603@zonque.org>
References: <1413847835.13334.8.camel@linux-host>
 <1413848459.13334.9.camel@linux-host>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E9E63260494
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 09:20:18 +0200 (CEST)
In-Reply-To: <1413848459.13334.9.camel@linux-host>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kim Taylor <kmtaylor@gmx.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for sharing this!

On 10/21/2014 01:40 AM, Kim Taylor wrote:
> I've written a driver for raw MIDI using the PL011. It is obviously
> based on the snd-serial-u16550 module, with a couple of improvements:
>
>  - I've implemented a drain() callback.
> 
>  - I've also implemented a half duplex mode based on a timer callback
> which was necessary for reliable communication with my eMagic Unitor 8
> hardware. (Testing with a serial link to other hardware shows that the
> full duplex mode is also working.)

So I guess you could patch the existing driver to make it work for your
use case, right? I haven't looked at the code in detail, but from what
you describe, that should be possible.

> It can be found here:
> https://github.com/kmtaylor/rpi_patches/blob/master/serial-pl011.c
> 
> If you think it should be included in the ALSA repository, please let me
> know what to do next.

Clone this repository:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

and integrate your changes there, then send patches to this mailing
list. Especially if you're doing it for the first time,
Documentation/SubmittingPatches is a good read to omit some typical
pitfalls.


Best regards,
Daniel
