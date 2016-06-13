From: Ihar Filipau <thephilips@gmail.com>
Subject: Re: dmix produces garbled sound on ARM
Date: Mon, 13 Jun 2016 16:04:43 +0200
Message-ID: <CAD08gx++h++D6j3kjZreO-yp-COVH_5TNNdqnyAnQd45xVWrdA@mail.gmail.com>
References: <CAD08gxJmvpJ-DdGpEawmBZ4aZCNj_Gyhqdf7bSbqRrZ4Xa9Lqg@mail.gmail.com>
 <s5hshwmfre1.wl-tiwai@suse.de>
 <CAD08gxL6TVwu63B11_Hs9qbvFgwDjPnv3Y4mV-pMss6mK2kuGg@mail.gmail.com>
 <s5hoa7afq96.wl-tiwai@suse.de>
 <CAD08gxKw2UK9JJ80Pp5icxLC_k-8dGykhHd3DbUvjPJXUGzVtQ@mail.gmail.com>
 <s5hporqe5r2.wl-tiwai@suse.de>
 <CAD08gxJkLYh2VvqVhCu76a=kWUdnkuU7Eoni57bNVUvg0teRnA@mail.gmail.com>
 <s5hfush5kgt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B8FB265099
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 16:04:44 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id n184so15186698wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 07:04:44 -0700 (PDT)
In-Reply-To: <s5hfush5kgt.wl-tiwai@suse.de>
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

On 6/13/16, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 13 Jun 2016 14:32:30 +0200,
> Ihar Filipau wrote:
>>
>> On 6/9/16, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Thu, 09 Jun 2016 16:05:42 +0200,
>> > Ihar Filipau wrote:
>> >>
>> >> The only thing so far I have found is `aplay --dump-hw-params`, but it
>> >> seem to display the allowed ranges, not the defaults/the params which
>> >> are used.
>> >
>> > You just need to check what "aplay -v ..." shows.  For example,
>> > % aplay -Dplug:dmix -v foo.wav
>>
>> I have just retested it with the "aloop", completely without hardware.
>> The garbled sound comes from the software, from the dmix/libasound.
>> The problem is not related to (sound) hardware.
>
> Still it is likely a driver problem.  dmix updates are based on ALSA
> PCM slave timer, i.e. it's synced with PCM period elapses.  That is,
> if the driver updates at a wrong timing, sending the notification
> before the sample data has been processed, you'll get the garbled
> output as you have.
>

But the PCM in the case is the "aloop"? Or not? What other hardware is
involved in the process?

For the sake of a test, I have deactivated the SGTL5000 sound driver,
leaving only the "aloop" as sound device: the result hasn't changed.
But now there is only ALSA software + kernel which are involved.

I have also tried tickless vs fixed HZ kernels (CONFIG_NO_HZ=y vs
CONFIG_HZ_1000=y) but it didn't change anything. The result is the
same.

P.S. I have uploaded the sound file:

http://vocaroo.com/i/s1cU2DRVgJNw

This is supposed to be first 12 seconds of "Annie Lennox - Honestly"
song. (Outside the Germany, it should be readily available on the
YouTube.)
