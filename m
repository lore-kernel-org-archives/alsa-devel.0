From: Sangsu Park <sangsu@gmail.com>
Subject: Can ASoC support SPDIF AC3 passthrough playback (non
	linear PCM) ?
Date: Sun, 22 Jul 2012 00:39:50 +0900
Message-ID: <CANh+=Y-jvvhafmiTFr_XgiO2sBUKCa0Z=hzMvgxyJbry3L1YNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 080EA265B8E
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 17:39:49 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so7921673pbb.38
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 08:39:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, android-platform@googlegroups.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,
We're developing a platform where we have SPDIF output.
And we want to SPDIF AC3 playback (non linear PCM).
Our CPU is a kind of ARM architecture one and it has a SPDIF that can
support AC3 passthrough playback.

I've already know that ALSA can support SPDIF AC3 passthrough playback
like follows,
http://www.mythtv.org/wiki/Configuring_Digital_Sound_with_AC3_and_SPDIF
But, I can't find that any ARM architecture CPU can be supportable for
SPDIF AC3 passthrough playback.

Are there anyone who have a SPDIF AC3 passthrough playback?
or anyone who know the clue about SPDIF AC3 passthrought playback
supportable on ASoC?

Our SPDIF already can support on linear PCM playback.
But we have no experience in SPDIF AC3 passthrough playback.
Just changing register setup from linear PCM playback to non-linear
PCM playback is enough?
Or any reference code on ASoC for SPDIF passthrough playback?

Any hint would be greatly appreciated.
Thanks.
