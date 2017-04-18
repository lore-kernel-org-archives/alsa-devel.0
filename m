From: Garrett Thornburg <film42@gmail.com>
Subject: Re: [PATCH] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Mon, 17 Apr 2017 20:02:47 -0400
Message-ID: <CAEEqfk5Wve7sVVqNteejnXOEeNbnKu4dTDORgsw7wfFj8gOMRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f195.google.com (mail-ua0-f195.google.com
 [209.85.217.195])
 by alsa0.perex.cz (Postfix) with ESMTP id B6F72266872
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 02:02:49 +0200 (CEST)
Received: by mail-ua0-f195.google.com with SMTP id q26so11880436uaa.3
 for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2017 17:02:49 -0700 (PDT)
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

This is my first time posting in any type of mailing list, so
hopefully I'm doing this right. I recently encountered the audio
trouble with I2S mode via the headphone jack on my Dell XPS 9343 as
well and found your patch.

I applied the patch to the latest stable kernel (4.10) on arch linux
mostly using their tools and the repeated clicking sound is fixed when
no sound is playing. However, sometimes when sound is playing, the
clicking returns but it's much more mild. If I pause/ resume music,
for example, it might "click.. click.. click.." very quietly, but not
always. It's audible when I turn the volume level down low, but
overall it's much better.

I do still get somewhat loud pops when resuming music after the sound
card has been idle for a while, or a pop when the card switches to an
idle state.

This patch has really improved my situation though, so thank you :).
