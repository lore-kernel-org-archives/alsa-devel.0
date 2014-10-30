From: Tim Harvey <tharvey@gateworks.com>
Subject: ASoC HDMI receiver driver
Date: Wed, 29 Oct 2014 20:34:49 -0700
Message-ID: <CAJ+vNU2mwrdkBsKU8k+8c1_yruSfSckjqe9A-_JDv4pkTbK4XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CA4F426060F
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 04:34:50 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id y20so1954070ier.25
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 20:34:49 -0700 (PDT)
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

Greetings,

I'm working on an ASoC driver (an mfd driver for an HDMI receiver chip
with an accompanying codec driver for the audio capture portion, and a
cpu-dai driver for the specific SoC its hooked to). I can't seem to
figure out what kind of hook I need in order to fill out the
snd_pcm_substream fields specifying the rate/channels/sample-format of
the receiving HDMI audio stream. In this case HDMI audio (and thus the
codec) supports several rates but it doesn't make sense that the codec
is told what rate to capture at as the rate is dictated by the current
stream the receiver is being provided. I'm thinking there is some hook
I'm missing that allows the codec to fill in the params dynamically
when the capture device is opened.

Any pointers to how I deal with this?

Thanks,

Tim
