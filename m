From: =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev@andree.sk>
Subject: Re: [PATCH 09/15] ALSA: line6: Add hwdep interface to
 access the POD control messages
Date: Fri, 12 Aug 2016 18:43:30 +0200
Message-ID: <CAFnc+wW4ff92jWCmh1XY2qdh4NKcDJFUFyByGtEYeASF7Bqo8g@mail.gmail.com>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1470942147-19848-10-git-send-email-dev@andree.sk>
 <s5h8tw2fkbe.wl-tiwai@suse.de>
 <CAFnc+wWRFjyJmY0=hJDAOZQvZJP46Kp+HqbCZMGRLvsdLN8gVQ@mail.gmail.com>
 <s5hlh02dwj8.wl-tiwai@suse.de>
 <CAFnc+wU7NMg=KTF-z7PewoAn5kK=QX7MZMXpVa_97PikPRgQpw@mail.gmail.com>
 <s5hh9aqdv9z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 391C8265D66
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 18:43:51 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id o80so3888706wme.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 09:43:51 -0700 (PDT)
In-Reply-To: <s5hh9aqdv9z.wl-tiwai@suse.de>
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

On Fri, Aug 12, 2016 at 2:30 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 12 Aug 2016 14:15:16 +0200,
>>
>> >> > Also, the blocking read/write control isn't usually done by a
>> >> > semaphore.  Then you can handle the interrupt there.
>> >> >
>> >> >
>> >>
>> >> I actually wonder why, semaphores seemed perfect for this... Do you
>> >> have some hints?
>> >
>> > Assume you want to interrupt the user-space app while it's being
>> > blocked by the semaphore.  With your code, you can't.
>> >
>> >
>>
>> You can - down_interruptible() is there for this exact reason.
>
> There is another blocking path: you keep semaphore down after
> line6_hwdep_read() until line6_hwdep_push_message().  What happens if
> user-space interrupts during that, and line6_hwdep_push_message() is
> delayed or stall by some reason?
>

Actually, I think I don't see what's the "another path" here, could
you please elaborate one more bit? I just want to make sure to not
reimplement the same race using waitqueue...

What's the point then? line6_hwdep_push_message() could get not
scheduled for some while. So until it calls up(), line6_hwdep_read()
will block on down_interruptible(), or until signal (in which case
user gets -ERESTARTSYS). After up() is called, there are data in
buffer... If line6_hwdep_read() returns after interrupt, no problem -
the buffer will just continue to be filled and semaphore will be
up()'d while there's free buffer space. Or until the device is
closed...

If I do the same via waitqueue, I will have the same problems, no?
Maybe if you could post the steps where you see the race...

At the same time, looking at __down_common(), it just does the
standard waitqueue stuff (TASK_INTERRUPTIBLE + schedule()) (+counter
in down())... So do you have some other race in mind? I'm running in
circles, so surely you must :-)


Sorry if I sound like a moron... and thanks for you time!

-- 
Andrej
