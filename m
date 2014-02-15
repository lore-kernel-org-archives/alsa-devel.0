From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Roland V-Studio 20
Date: Sat, 15 Feb 2014 00:24:47 +0000
Message-ID: <1428051.5hAzGeGQ4E@kamdesktop>
References: <8010247.EC2u5T8PMU@kamdesktop> <52FE698C.5080501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id DF321260862
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 01:24:49 +0100 (CET)
Received: by mail-wi0-f170.google.com with SMTP id hi5so966637wib.1
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 16:24:49 -0800 (PST)
In-Reply-To: <52FE698C.5080501@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 14 Feb 2014 20:07:56 Clemens Ladisch wrote:
> Keith A. Milner wrote:
> > I've recently picked up a cheap Roland V-Studio 20 device. This is
> > described in the product spec as supporting 24-bit, but it is appearing
> > as 16-bit only.
> How does it appear in /proc/asound/card*/stream0?
> 
> > Unfortunately, Roland seem to insist on their own proprietary descriptors,
> > which I don't know how to decode, so I'm not sure whether this is
> > genuinely a 24-bit interface that isn't being interpreted properly by
> > snd-usb-audio, or whether it's marketing spin, and it's actually 16-bit.
> > 
> > ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
> 
>                                    ^^ ^^
>                                    This is three bytes, 24 bits.
> 
> 

Cakewalk VS-20 at usb-0000:00:1d.1-2, full speed : USB Audio

Playback:
  Status: Stop
  Interface 0
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 44100

Capture:
  Status: Stop
  Interface 1
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 44100


Ahah! thank you!

I was confused because Jack seems to think it is 16 bit only.

Cheers,

Keith
