From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsa USB Audio regression
Date: Mon, 15 Jul 2013 09:40:02 +0800
Message-ID: <CAN8ccia_6vUYKm2noaQ3nNh=rr6kJq76vtZ1t3==cQ-cPr2-jA@mail.gmail.com>
References: <51E2AA11.8090500@gmx.at>
	<51E2AB84.9070603@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 68117260307
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 03:40:03 +0200 (CEST)
Received: by mail-ie0-f174.google.com with SMTP id 9so24442777iec.19
 for <alsa-devel@alsa-project.org>; Sun, 14 Jul 2013 18:40:02 -0700 (PDT)
In-Reply-To: <51E2AB84.9070603@gmx.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Ulrich_G=C3=BCnther?= <ulrich.guenther@gmx.at>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

>
> After Ubuntu 10.04 LTS (Ubuntu 10.10 works, Ubuntu 11.04 doesn't work at
> all, Ubuntu 11.10 and newer have the bug), the headset only plays sound
> at maximum volume level if the volume is turned down just a little no
> sound is being played.
>
> I have filled a Ubuntu bug for 12.04 LTS at:
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1200925 .
> I was advised to contact this mailing list.
>
> AlsaInfo for Ubuntu 12.04 LTS with the bug:
> http://www.alsa-project.org/db/?f=3bde76b15a15f585418a6a4a4703ca67fd4cdf42.
> AlsaInfo for Ubuntu 10.04 LTS without the bug:
> http://www.alsa-project.org/db/?f=5824e55345c3f7128937405254485a489886b9dc
>



It is strange that dB range of your usb audio is 0 to 0.14 (only small gain
and no attenuation)

In 10.04 LTS pulseaudio provide software volume control


( 1.095| 0.000) I: alsa-sink.c: Driver does not support hardware volume
control, falling back to software volume control.


control.6 {
comment.access 'read write'
comment.type INTEGER
comment.count 1 comment.range '0 - 37'
comment.dbmin 0 comment.dbmax 14
iface MIXER
name 'Speaker Playback Volume' value 30 }


 In 12.04 pulseaudio did not provide software volume attenuation and use
the speaker playback volume control
