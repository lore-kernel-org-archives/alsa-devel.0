From: Rob Nertney <rob@rob-otics.com>
Subject: Clock Drift between hardware sound card and snd_aloop
Date: Tue, 11 Jul 2017 21:13:56 -0700
Message-ID: <CALAeOVN7aFT36peds7ML4B2i0s-gpKz8L+_fAi8ud4MRzyRM-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f46.google.com (mail-lf0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B8FB0266E90
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 06:13:58 +0200 (CEST)
Received: by mail-lf0-f46.google.com with SMTP id b207so6207812lfg.2
 for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2017 21:13:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Hi all,

I have successfully built a sound capture card that runs at a given rate
off its own clock. I receive the stream and do some post-processing on it,
and I want to present this modified data to the user as a capture pcm.

I initially thought that snd_aloop would be the best idea, as I can pipe my
post-processed data directly into it. However, the driver is apparently
calculating exact timing of what "should" be the rate based off of CPU
ticks/jiffies and the requested period/sample rate/etc in the requested
output stream.

In my actual hardware I see cycle slips. Underruns and overruns based off
of minor adjustments to the card's rate.

Is snd_aloop the appropriate driver to be using? Or should I create a new
card, similar to snd_aloop, which is more specifically interrupted (and
associated pointer locations, etc. modified) from the hardware card as well?

It seems like I should be able to synchronize snd_aloop's timing with my
hardware clock, but I haven't found anywhere in the API to achieve this.

How else can I avoid this clock drift?

Thanks,
Rob
