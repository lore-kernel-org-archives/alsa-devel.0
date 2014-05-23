From: Daniel Mack <daniel@zonque.org>
Subject: Re: MiniDSP USBStreamer / UAC2 / Alsamixer bogus
Date: Fri, 23 May 2014 19:18:05 +0200
Message-ID: <537F82CD.6010907@zonque.org>
References: <trinity-69d5b18f-8b7a-4d6a-97e4-025a61f952fe-1400780207708@3capp-gmx-bs24>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BB6B26500B
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 19:18:07 +0200 (CEST)
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

Hi,

On 05/22/2014 07:36 PM, Jan Baumgart wrote:
>          AudioControl Interface Descriptor:
>            bLength                16
>            bDescriptorType        36
>            bDescriptorSubtype      9 (EXTENSION_UNIT)
>          Warning: Descriptor too short

Hmm, lsusb is right here - bLength should be 16+p ...

>            bUnitID                51
>            wExtensionCode          0
>            bNrPins                 1

... where p is this value: 1.

>            baSourceID( 0)          2
>            bNrChannels             8
>            wChannelConfig          0
>            iChannelNames           3
>            bmControls        0x00
>            iExtension             42

Hence, the iExtension value is wrong, ...

>          AudioControl Interface Descriptor:
>            bLength                42

because it actually is bLength of the next descriptor. So there's
definitely a problem in the USB descriptors, I'm just not sure how we
should deal with that.

I'm also not entirely sure if that explains your control name trouble.
If you're interested in debugging this, have a look at the function
sound/usb/mixer.c, function build_audio_procunit(), especially the lower
half where we try to determine a nice name for the new control. You
could start dumping the variable 'nameid' and see what it contains.

Also, this device reports strings to describe the channel names
(iChannelNames), which the driver currently doesn't care about. It might
be worth fetching them and see what they contain. On the other hand,
ALSA doesn't allow us to provide names for individual sub-controls (for
each of the 8 mixer values inside one control).

Are you up for a little trial and error? I doubt that this will fix your
clock selector trouble though, but for that, the usbmon traces should
give a hint.


Best regards,
Daniel
