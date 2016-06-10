From: Ihar Filipau <thephilips@gmail.com>
Subject: Re: dmix produces garbled sound on ARM
Date: Fri, 10 Jun 2016 14:06:31 +0200
Message-ID: <CAD08gx+mv5GtD=Vc0iw51OeKuzeUwRXHHTZMu--j31xdDWMcbQ@mail.gmail.com>
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
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 111FB261294
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2016 14:06:33 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id r5so17471626wmr.0
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2016 05:06:33 -0700 (PDT)
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

[ Replying back to the list, since exchange of the lengthy outputs is
over for now. ]

My parameters are nearly identical to yours (except for the
differences which could be attributed to my 32-bit vs your 64-bit
systems, and the hardware S16_LE vs S32_LE). Yet the problem persists.

I have checked the Raspberry Pi forums/mail list and it seems that
"dmix" works fine there. Thus, the problem might be related to the hw
driver.

How can I localize the problem? Is there any way to intercept the data
stream which goes to the sound card, and compare the content between
normal direct playback vs dmix?

P.S. Though the window is closing for my investigations. I'm starting
to prepare a workaround: applications shouldn't keep pcm open all the
time, should open pcm when needed, and they should retry with a delay
if opening pcm failed.
