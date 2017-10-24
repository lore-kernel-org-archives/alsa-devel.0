From: =?UTF-8?B?QWxiaW4gU3RpZ8O2?= <albin.stigo@gmail.com>
Subject: New to this list. Proposed patch to soc-utils.c
Date: Tue, 24 Oct 2017 12:42:25 +0200
Message-ID: <CAMc++1XF4TM42+xxTSTOThGt8SWyfY_rjibSjPrHH+ZcKehLCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id C1D83266DD4
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 12:42:27 +0200 (CEST)
Received: by mail-ua0-f176.google.com with SMTP id w45so15072436uac.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 03:42:27 -0700 (PDT)
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

I'm new to this list so please excuse my ignorance. I'm an
anesthesiologist by profession so I might be a bit out of my depth
here...

I was doing some experimentation with custom i2s codecs (FPGAs) using
the snd-soc-dummy codec (defined in soc-utils.c). I found this codec
to be needlessly restrictive with sample rates allowed
(SNDRV_PCM_RATE_8000_192000). I needed to use more "exotic" sample
rates so I came up with a patch.

I purpose using SNDRV_PCM_RATE_KNOT and setting some limits:
.rate_min = 8000,
.rate_max = 384000,

It's my understanding that SNDRV_PCM_RATE_CONTINIOUS is used for
"known" rates and SNDRV_PCM_RATE_KNOT for more or less arbitrary
rates?

I'm willing to submit my patch but might need some mentoring in the
process. I don't think this simple patch could break anything..?


--Albin
