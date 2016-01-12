From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_stop
Date: Tue, 12 Jan 2016 17:46:15 +0100
Message-ID: <CACT4Y+ZF+AQ3nbDUU24NCkHR17PK7yJjdrR8gVEJT1WyyyiWLA@mail.gmail.com>
References: <CACT4Y+borJj9XYEtXzLUbH9gUipPi9TQaj_O8Sw3tNUvFODPZA@mail.gmail.com>
 <s5hh9iiyjtn.wl-tiwai@suse.de> <s5hegdmyjbc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C95A4260502
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 17:46:35 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id l65so259845095wmf.1
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 08:46:35 -0800 (PST)
In-Reply-To: <s5hegdmyjbc.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, Eric Dumazet <edumazet@google.com>, Mark Brown <broonie@kernel.org>, Alexander Potapenko <glider@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 12, 2016 at 3:16 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 12 Jan 2016 15:05:24 +0100,
> Takashi Iwai wrote:
>>
>> On Tue, 12 Jan 2016 11:22:09 +0100,
>> Dmitry Vyukov wrote:
>> >
>> > Hello,
>> >
>> > I've hit the following use-after-free while running syzkaller fuzzer.
>> > It is followed by a splat of other reports and finally kernel death.
>> > I wasn't able to reproduce it with a standalone C program (there is
>> > probably some global state  involved). But it reproduces by replaying
>> > fuzzer logs in a loop (you will need Go toolchain):
>> >
>> > $ go get github.com/google/syzkaller
>> > $ cd $GOPATH/src/github.com/google/syzkaller
>> > $ make executor execprog
>>
>> Just a note: I had to run "mkdir bin" beforehand.
>> Also for my distro, I had to remove -static.
>>
>> > $ scp bin/syz-executor bin/syz-execprog your@machine
>> > $ scp snd_timer_stop your@machine # the attached file
>> > on test machine:
>> > $ ./syz-execprog -executor ./syz-executor -cover=0 -repeat=0 -procs=16
>> > snd_timer_stop
>>
>> I tried this but couldn't reproduce the issue on my machine,
>> unfortunately.  (Instead I hit another kernel panic regarding apparmor
>> :)
>>
>> But looking through your log, it seems like a missing race
>> protection.  Does the patch below work for you?
>
> Gah, scratch this.  The second hunk causes a deadlock.
> The revised patch is below (just containing the first hunk).

Yes, this patch fixes the crashes for me.
Reproduction may require running syz-execprog for several minutes.

Tested-by: Dmitry Vyukov <dvyukov@google.com>


> ---
> diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
> index 7dfd0f429410..0bec02e89d51 100644
> --- a/sound/core/seq/seq_queue.c
> +++ b/sound/core/seq/seq_queue.c
> @@ -142,8 +142,10 @@ static struct snd_seq_queue *queue_new(int owner, int locked)
>  static void queue_delete(struct snd_seq_queue *q)
>  {
>         /* stop and release the timer */
> +       mutex_lock(&q->timer_mutex);
>         snd_seq_timer_stop(q->timer);
>         snd_seq_timer_close(q);
> +       mutex_unlock(&q->timer_mutex);
>         /* wait until access free */
>         snd_use_lock_sync(&q->use_lock);
>         /* release resources... */
