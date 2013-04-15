From: =?ISO-8859-1?Q?Daniel_Sch=FCrmann?= <daschuer@mixxx.org>
Subject: Solved Hercules RMX2
Date: Tue, 16 Apr 2013 00:04:59 +0200
Message-ID: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E316265264
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 00:05:00 +0200 (CEST)
Received: by mail-ie0-f172.google.com with SMTP id c10so6544363ieb.31
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 15:04:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hallo Alsa Developers,

I have fixed Support for Hercules RMX2.

You can find the Bug and the patch here:
https://bugs.launchpad.net/mixxx/+bug/1096687

The issue was caused by the first time setting the rate.
I have changed the usb_msg_timeout to 1500 ms to make it work.
The measures time is a ~1240 ms.
All following rate settings are finished in not time < 4 ms

Sound is now working fine but there are still IO errors just after
connecting the device

errno 5 - input/output error

Here the extended Log:
Apr 14 23:50:37 KellerPc kernel: [19213.746929] snd_usb_autoresume() -19
ID:6f8b113 chip->shutdown 0 chip->probing 1.
Apr 14 23:50:37 KellerPc kernel: [19213.746934] -5 1 cannot get ctl value:
req =3D 0x83, wValue =3D 0x201, wIndex =3D 0x0, type =3D 4
Apr 14 23:50:37 KellerPc kernel: [19213.747053] snd_usb_autoresume() -19
ID:6f8b113 chip->shutdown 0 chip->probing 1.
Apr 14 23:50:37 KellerPc kernel: [19213.747058] -5 1 cannot get ctl value:
req =3D 0x83, wValue =3D 0x200, wIndex =3D 0x0, type =3D 4
Apr 14 23:50:37 KellerPc kernel: [19213.747430] snd_usb_autoresume() -19
ID:6f8b113 chip->shutdown 0 chip->probing 1.
Apr 14 23:50:37 KellerPc kernel: [19213.747435] -5 1 cannot get ctl value:
req =3D 0x83, wValue =3D 0x201, wIndex =3D 0x0, type =3D 4
Apr 14 23:50:37 KellerPc kernel: [19213.747554] snd_usb_autoresume() -19
ID:6f8b113 chip->shutdown 0 chip->probing 1.
Apr 14 23:50:37 KellerPc kernel: [19213.747559] -5 1 cannot get ctl value:
req =3D 0x83, wValue =3D 0x200, wIndex =3D 0x0, type =3D 4
Apr 14 23:50:37 KellerPc kernel: [19213.752599] usbcore: registered new
interface driver snd-usb-audio
Apr 14 23:50:37 KellerPc kernel: [19213.775204] snd_usb_ctl_msg()
dev:ed5eb000 pipe:80000d80 request:02, requesttype:a1, value:0201,
index:0a00, data_size:8.
Apr 14 23:50:37 KellerPc kernel: [19213.776264] snd_usb_ctl_msg()
dev:ed5eb000 pipe:80000d80 request:02, requesttype:a1, value:0201,
index:0a00, data_size:8.
Apr 14 23:50:37 KellerPc kernel: [19213.776436] snd_usb_ctl_msg()
dev:ed5eb000 pipe:80000d80 request:02, requesttype:a1, value:0201,
index:0a00, data_size:8.

The current solution is fine for me, but maybe there is an other place for
tweaking the startup timing. Any ideas?

Is it possible to include the fix in trunk?

Thank you.

Kind regards,

Daniel Sch=FCrmann
