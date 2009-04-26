From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problem bringing up new alsa driver
Date: Sun, 26 Apr 2009 19:43:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904261926470.25064@eeebox2.perex-int.cz>
References: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
	<9e4733910904251428r678cd32fkc6c56e4f43a1887b@mail.gmail.com>
	<s5hljpnwtst.wl%tiwai@suse.de>
	<9e4733910904260842g991f476ib112d12c0f481e5d@mail.gmail.com>
	<s5hws97xsau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1617931547-1240767811=:25064"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BF9124334
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 19:43:32 +0200 (CEST)
In-Reply-To: <s5hws97xsau.wl%tiwai@suse.de>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1617931547-1240767811=:25064
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 26 Apr 2009, Takashi Iwai wrote:

> At Sun, 26 Apr 2009 11:42:14 -0400,
> Jon Smirl wrote:
>>
>> On Sun, Apr 26, 2009 at 7:14 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>> At Sat, 25 Apr 2009 17:28:55 -0400,
>>> Jon Smirl wrote:
>>>>
>>>> These new patches have broken audio support on the mpc5200....
>>>
>>> Then the lowlevel callbacks are likely wrong :)
>>>
>>>> They assume that the hardware is capable of telling where the DMA
>>>> engine is in the middle of an operation.
>>>
>>> Well, nothing new by these patches. =C2=A0The original PCM core
>>> implementation has been designed in that way. =C2=A0These changes may c=
heck
>>> some bogus value more strictly.
>>>
>>> If the hardware doesn't support it, it needs report at least some
>>> "sane" value; i.e. it must not be over the real position, but not
>>> below the previous pointer.
>>
>>
>>
>>> In the worst case, the driver just needs to report the same position
>>> at the previous period boundary until the next
>>> snd_pcm_period_elapsed().
>>
>> That's doesn't work anymore. The PCM code is using jiffies to estimate
>> where the pointer needs to be.
>> I used the same jiffies to fake up a hardware position.
>
> Hrm, then it's a breakage.  The quantum position must be still
> supported.
> Jaroslav, could you check that?  It's your new code...

My code checks only if samples delta is over expected jiffies delta, thus=
=20
this case should not be evaluated as a wrong ring buffer position. It just=
=20
problem with John's broken lowlevel driver.

But adding finer resolution for pointer callback using jiffies or other=20
timing source might make sense when hardware does not transfer whole=20
buffer quickly (just small FIFO is on path). I'm not only sure, if we=20
should add this code to the pcm midlevel code, because it's relatively=20
easy to implement this in the lowlevel driver.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1617931547-1240767811=:25064
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1617931547-1240767811=:25064--
