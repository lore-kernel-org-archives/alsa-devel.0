From: Petr Maivald <petr@jezdec.com>
Subject: Re: no sound with intel audio
Date: Fri, 30 May 2014 18:05:06 +0200
Message-ID: <CADKJLGwR+XoPngrqkXqs05JYH090f21LzDV+0dnxUqvJZvpMxA@mail.gmail.com>
References: <CADKJLGxnyK5SkNQRuX1S5BMkM1XA_64TT77iR=dnEy-sw02+wQ@mail.gmail.com>
 <s5hy4xjr7cx.wl%tiwai@suse.de>
 <CADKJLGzYZy+GCmUHkkFU9wB0rPTrHMW01uAdwb6oUjvwvLHtiw@mail.gmail.com>
 <s5htx87r6b4.wl%tiwai@suse.de>
 <CADKJLGxYF9AtBwznmeu=OokvGNU_NyxXjVb2w_PPYo9dJDTXgg@mail.gmail.com>
 <s5hegzbmlvi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 30423265026
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 18:05:07 +0200 (CEST)
Received: by mail-lb0-f173.google.com with SMTP id 10so1138374lbg.4
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 09:05:06 -0700 (PDT)
In-Reply-To: <s5hegzbmlvi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> As a primary test, for example, try the following on a terminal:
>
>   % amixer -c1 set "Auto-Mute Mode" "Enabled"
>   % aplay -Dplughw:1 -vv some-your-file.wav
>
> where some-your-file.wav is any WAV file you'd like to hear.
>
> If you're using PulseAudio, try like below instead:
>
>   % pasuspender -- aplay -D plughw:1 -vv some-your-file.wav
>
> Does it play anything?  Try both the headphone plugged and unplugged.

My apologies, I did seriously try to figure out how to figure this out
and didn't come across anything that made any sense. So, I thought it
was a kernel bug...

Your suggestion to try aplay did indeed produce sound. It is the first
sound I was able to get out of this configuration ever. I attached the
output of alsa-info.sh with aplay playing, and with mplayer playing
and not working, and the diff. Thanks for your help, at least now I
have some clue about where to look.
