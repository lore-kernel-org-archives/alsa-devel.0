From: Daniel Mack <zonque@gmail.com>
Subject: Re:
 =?windows-1252?q?alsa_crash_with_=93_ALSA_sound/usb/?=
 =?windows-1252?q?urb=2Ec=3A179_cannot_submit_urb_=28err_=3D_-27=29=94_on_?=
 =?windows-1252?q?imx6q_sabrelite?=
Date: Sun, 08 Sep 2013 16:57:37 +0200
Message-ID: <522C9061.5070303@gmail.com>
References: <CAFT5LgLN2dWg9Pef5AHH9AFPv-1e_WAp=3J+LEdvYTCWjKXAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id B5DD92616C1
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2013 16:57:39 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id f12so4497713wgh.14
 for <alsa-devel@alsa-project.org>; Sun, 08 Sep 2013 07:57:39 -0700 (PDT)
In-Reply-To: <CAFT5LgLN2dWg9Pef5AHH9AFPv-1e_WAp=3J+LEdvYTCWjKXAhg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ankit Agarwal <ankitgenius90@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02.09.2013 12:51, Ankit Agarwal wrote:
> I am using alsa pcm player to listen to audio. The alsa pcm crashes with
> the error: ALSA sound/usb/urb.c:179 cannot submit urb (err = -27). I am
> able to hear the data initially but when other transaction begins on HID
> report endpoint, alsa crashes with the mentioned error.

-27 == -EFBIG, which seems to relate to a scheduling problem on the bus,
and hence probably rather to a host controller bug than an issue with
snd-usb.

> I am working on imx6q board with linux kernel-3.0.35. I am using Apple
> device to get the digital audio.

Please try with a more recent kernel, and see if you can find the
location where EFBIG is initially reported.


Daniel
