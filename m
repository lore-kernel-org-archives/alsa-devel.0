From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Bug report: [alsa-sink-USB Audio] alsa-sink.c: Most
	likely this is a bug in the ALSA driver '(null)'. Please
	report this issue to the ALSA
Date: Sun, 25 May 2014 08:53:15 -0400
Message-ID: <001401cf7818$4be327c0$e3a97740$@lucidpixels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 by alsa0.perex.cz (Postfix) with ESMTP id BBBDD2619F3
 for <alsa-devel@alsa-project.org>; Sun, 25 May 2014 14:53:20 +0200 (CEST)
Received: by mail-qc0-f175.google.com with SMTP id w7so10799286qcr.34
 for <alsa-devel@alsa-project.org>; Sun, 25 May 2014 05:53:17 -0700 (PDT)
Received: from warpc (lucidpixels.com. [72.73.18.11])
 by mx.google.com with ESMTPSA id j5sm14895179qai.34.2014.05.25.05.53.15
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 25 May 2014 05:53:16 -0700 (PDT)
Content-Language: en-us
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

Hi,

 

Bug report:

 

==> /var/log/user.log <==

May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa-sink.c:
ALSA woke us up to write new data to the device, but there was actually
nothing to write!

May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa-sink.c:
Most likely this is a bug in the ALSA driver '(null)'. Please report this
issue to the ALSA developers.

May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa-sink.c: We
were woken up with POLLOUT set -- however a subsequent snd_pcm_avail()
returned 0 or another value < min_avail.

 

$ uname -a

Linux atom 3.14.0 #2 SMP Wed Apr 2 06:30:21 EDT 2014 x86_64 GNU/Linux

 

$ lsusb

Bus 002 Device 004: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS

Bus 002 Device 008: ID 0baf:0303 U.S. Robotics 

Bus 002 Device 007: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial
Port

Bus 002 Device 010: ID 0461:4d15 Primax Electronics, Ltd Dell Optical Mouse

Bus 002 Device 009: ID 413c:2002 Dell Computer Corp. SK-8125 Keyboard

Bus 002 Device 006: ID 413c:1002 Dell Computer Corp. Keyboard Hub

Bus 002 Device 005: ID 0d8c:0008 C-Media Electronics, Inc. 

Bus 002 Device 003: ID 2001:f103 D-Link Corp. DUB-H7 7-port USB 2.0 hub

Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub

Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Bus 001 Device 003: ID 0557:2221 ATEN International Co., Ltd Winbond Hermon

Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

 

Justin.
