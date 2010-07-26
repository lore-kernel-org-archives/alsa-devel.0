From: loody <miloody@gmail.com>
Subject: Re: simple program for capturing and playing pcm
Date: Mon, 26 Jul 2010 16:29:51 +0800
Message-ID: <AANLkTikyNQDjHa1aVtG87C5chTvzVTPs8-rNO5t+fL+Z@mail.gmail.com>
References: <AANLkTi=ogK_5CD5R-RbWRKt5iy=a29PVmmcg+t9cs7i8@mail.gmail.com>
	<4C4D3BFE.6060100@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CFC5246DB
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 10:29:52 +0200 (CEST)
Received: by gwj22 with SMTP id 22so1419930gwj.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 01:29:51 -0700 (PDT)
In-Reply-To: <4C4D3BFE.6060100@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi:

2010/7/26 Pavel Hofman <pavel.hofman@ivitera.com>:
> loody napsal(a):
>> Dear all:
>> Is there simple program which can help me to play and capture pcm
>> files from usb speaker and mic?
>> appreciate your help,
>> miloody
>
> aplay, arecord
I found them in alsa-utility :)
but when I try to configure them, I get following messages:

checking for form.h... yes
checking for new_panel in -lpanelw... no
configure: error: panelw library not found

but I list the /usr/lib, I see
$ ls /usr/lib/libpanel* -lht
lrwxrwxrwx 1 root root  27 2009-11-11 07:59
/usr/lib/libpanel-applet-2.so.0 -> libpanel-applet-2.so.0.2.60
lrwxrwxrwx 1 root root  16 2009-11-11 07:52 /usr/lib/libpanelw.so.5 ->
libpanelw.so.5.7
lrwxrwxrwx 1 root root  15 2009-11-11 07:52 /usr/lib/libpanel.so.5 ->
libpanel.so.5.7
lrwxrwxrwx 1 root root  13 2009-11-11 00:41 /usr/lib/libpanel.so ->
libpanel.so.5
-rw-r--r-- 1 root root 51K 2009-10-19 22:00 /usr/lib/libpanel-applet-2.so.0.2.60
-rw-r--r-- 1 root root 19K 2009-10-12 21:12 /usr/lib/libpanel.a
-rw-r--r-- 1 root root 14K 2009-10-12 21:12 /usr/lib/libpanel.so.5.7
-rw-r--r-- 1 root root 14K 2009-10-12 21:12 /usr/lib/libpanelw.so.5.7
$

did I miss something?
I try to run the aplay/arecord under console and if I guess correctly,
I don't need panelw lib. if so, how could I disable it?
appreciate your help,
miloody

what is panelw
