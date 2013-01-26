From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
	capture
Date: Sat, 26 Jan 2013 22:29:27 +0100
Message-ID: <CAF+J8Lc76JEJMg++3EJ=3Zq_vEvEwwko=Aov57y5yV4t5zYjvQ@mail.gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f43.google.com (mail-oa0-f43.google.com
 [209.85.219.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2B62625FE
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 22:29:30 +0100 (CET)
Received: by mail-oa0-f43.google.com with SMTP id k7so40819oag.2
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 13:29:27 -0800 (PST)
In-Reply-To: <51042EE5.5070900@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I think I found it. I followed the spdif in and it leads to U19 which is an
AKM AK4114VQ ("High Feature 192kHz 24bit Digital Audio Interface
Transceiver"). It's the topmost of the very right of the card (below the
"M-AUDIO" lettering).

There is code for this chip in the driver-source (i2c/other/ak4114.c) and
it's also referenced in the code for the Audiophile 192 (see revo.c and
revo.h).

Or do you think there's another chip involved?

- Jonas


2013/1/26 Jaroslav Kysela <perex@perex.cz>

>
> I believe that there must be a S/PDIF receiver IC somewhere on the board
> and this IC may be wrongly configured. This IC is not handled in the
> current ALSA driver at all. Could you look to your board and check the
> used chips? From pictures on internet, a suspicious IC is in the middle
> of top on this PCI card. The AKM IC's are for analog audio outputs.
>
> The ICE1724 chip has only serial SPDIF input and SPDIF input clock pins.
> The input samples should be copied to the DMA without any modifications
> (no volume control etc.).
>
>                                         Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project; Red Hat, Inc.
>
