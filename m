From: Ricardo Crudo <ricardo.crudo@gmail.com>
Subject: Fwd: enabling a20 allwinner audio codec to 24bit
Date: Thu, 22 May 2014 18:30:35 -0300
Message-ID: <CAPjqk-+5Y84oWjdzPw6DBm4Dzzh1GhJC49_WKnRKcW+yzgCYDg@mail.gmail.com>
References: <CAPjqk-JXPen2TF7f4Sb9S0T7VNq++-0Gpb3rGCkWk1yUoECdaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D476261A3D
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 23:30:56 +0200 (CEST)
Received: by mail-la0-f44.google.com with SMTP id hr17so3243562lab.17
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 14:30:56 -0700 (PDT)
In-Reply-To: <CAPjqk-JXPen2TF7f4Sb9S0T7VNq++-0Gpb3rGCkWk1yUoECdaQ@mail.gmail.com>
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

Hello,

I'm working with sunxi-codec of allwinner A20 device. Currently the
codec driver works only for 16bit mode, the source code can be found
here: https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-3.4/sound/soc/sunxi,
 and the A20 datasheet here:
https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/A20-PDFs/A20%20User%20Manual%202013-03-22.pdf.

Reading the allwinner A20 datasheet and doing some modifications on
sunxi code I managed the codec to work in 24bit mode. However, it
isn't working properly. When I play a stereo wav file using the aplay
command the audio data of both channels are played mixed in only one
channel and the another channel didn't plays any sound.

For example, picture a wav stereo file with this samples:
left  right
0.5  -0.5
0.4  -0.4
0.3  -0.3
0.2  -0.2

The played sound is:
left   right
 0.5  0.0
-0.5  0.0
 0.4  0.0
-0.4  0.0
 0.3  0.0
-0.3  0.0
 0.2  0.0
-0.2  0.0

The A20 datasheet says:
"DAC TX DATA REGISTER (TXDATA): Transmitting left, right channel
sample data should be written this register one by one. The left
channel sample data is first and then the right channel sample."

I guess that this is related with the problem, despite the datasheet
didn't notify, I think that in 16bit mode the TXDATA transmits both
channels data together as the register is 32bit.

I'm not familiar writing alsa driver and other alsa working concepts.
I hope someone can help me with this.

The diff file of sunxi-codec.c is here: http://pastebin.com/raw.php?i=SvypkVU6

I appreciate any help.

Regards,
Ricardo
