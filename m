From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/8] [RFC] new driver for Echo Audio's
 Fireworks based devices
Date: Fri, 07 Jun 2013 21:16:10 +0900
Message-ID: <51B1CF0A.6020402@sakamocchi.jp>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
 <51AC7B6C.7000108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id BDD7F2656EB
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 14:16:14 +0200 (CEST)
In-Reply-To: <51AC7B6C.7000108@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Clemens,

 > 4. clock source handling

I want to discuss about this issue in this mail.

I've never concerned about this synchronization so it took me a bit time 
to understand what you said...

Actually Fireworks supports severarl clock source, "Internal", "SYT 
Match", "Word", "S/PDIF", "ADAT1", "ADAT2". Then there is two options, 
one is for SYT match and another is for the others.

SYT match:
PC is a clock master to transmit SYT in CIP. So receive stream require 
transmit stream in advance.

The others:
Device is a clock master and PC should generate SYT for transmit stream 
from SYT in receive stream.

 > (and, of course, the capture packets must be used to determine
 > when to send packets).

To achieve this, we need to change calculate_syt() or add new function 
to amdtp.c. I think it's enough to generate outgoing SYT from incoming 
SYT with TRANSFER_DELAY (479.17 micro seconds). This is for consumer use.

But I have no idea when playback starts. Do you have any idea?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

(Jun 3 2013 20:18), Clemens Ladisch wrote:
> o-takashi@sakamocchi.jp wrote:
>> Currently this driver module support just PCM/MIDI kernel streaming via ALSA interfaces.
>> So there are some issues about this driver.
>> 1.whether adding each PCM devices for analog and digital interface
>
> ALSA drivers should reflect the actual hardware design as much as
> possible; conversions should be done in user space by alsa-lib.
>
> If analog and digital channels are part of the same AMDTP stream, then
> that is how the PCM device should look like.  (This is also how other
> drivers like ice1712 work.)
>
> There are other functions to describe and label channels.
> (And when I say "there are", I actually mean "there will be,
> eventually".  ;-)
>
>> 2.where the codes for device control like volume, routing and etc are
>
> The idea was to let the kernel driver handle only the actual streaming
> (and everything else necessary for that, such as device enumeration,
> sample rate, and clock source management), and let user space handle
> everything else.
>
> Volume and routing do not affect the streaming part in any way, so the
> kernel driver should not bother to implement them.
>
>
> 4. clock source handling
>
> AMDTP itself was designed for consumer devices, where streaming is in
> only one direction, and where the receiving device always synchronizes
> to the playback device; this is the equivalent of the "SYT Match" clock
> source.
>
> This is how the existing drivers (isight, firewire-speakers) work.
>
> However, for full duplex and other clock sources, streaming becomes
> more complicated.  When in "SYT match" mode, the playback stream should
> be running even when only a capture PCM device is open.  In all other
> modes, the PC must synchronize to the device, so the capture stream must
> be running when _any_ PCM/MIDI stream is open (and, of course, the
> capture packets must be used to determine when to send packets).
>
>
> Regards,
> Clemens
