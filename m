From: Andrew Reyes <dsreyes1014@gmail.com>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Mon, 21 Apr 2014 11:51:08 -0500
Message-ID: <CAEYsuVNvr3WE+RCgCHKZHrBKybAc8muhx3nMu1NgfRgVbj9z1g@mail.gmail.com>
References: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>
 <53551C5B.5010002@zonque.org>
 <CAEYsuVP1pr87v0y5SuKL87bCRr5RpfgLiSfjsZb4mis1yE_w1g@mail.gmail.com>
 <CAEYsuVML1ZFGGP35KB=3im_JTgNSCoNfPg1aMnzT6mjR=u1cJA@mail.gmail.com>
 <5355431F.3000501@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F107260816
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 18:51:14 +0200 (CEST)
Received: by mail-qa0-f46.google.com with SMTP id i13so4006498qae.33
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 09:51:09 -0700 (PDT)
In-Reply-To: <5355431F.3000501@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The while shell command shows consistent 96k when set at 96khz and dmesg
shows nothing where it pops and clicks.  How do I use aplay to adjust
buffer-size?


On Mon, Apr 21, 2014 at 11:11 AM, Daniel Mack <daniel@zonque.org> wrote:

> (please do not top-post)
>
> On 04/21/2014 04:17 PM, Andrew Reyes wrote:
> > And this is the pastebin link for the stream info set at 48khz:
> > http://pastebin.com/ysw6j5uA
>
> Ok, so the actual frequency is close enough to the nominal one. Please
> also do the tests wit aplay to see whether your issue can be recovered
> by chosing larger buffer sizes. Do you see any messages in dmesg when
> these 'clicks and pop' occur?
>
> Also, please try this one:
>
>   (while sleep 0.123; do grep 'Momentary freq' /proc/asound/xxx/stream0;
> done) | uniq
>
> Thanks,
> Daniel
>
>
