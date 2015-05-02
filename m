From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Front speakers doesn't work in multichannel output,
 regression in ALC888
Date: Sat, 2 May 2015 17:36:17 +0800
Message-ID: <CAN8cciYUrzEKFNmKUJyyzJtTMZv0XBG71FyUKKAAjC1uZ3ca4Q@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A46F3264FF0
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2015 11:36:18 +0200 (CEST)
Received: by oica37 with SMTP id a37so84210784oic.0
 for <alsa-devel@alsa-project.org>; Sat, 02 May 2015 02:36:17 -0700 (PDT)
In-Reply-To: <2927807.UsnFnTlWVL@luklap.workgroup>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> My problem is that when I set channel output to "Analog output surround
> 5.1"
> (or 2.1 or 4.1), I hear no sound in front speakers, but in case of 5.1 or
> 4.1
> I can hear sound in rear speakers. I use kernel 3.19.5 and it didn't
> happen in
> earlier kernels that is 3.18 and in 3.17 for sure.
>
> My configuration is:
> OS: Fedora 21 64 bit
> SoundCard: ALC888
> Model name: acer-aspire-4930g
> Laptop: Acer Aspire 5930g
> Speakers: external 5.1 with 3 jacks
> Sound channel configuration module is standard configuration module from
> KDE.
>
> Additional info:
> 1) When channel output is 5.1 and I unplug green jack and leave two others
> jacks connected then I can hear sound in laptop internal speakers.
> 2) Earlier (kernel 3.18 and 3.17) I didn't have possibility to choose 2.1
> configuration and additionally to 4.1 configuration I could also choose 4.0
> configuration.
>
> You need to switch "Channel mode" to "6 ch" if you need to use external
5.1 speakers since you have 5.1 internal speakers

this change pin-ctl of headphone jack, mic jack and line in to OUT

post the output of alsa-info.sh
