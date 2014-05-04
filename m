From: Daniel Mack <daniel@zonque.org>
Subject: Re: ALC1150 can't playback SND_PCM_FORMAT_FLOAT
 without dmix
Date: Sun, 04 May 2014 12:32:36 +0200
Message-ID: <53661744.2080209@zonque.org>
References: <CAJ70YRB7F+9XemQFQo1J3MaM_b4GfexvdVE7VG2OYPiVXDXt7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 7221C2607B6
 for <alsa-devel@alsa-project.org>; Sun,  4 May 2014 12:32:38 +0200 (CEST)
In-Reply-To: <CAJ70YRB7F+9XemQFQo1J3MaM_b4GfexvdVE7VG2OYPiVXDXt7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Madura Anushanga <madura.x86@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 05/04/2014 09:27 AM, Madura Anushanga wrote:
> MSI z87-GD65 GAMING motherboard's ALC1150 plays SND_PCM_FORMAT_FLOAT with
> noise[1] other non float formats work well. As soon as I changed
> /etc/asound.conf from
> 
> pcm.!default{
>    type hw
>    card 1
> }

The 'hw' plugin requires the audio hardward to support the configured
format natively, matching the exact sample format, alignment and
endianess, as well as the sample rate and channel number etc.

I don't know of any consumer-class Codec that supports float on the
hardware wire.

> pcm.dmixed {
>         type asym
>         playback.pcm {
>                 type dmix

...

> 1. https://github.com/manushanga/vrok/blob/master/outs/alsa.cpp

In general, you should use the 'plughw' plugin for generic applications,
which does the implicit sample format conversion for you.


Daniel
