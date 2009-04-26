From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Problem bringing up new alsa driver
Date: Sun, 26 Apr 2009 14:12:42 -0400
Message-ID: <9e4733910904261112l488b30b1s6180d651ff2f47f9@mail.gmail.com>
References: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
	<9e4733910904251428r678cd32fkc6c56e4f43a1887b@mail.gmail.com>
	<s5hljpnwtst.wl%tiwai@suse.de>
	<9e4733910904260842g991f476ib112d12c0f481e5d@mail.gmail.com>
	<s5hws97xsau.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904261926470.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id CE8122439E
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 20:12:43 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1556767qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2009 11:12:42 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904261926470.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 1:43 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Sun, 26 Apr 2009, Takashi Iwai wrote:
>
>> At Sun, 26 Apr 2009 11:42:14 -0400,
>> Jon Smirl wrote:
>>>
>>> On Sun, Apr 26, 2009 at 7:14 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>>
>>>> At Sat, 25 Apr 2009 17:28:55 -0400,
>>>> Jon Smirl wrote:
>>>>>
>>>>> These new patches have broken audio support on the mpc5200....
>>>>
>>>> Then the lowlevel callbacks are likely wrong :)
>>>>
>>>>> They assume that the hardware is capable of telling where the DMA
>>>>> engine is in the middle of an operation.
>>>>
>>>> Well, nothing new by these patches. =A0The original PCM core
>>>> implementation has been designed in that way. =A0These changes may che=
ck
>>>> some bogus value more strictly.
>>>>
>>>> If the hardware doesn't support it, it needs report at least some
>>>> "sane" value; i.e. it must not be over the real position, but not
>>>> below the previous pointer.
>>>
>>>
>>>
>>>> In the worst case, the driver just needs to report the same position
>>>> at the previous period boundary until the next
>>>> snd_pcm_period_elapsed().
>>>
>>> That's doesn't work anymore. The PCM code is using jiffies to estimate
>>> where the pointer needs to be.
>>> I used the same jiffies to fake up a hardware position.
>>
>> Hrm, then it's a breakage. =A0The quantum position must be still
>> supported.
>> Jaroslav, could you check that? =A0It's your new code...
>
> My code checks only if samples delta is over expected jiffies delta, thus
> this case should not be evaluated as a wrong ring buffer position. It just
> problem with John's broken lowlevel driver.
>
> But adding finer resolution for pointer callback using jiffies or other
> timing source might make sense when hardware does not transfer whole buff=
er
> quickly (just small FIFO is on path). I'm not only sure, if we should add
> this code to the pcm midlevel code, because it's relatively easy to
> implement this in the lowlevel driver.

I set snd_pcm_hw_constraint_integer(runtime,  SNDRV_PCM_HW_PARAM_PERIODS);
I don't get errors from ALSA when playing with this set.

I then tried removing the DMA position estimating code.

	delta =3D jiffies - s->jiffies;
	delta =3D delta * runtime->rate / HZ;
	frames =3D bytes_to_frames(substream->runtime, count);
	return frames + delta;

If I take this out I get these errors...
ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=3D11026,
delta=3D5513, period=3D5513, jdelta=3D33/37/0)

Once I hit one of those, the attempt at pointer fix up makes things worse...
ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=3D16539,
delta=3D11026, period=3D5513, jdelta=3D38/75/0)
ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=3D0,
delta=3D16539, period=3D5513, jdelta=3D37/112/0)
ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=3D5513,
delta=3D22052, period=3D5513, jdelta=3D38/150/0)


>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>



-- =

Jon Smirl
jonsmirl@gmail.com
