From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Problem bringing up new alsa driver
Date: Sun, 26 Apr 2009 11:42:14 -0400
Message-ID: <9e4733910904260842g991f476ib112d12c0f481e5d@mail.gmail.com>
References: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
	<9e4733910904251428r678cd32fkc6c56e4f43a1887b@mail.gmail.com>
	<s5hljpnwtst.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A430243B3
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 17:42:17 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1527926qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2009 08:42:15 -0700 (PDT)
In-Reply-To: <s5hljpnwtst.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 7:14 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 25 Apr 2009 17:28:55 -0400,
> Jon Smirl wrote:
>>
>> These new patches have broken audio support on the mpc5200....
>
> Then the lowlevel callbacks are likely wrong :)
>
>> They assume that the hardware is capable of telling where the DMA
>> engine is in the middle of an operation.
>
> Well, nothing new by these patches. =A0The original PCM core
> implementation has been designed in that way. =A0These changes may check
> some bogus value more strictly.
>
> If the hardware doesn't support it, it needs report at least some
> "sane" value; i.e. it must not be over the real position, but not
> below the previous pointer.



> In the worst case, the driver just needs to report the same position
> at the previous period boundary until the next
> snd_pcm_period_elapsed().

That's doesn't work anymore. The PCM code is using jiffies to estimate
where the pointer needs to be.
I used the same jiffies to fake up a hardware position.

>
>
> Takashi
>
>> =A0I'm still checking to see if
>> I can get that data out of the Bestcomm DMA engine.
>>
>> jonsmirl@terra:/home/linus/sound/core$ git log pcm_lib.c
>> commit bbf6ad1399e9516b0a95de3ad58ffbaed670e4cc
>> Author: Jaroslav Kysela <perex@perex.cz>
>> Date: =A0 Fri Apr 10 12:28:58 2009 +0200
>>
>> =A0 =A0 [ALSA] pcm-midlevel: Add more strict buffer position checks base=
d on jiffies
>>
>> =A0 =A0 Some drivers like Intel8x0 or Intel HDA are broken for some
>> hardware variants.
>> =A0 =A0 This patch adds more strict buffer position checks based on jiff=
ies when
>> =A0 =A0 internal hw_ptr is updated. Enable xrun_debug to see mangling of=
 wrong
>> =A0 =A0 positions.
>>
>> =A0 =A0 As a side effect, the hw_ptr interrupt update routine might do
>> slightly better
>> =A0 =A0 job when many interrupts are lost.
>>
>> =A0 =A0 Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>>
>> commit 8b22d943c34b616eefbd6d2f8f197a53b1f29fd0
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date: =A0 Fri Mar 20 16:26:15 2009 +0100
>>
>> =A0 =A0 ALSA: pcm - Safer boundary checks
>>
>> =A0 =A0 Make the boundary checks a bit safer.
>> =A0 =A0 These caese are rare or theoretically won't happen, but nothing
>> =A0 =A0 bad to keep the checks safer...
>>
>> =A0 =A0 Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>> commit ded652f7024bc2d7b6118b561a44187af30841b0
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date: =A0 Thu Mar 19 10:08:49 2009 +0100
>>
>> =A0 =A0 ALSA: pcm - Fix delta calculation at boundary overlap
>>
>> =A0 =A0 When the hw_ptr_interrupt reaches the boundary, it must check wh=
ether
>> =A0 =A0 the hw_base was already lapped and corret the delta value approp=
riately.
>>
>> =A0 =A0 Also, rebasing the hw_ptr needs a correction because buffer_size=
 isn't
>> =A0 =A0 always aligned to period_size.
>>
>> =A0 =A0 Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>> commit 5f513e1197f27e9a0bcfec0feaac59f976f4a37e
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date: =A0 Thu Mar 19 10:01:47 2009 +0100
>>
>> =A0 =A0 ALSA: pcm - Reset invalid position even without debug option
>>
>> =A0 =A0 Always reset the invalind hw_ptr position returned by the pointer
>> =A0 =A0 callback. =A0The behavior should be consitent independently from=
 the
>> =A0 =A0 debug option.
>>
>> =A0 =A0 Also, add the printk_ratelimit() check to avoid flooding debug
>> =A0 =A0 prints.
>>
>> =A0 =A0 Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>>
>>
>> --
>> Jon Smirl
>> jonsmirl@gmail.com
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>



-- =

Jon Smirl
jonsmirl@gmail.com
