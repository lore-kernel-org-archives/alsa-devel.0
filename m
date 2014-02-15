From: Barnaby Jones <barnabyjones65@gmail.com>
Subject: Stereo audio not coming through with a TI codec
Date: Sat, 15 Feb 2014 10:00:04 -0800
Message-ID: <CAK+7dPJfmRUBULp3XC8Uho8uGW53jJg9rWSMBAZTb0DS2CG6DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f196.google.com (mail-ie0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 556FA2615BF
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 19:00:05 +0100 (CET)
Received: by mail-ie0-f196.google.com with SMTP id rd18so1257017iec.11
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 10:00:04 -0800 (PST)
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

Hey all,

I'm working on a project that has a TI TLV320AIC3256 codec hooked up to an
OMAP 4 processor.  My biggest issue right now is that I'm only getting one
of the channels.  E.g. if I run:

% tinycap test.wav -d 0 -r 48000 -b 16

Only one of the channels (left, in this case) has any data.  The right
channel is all 0s.

I'm using the tlv320aic325x.c driver that's publicly available from TI[1].
I've verified that the I2S data sent from the codec to the processor has
data on both channels (i.e. I see I2S data on both the high and low phases
of the frame sync).

I'm looking for any help figuring out where to start looking in the sound
system to debug this.  I'm not really familiar with how the I2S data makes
its way from the hardware buffers to the PCM driver; any help there would
be appreciated too!

Thanks
- B

[1]:
https://gitorious.org/ti-codecs/ti-codecs/source/721c6e957db39a9d2174cecd4ca6a7c3d88b3e52:sound/soc/codecs/tlv320aic325x.c
