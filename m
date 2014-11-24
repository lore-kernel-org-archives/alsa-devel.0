From: Catalin Crenguta <catalin.crenguta@gmail.com>
Subject: TLV320AIC3104 Sample rate problem
Date: Mon, 24 Nov 2014 18:03:33 +0200
Message-ID: <CABH3fy9DXUu32b8J-QA6FkpZ7eFNu6gfR=8tApLnQTzfubpsYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, beagleboard@googlegroups.com
List-Id: alsa-devel@alsa-project.org

Hello,

I'm using an Audio Cape Rev. B connected to BeagleBone Black
(MCLK=12MHz) and I'm trying to record audio at sample rate 8KHz.
Recording and playback using ALSA is OK, but when playing the recorded
samples on PC you can hear that the actual sample rate is lower (the
pitch shifted to a lower tone).
I have added debug messages throughout the alsa driver tlv320aic3x.c,
and I found out that the PLL parameters are computed correctly as in
TLV320AIC3104 Datasheet Table found at page 27. (p: 1 j: 8 d: 1920 r:
1).
Has anyone else encountered a problem like this? Can someone with more
experience check the driver?

Kernel: https://github.com/beagleboard/linux , commit 2bcc89c, 3.14.19+.

Best regards,
Catalin Crenguta
