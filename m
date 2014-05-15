From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: poor i4600 HDMI output under 1.0.27.2
Date: Thu, 15 May 2014 14:31:38 +0600
Message-ID: <53747B6A.20407@gmail.com>
References: <CANOoOjuQAttdCW7ozns8kX=+YZdnscf43DzfvDV5jTDrOqRkzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
 [209.85.217.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 83DF4261A3B
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 10:27:11 +0200 (CEST)
Received: by mail-lb0-f172.google.com with SMTP id l4so527899lbv.17
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 01:27:11 -0700 (PDT)
In-Reply-To: <CANOoOjuQAttdCW7ozns8kX=+YZdnscf43DzfvDV5jTDrOqRkzA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan MacDonald <allcoms@gmail.com>, alsa-devel@alsa-project.org, David Woodhouse <dwmw2@infradead.org>
List-Id: alsa-devel@alsa-project.org

15.05.2014 04:20, Dan MacDonald wrote:
> Hi list
>
> I have got HDMI audio out to kinda work but the sound quality is awful and
> not really listenable. Its very choppy and is slightly more high-pitched
> than it should be. This is when using hdmi:CARD=HDMI,DEV=1 @48khz
> outputting via ALSA 1.0.27.2 / jackd 0.124.2 under Deb Jessie amd64 with
> kernel 3.13.10-1. Its a System76 Gazelle Pro laptop FWIW.

This may be another manifestation of 
https://bugzilla.kernel.org/show_bug.cgi?id=60769 which is still not 
completely fixed but has a workaround.

For me, it leads to silence, for others, it leads to underruns and 
screeching sounds. Please test whether appending this kernel command 
line option helps:

intel_iommu=on,igfx_off

>
> $ lspci -v:
>
> 00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
> Processor HD Audio Controller (rev 06)
>          Subsystem: CLEVO/KAPOK Computer Device 0655
>          Flags: bus master, fast devsel, latency 0, IRQ 49
>          Memory at f7e14000 (64-bit, non-prefetchable) [size=16K]
>          Capabilities: <access denied>
>          Kernel driver in use: snd_hda_intel
>
> 00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset High
> Definition Audio Controller (rev
> 05)
>
>          Subsystem: CLEVO/KAPOK Computer Device
> 0655
>
>          Flags: bus master, fast devsel, latency 0, IRQ
> 48
>
>          Memory at f7e10000 (64-bit, non-prefetchable)
> [size=16K]
>
>          Capabilities: <access
> denied>
>
>          Kernel driver in use: snd_hda_intel
>
> $ cat /proc/asound/card0/codec#0
> Codec: Intel Haswell HDMI
> Address: 0
> AFG Function Id: 0x1 (unsol 0)
> Vendor Id: 0x80862807
> Subsystem Id: 0x80860101
> Revision Id: 0x100000

-- 
Alexander E. Patrakov
