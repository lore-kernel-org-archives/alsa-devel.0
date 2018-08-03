From: Yu-hsuan Hsu <yuhsuan@google.com>
Subject: A question about period
Date: Fri, 3 Aug 2018 14:28:37 +0800
Message-ID: <CAEy1m_DhdnfaRQADr4DaurCNnCi0fmCna5tJXEk9dA+KQ8jfcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 769E52677D8
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 08:28:50 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id m11-v6so8017233oic.2
 for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2018 23:28:50 -0700 (PDT)
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

Hi all,

I have a question about the period we set in hw_params. I found different
boards may have different explanations about it. I have two guesses about
its meaning.

1. The period_size is the size of each hardware's consumption. If we set
period size to N, the pcm will consume N frames each time.

2. The period_size is the size to control when hardware call interrupt. If
we set period size to N, the pcm consume frames in its step. When the
number of frames it consumes more than N, it will call interrupt.

We can use snd_pcm_avail function to check the real available frames in
the device. If guess 1 is correct, the size of consumption should be fixed.
Else, setting period_size is nothing to do with hardware's
consumption. I've checked some boards and found that each board has
different behavior (Most of them meet guess 2). I'm confuse which one is
correct. Thanks!
