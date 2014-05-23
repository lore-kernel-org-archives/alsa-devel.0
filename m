From: Daniel Mack <daniel@zonque.org>
Subject: Re: MiniDSP USBStreamer / UAC2 / Alsamixer bogus
Date: Fri, 23 May 2014 12:10:15 +0200
Message-ID: <537F1E87.2010707@zonque.org>
References: <trinity-69d5b18f-8b7a-4d6a-97e4-025a61f952fe-1400780207708@3capp-gmx-bs24>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id B099B261ACB
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 12:10:17 +0200 (CEST)
In-Reply-To: <trinity-69d5b18f-8b7a-4d6a-97e4-025a61f952fe-1400780207708@3capp-gmx-bs24>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Baumgart <raga.raga@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jan,

On 05/22/2014 07:36 PM, Jan Baumgart wrote:
>    Today I received a MiniDSP USBStreamer Box.
>    (http://www.minidsp.com/products/usb-audio-interface/usbstreamer-box)
>    It's an USB to ADAT optical interface and claims to be UAC2 compliant.
>    It's based on a XMOS L2 core.
> 
>    Audio worked out of the box!
>    8-Channels In & Out :)

Nice!

>    But the alsamixer controls seem to be bogus.
>    Here's a screenshot of qasmixer:
>    icem.folkwang-uni.de/~jb/geheim/usbstreamer_qasmixer.png
> 
>    All controls are named "USBStreamer Clock Selector"...

That's strange indeed.

>    The first control always snaps back to zero.

This is likely a separate problem.

>    The following 8 Multi-Controls don't have any effect.
>    Only the last two Input/Ouput Master controls work as expected.

Could you read through Documentation/usb/usbmon.txt and follow the
instructions there? Then capture the packets that are transmitted when
you try to set the ALSA controls with amixer. I'd like to know whether
the right units are addressed at all. Make sure to denote in the trace
which amixer control you set, and which traffic resulted from that.

Also, a snapping back control means that the driver got an interrupt
from the device. The corresponding packet should also be visible in the
dump.

>    On OS X 10.8.5 without installing any driver I see 8 Input/Output
>    Volume Sliders + Master Sliders and a working Clock Selector.

Ok, so that means it's definitely a bug on our side.

>    I'm running debian testing with a 3.13-1-amd64 stock kernel.

You can already build a kernel from today's sound master git, as this is
the base for new patches:

  https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/

>    Any ideas? I've attached lsusb and amixer infos below...

Excellent - thanks a bunch for such detailed information!

I'll hope to find some time soon to comprehend what's going on.


Thanks,
Daniel
