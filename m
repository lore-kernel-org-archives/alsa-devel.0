From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Sat, 16 Oct 2010 15:06:17 +0800
Message-ID: <AANLkTinpq_E2zRC1J9ZT7c_Ut1-aEkSL-_ky960x6Unm@mail.gmail.com>
References: <4CB68FC7.2060601@canonical.com>
	<4CB69FA4.9030702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4AD4624680
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 09:06:21 +0200 (CEST)
Received: by ewy9 with SMTP id 9so961829ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 16 Oct 2010 00:06:19 -0700 (PDT)
In-Reply-To: <4CB69FA4.9030702@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/14 Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

> Hi David,
>
> First of all, thank you for your work on subwoofer issues.


it seem that acer aspire 8943g has 5.1 speakers according to acer web site

with five built-in speakers and one subwoofer supporting low-frequency
effects

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5083

alc670 is a 6 channels codec with [Audio Output] at nodes 0x02, 0x03 and
0x04

http://www.alsa-project.org/db/?f=d1c9aaa11903b6b1e2fd87b6d0466157ffdcb6ad


Seem that your Lenovo are not using ALC670,
>
Nope it doesn't. It is Lenovo Y550P with ALC272, and in my system, the
subwoofer is connected at pin 0x17. I'm not at it at the moment, but I can
send alsa-info.sh later if it is of any interest.

 ALC272 is just a four channels codec ,

If you look at the block diagram (page 5) of alc272 datasheet , the mono-out
(Port H) pin 0x17 has no volume control , and it is connected through 0x0f
to [Audio Output] node 0x02.

This is quite different from STAC9200 which has a volume control for the
mono-out widget

The beep-in and the beep generator can connected to 0x0f through [Audio
Mixer] 0x0b
this mean that the driver cannot assume that master-mono must be connected
to a subwoofer.
