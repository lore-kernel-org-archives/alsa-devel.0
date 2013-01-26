From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
	capture
Date: Sat, 26 Jan 2013 23:37:03 +0100
Message-ID: <CAF+J8Lcorc93p3Yk=u8ciKe39OxadKZ8rNN7BUp=8gYt4u=E4Q@mail.gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f67.google.com (mail-oa0-f67.google.com
 [209.85.219.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 8239C264F0A
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 23:37:05 +0100 (CET)
Received: by mail-oa0-f67.google.com with SMTP id n12so442923oag.10
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 14:37:04 -0800 (PST)
In-Reply-To: <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In revo.c I found this:

/* AK4114 support on Audiophile 192 */
/* CDTO (pin 32) -- GPIO2 pin 52
 * CDTI (pin 33) -- GPIO3 pin 53 (shared with AK4358)
 * CCLK (pin 34) -- GPIO1 pin 51 (shared with AK4358)
 * CSN  (pin 35) -- GPIO7 pin 59
 */
#define AK4114_ADDR 0x02

I verified these mappings and can confirm that they're correct.

I found one more connection:

INT0 (pin36) -- GPIO6 pin 58

So the complete (?) list with complete pin names on the AK4114 would be:

ICE1724 -> AK4114

GPIO1 -> OCKS1/CCLK/SCL
GPIO2 -> CM0/CDTO/CAD1
GPIO3 -> CM1/CDTI/SDA
GPIO6 -> INT0
GPIO7 -> OCKS0/CSN/CAD0

I can not rule out that there are more connections! If you think there
should be more connections I'll do some more tracing.
It is a bit tedious <http://www.dict.cc/englisch-deutsch/tedious.html> because
not all connections can be traced visually. I did that with a multimeter.

If anybody needs datasheets for the VT1724 or AK4114, I have them available.

What would be next? Right now I have no idea how to verify that in the
existing code.

- Jonas


2013/1/26 Pavel Hofman <pavel.hofman@ivitera.com>

>
> http://www.nix.ru/autocatalog/m_audio_midiman_sound/34397_2245_draft.jpg
> reveals it is AK4114, just like in ESI Juli. Its default serial data
> protocol  is not 24bit I2S, the format expected by ICE1724.
>
> It should be feasible to trace the GPIOs from ICE1724 to AK4114 and add
> the config code.
>
> Regards,
>
> Pavel.
>
>
