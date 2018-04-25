From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: ASoC: BCM2835-I2S: TDM slots / slot mask ignored
Date: Wed, 25 Apr 2018 09:00:34 -0500
Message-ID: <20180425140031.GA3423@t7-ThinkPad-E560>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 13287267766
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 16:00:44 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id e80-v6so13497546oig.11
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 07:00:44 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: florian.meier@koalo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am testing a codec driver interfaced to the Raspberry Pi in TDM mode
and on the logic analyzer I see that the I2S controller is shifting out
data in slots 2 - 7 when playing 2 channel audio. The codec is master 
and only works at 256 x fs, so after the frame sync slots 0 and 1 
transfer as they should but after that data continues to be shifted out.
It is my understanding that the remaining bits should be zero padded.

On a similar note I see that the I2S bcm2835-i2s driver only supports 2
slots, but it seems it can also do 8. For example if I take an 8 channel
audio source file(NOTE: I had to hack the file to look like 2 channels
so hw_params didn't return an error) and play it I hear the first two 
channels fine and in the part that I am writing the dirver for I can 
easily route the other slots to additional DACs and get those to play
as well.

So I guess I am wondering about two things:

1. In the first case why does my 2 channel audio get shifted out on all
8 slots? It seems if configured for 2 it should only shift data in the
first two and wait for the next fsync before starting to shift again.

2. Why does the driver obly support 2 channels when it seems the
hardware is capable of more?

I figure there is something about this controller that made this tricky
or impossible, but I am still curious about it.

Regards,

Steven
