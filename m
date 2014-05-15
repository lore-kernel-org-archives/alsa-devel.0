From: Dan MacDonald <allcoms@gmail.com>
Subject: Re: poor i4600 HDMI output under 1.0.27.2
Date: Thu, 15 May 2014 19:39:03 +0100
Message-ID: <CANOoOjsei=6bV9YLM23UxgmLoQ4fpeOV6Bx+=oOSkQrzuPj5kQ@mail.gmail.com>
References: <CANOoOjuQAttdCW7ozns8kX=+YZdnscf43DzfvDV5jTDrOqRkzA@mail.gmail.com>
 <53747B6A.20407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f42.google.com (mail-oa0-f42.google.com
 [209.85.219.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0865C261A40
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 20:45:04 +0200 (CEST)
Received: by mail-oa0-f42.google.com with SMTP id j17so1777138oag.1
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 11:45:03 -0700 (PDT)
In-Reply-To: <53747B6A.20407@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: alsa-devel@alsa-project.org, David Woodhouse <dwmw2@infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Alexander

I have tried booting with just

intel_iommu=on,igfx_off

and also with

snd_hda_intel.align_buffer_size=1

but neither combination did anything to fix the garbled HDMI sound
under both 3.13.10 (Deb Jessie) and 3.11.0 (Ubuntu 12.04.4). The
analogue audio works fine.



On Thu, May 15, 2014 at 9:31 AM, Alexander E. Patrakov
<patrakov@gmail.com>wrote:

> 15.05.2014 04:20, Dan MacDonald wrote:
>
>> Hi list
>>
>> I have got HDMI audio out to kinda work but the sound quality is awful and
>> not really listenable. Its very choppy and is slightly more high-pitched
>> than it should be. This is when using hdmi:CARD=HDMI,DEV=1 @48khz
>> outputting via ALSA 1.0.27.2 / jackd 0.124.2 under Deb Jessie amd64 with
>> kernel 3.13.10-1. Its a System76 Gazelle Pro laptop FWIW.
>>
>
> This may be another manifestation of https://bugzilla.kernel.org/
> show_bug.cgi?id=60769 which is still not completely fixed but has a
> workaround.
>
> For me, it leads to silence, for others, it leads to underruns and
> screeching sounds. Please test whether appending this kernel command line
> option helps:
>
> intel_iommu=on,igfx_off
>
>
>
>> $ lspci -v:
>>
>> 00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
>> Processor HD Audio Controller (rev 06)
>>          Subsystem: CLEVO/KAPOK Computer Device 0655
>>          Flags: bus master, fast devsel, latency 0, IRQ 49
>>          Memory at f7e14000 (64-bit, non-prefetchable) [size=16K]
>>          Capabilities: <access denied>
>>          Kernel driver in use: snd_hda_intel
>>
>> 00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset High
>> Definition Audio Controller (rev
>> 05)
>>
>>          Subsystem: CLEVO/KAPOK Computer Device
>> 0655
>>
>>          Flags: bus master, fast devsel, latency 0, IRQ
>> 48
>>
>>          Memory at f7e10000 (64-bit, non-prefetchable)
>> [size=16K]
>>
>>          Capabilities: <access
>> denied>
>>
>>          Kernel driver in use: snd_hda_intel
>>
>> $ cat /proc/asound/card0/codec#0
>> Codec: Intel Haswell HDMI
>> Address: 0
>> AFG Function Id: 0x1 (unsol 0)
>> Vendor Id: 0x80862807
>> Subsystem Id: 0x80860101
>> Revision Id: 0x100000
>>
>
> --
> Alexander E. Patrakov
>
