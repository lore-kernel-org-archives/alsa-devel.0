From: Rob Nertney <rob@rob-otics.com>
Subject: arecord: does hardware or software throw away unused
Date: Thu, 1 Sep 2016 23:55:37 -0700
Message-ID: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C10F26724D
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 08:55:39 +0200 (CEST)
Received: by mail-vk0-f43.google.com with SMTP id j189so5943133vkc.2
 for <alsa-devel@alsa-project.org>; Thu, 01 Sep 2016 23:55:39 -0700 (PDT)
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

My hardware is putting a stream of MAX_CHANNELS into memory, and firing the
IRQs on my period boundary with respect to this full MAX_CHANNELS stream.

If I apply an arecord -c <MAX_CHANNELS-x> flag, essentially saying that I
only want to capture less than the maximum number of channels, will arecord
expect that the *hardware* will throw away the unused channel data, and the
data placed into memory is a contiguous stream of only pertinent channels?

Or will arecord see the MAX_CHANNELS in my driver, and use its *software*
to strip out the upper channels worth of data automatically for me?

For example, if I am capturing 2 channels of u8 data, and my dma regardless
puts the data into memory as
11111111222222221111111122222222_IRQ_11111111222222221111111122222222. If I
apply an "arecord -c 1 ...", and my DMA remains unchanged, will the
resulting wavfile have 1111111111111111_IRQ_1111111111111111?

Thanks,
Rob
