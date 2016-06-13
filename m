From: Ihar Filipau <thephilips@gmail.com>
Subject: Re: dmix produces garbled sound on ARM
Date: Mon, 13 Jun 2016 14:32:30 +0200
Message-ID: <CAD08gxJkLYh2VvqVhCu76a=kWUdnkuU7Eoni57bNVUvg0teRnA@mail.gmail.com>
References: <CAD08gxJmvpJ-DdGpEawmBZ4aZCNj_Gyhqdf7bSbqRrZ4Xa9Lqg@mail.gmail.com>
 <s5hshwmfre1.wl-tiwai@suse.de>
 <CAD08gxL6TVwu63B11_Hs9qbvFgwDjPnv3Y4mV-pMss6mK2kuGg@mail.gmail.com>
 <s5hoa7afq96.wl-tiwai@suse.de>
 <CAD08gxKw2UK9JJ80Pp5icxLC_k-8dGykhHd3DbUvjPJXUGzVtQ@mail.gmail.com>
 <s5hporqe5r2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id BC52C265099
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:32:31 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id n184so14542254wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 05:32:31 -0700 (PDT)
In-Reply-To: <s5hporqe5r2.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 6/9/16, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 09 Jun 2016 16:05:42 +0200,
> Ihar Filipau wrote:
>>
>> The only thing so far I have found is `aplay --dump-hw-params`, but it
>> seem to display the allowed ranges, not the defaults/the params which
>> are used.
>
> You just need to check what "aplay -v ..." shows.  For example,
> % aplay -Dplug:dmix -v foo.wav

I have just retested it with the "aloop", completely without hardware.
The garbled sound comes from the software, from the dmix/libasound.
The problem is not related to (sound) hardware.

I can upload the garbled output which was recorded by "arecord", if it
would be helpful in analyzing the problem. (12s, ~2MB wav.)

Regards.
