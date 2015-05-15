From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: USB-Audio.conf routing and dmix
Date: Fri, 15 May 2015 16:13:18 +0800
Message-ID: <CAN8cciYjn2r4J0BCFQ8LdJbbH6tDrdcd48Qyzx2ARo=WQGkcKg@mail.gmail.com>
References: <20150509002017.GB18945@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C043926057F
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 10:13:19 +0200 (CEST)
Received: by oift201 with SMTP id t201so76787470oif.3
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 01:13:18 -0700 (PDT)
In-Reply-To: <20150509002017.GB18945@freedom>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sylvain.bertrand@gmail.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> I have a bose USB audio 5.1 device, a generic USB audio device.
>
> I noticed that the proper channels routing was missing from the default
generic
> USB pcm, but dmix was used. And for the surround pcms I noticed it was the
> other way around!
>
> I did modify the default pcm to include a routing plugin. I put 8
channels in
> the routing plugin. I guess the proper way would be to detect the hw card
> number of channels and select a route plugin configuration with the
correct
> count of channels (maybe their is a function to get that info?).
>
> I linked the surround51 and surround71 pcms with the 'disable-able' dmix
> section from the default pcm.
>
> I did not touch the surround40* pcms, surround pcms which are specific to
some
> cards and the iec958 ones.
>
> http://filebin.ca/214UTT8fBnUm/USB-Audio.conf
>
>

Post the output of your usb audio

lsusb -vvvv

Most likely your usb audio device does not support stereo

Post output of alsa-info.sh

Pulseaudio don't support if your volume control have more than two channels

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa?id=527078523815587bfd021bc1d10782403e9b3e84
