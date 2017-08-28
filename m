From: "S. Christian Collins" <s.chriscollins@gmail.com>
Subject: "alsactl store" fails to save Echo Gina3G mixer
Date: Mon, 28 Aug 2017 10:34:34 -0500
Message-ID: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 778982664EB
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 17:34:39 +0200 (CEST)
Received: by mail-it0-f51.google.com with SMTP id o132so3455489itc.1
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 08:34:39 -0700 (PDT)
Received: from [192.168.0.50] (68-190-167-211.dhcp.eucl.wi.charter.com.
 [68.190.167.211])
 by smtp.gmail.com with ESMTPSA id y1sm306223itd.8.2017.08.28.08.34.35
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Aug 2017 08:34:35 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Greetings,

I have two PCI sound cards in my PC:
   1. Sound Blaster Audigy 2 ZS Gold (primary card)
   2. Echo Gina3G

If I save the mixer for the Audigy 2 via:

   alsactl -f ~/asound0.state store 0

...the Audigy 2's mixer is properly saved.

However, when I try to save the Gina3G mixer:

   alsactl -f ~/asound1.state store 1

...I get the following error:

alsactl: control.c:2513: snd_ctl_elem_value_get_integer: Assertion `idx 
< sizeof(obj->value.integer.value) / 
sizeof(obj->value.integer.value[0])' failed.
Aborted

I have tried to find any info on this error online, but to no avail. 
Does anybody know what is going on here?

** My System **
OS: KDE Neon 5.10.5 64-bit (Plasma Desktop 5.10.5, KDE Frameworks 
5.37.0, Qt 5.9.1)
Linux Kernel: 4.10.0.32-generic
Motherboard: ASRock X58 Extreme3 (Intel X58 chipset)
CPU: Intel Core i7 930 (2.8 GHz quad-core)
RAM: 12GB DDR3
Video: NVIDIA GeForce GTX 970 w/ 4GB RAM (PCI Express)
Sound Card #1: Sound Blaster Audigy 2 ZS Gold
Sound Card #2: Echo Gina3G
NVIDIA video driver: 375.66
