From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Using codec pins to configure part of audio routing
	subsystem
Date: Mon, 15 Sep 2014 10:41:46 -0700
Message-ID: <CAOMFOmXQtGe38_=vcjyAgt8RgEhCJ4ik4jShsGp2DtyJjbd=qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id B51A8265948
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 19:41:50 +0200 (CEST)
Received: by mail-vc0-f171.google.com with SMTP id im17so3781441vcb.30
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 10:41:48 -0700 (PDT)
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

Hi

Here is reiteration from my previous question [1]

I have following task. I have realtek rt5677 codec. Codec has 6 pins.
Some of the pins are configured as output and used to manipulate part
of audio routing subsystem. In my case one pin enables headphones amp,
another pin gates DMIC clock.

I can easily do it by hard-coding this logic to rt5677 driver. Now I
an trying to pull this board-specific logic out of the codec driver
code and move it to device tree.

I was told (without much explanation) to do it either 2 ways:

1) export codec pins as gpio and then create fixed regulator and tie
it to codec via SND_SOC_DAPM_REGULATOR_SUPPLY. I sent a question [1]
to clarify if it is the right way.

2) create ALSA controls for pins. I believe it means I need to create
controls with names "GPIO1", "GPIO2"..."GPIO6" and then use as part of
audio_routing list.

What is the right way to achieve my goal. Are there examples of
configuration similar to mine? I am sure it is an easy task that was
already implemented by someone, but I can't google any useful result.

[1] http://comments.gmane.org/gmane.linux.alsa.devel/127508
