From: Harry Bloomberg <hbloomb@gmail.com>
Subject: Possible bug report
Date: Thu, 1 Aug 2019 17:39:38 -0400
Message-ID: <CANLVwvSzpUBeLvAysmoV6LG3QCHUm0mee=BYc9UbfWOazPQ_ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41A1CF800C0
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2019 23:39:51 +0200 (CEST)
Received: by mail-oi1-x229.google.com with SMTP id 65so55155154oid.13
 for <alsa-devel@alsa-project.org>; Thu, 01 Aug 2019 14:39:51 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

While running an amateur radio application on a Raspberry Pi 3B+ with the
stretch version of Raspberrian, I see the following in my syslog:

Aug  1 17:31:06 raspberrypi pulseaudio[853]: [alsa-sink-USB Audio]
alsa-sink.c: ALSA woke us up to write new data to the device, but there was
actually nothing to write.
Aug  1 17:31:06 raspberrypi pulseaudio[853]: [alsa-sink-USB Audio]
alsa-sink.c: Most likely this is a bug in the ALSA driver 'snd_usb_audio'.
Please report this issue to the ALSA developers.
Aug  1 17:31:06 raspberrypi pulseaudio[853]: [alsa-sink-USB Audio]
alsa-sink.c: We were woken up with POLLOUT set -- however a subsequent
snd_pcm_avail() returned 0 or another value < min_avail.

So...I am reporting this to the developers as instructed by the error
message.  What additional information do you need?

I'm not exactly sure what I was doing to trigger this error.   I may have
been exiting  the application.

Thanks,
Harry Bloomberg
