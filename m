From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Breakage in pcm_lib.c
Date: Sun, 26 Apr 2009 18:31:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904261820460.25064@eeebox2.perex-int.cz>
References: <9e4733910904251756y6534d2d0x6c201d00cbc728d9@mail.gmail.com>
	<9e4733910904251848q4d64c413ld5af61019edae647@mail.gmail.com>
	<alpine.LNX.2.00.0904261000520.25064@eeebox2.perex-int.cz>
	<9e4733910904260821xd2d8790me58993df9f530c6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-367885570-1240763115=:25064"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A5AEF2434B
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 18:31:22 +0200 (CEST)
In-Reply-To: <9e4733910904260821xd2d8790me58993df9f530c6f@mail.gmail.com>
Content-ID: <alpine.LNX.2.00.0904261828140.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-367885570-1240763115=:25064
Content-Type: TEXT/PLAIN; CHARSET=UTF-8; FORMAT=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.LNX.2.00.0904261825241.25064@eeebox2.perex-int.cz>

On Sun, 26 Apr 2009, Jon Smirl wrote:

> On Sun, Apr 26, 2009 at 4:12 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Sat, 25 Apr 2009, Jon Smirl wrote:
>>
>>> This appears to be a bug in this code...
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (delta < 0) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delta +=3D runti=
me->period_size * runtime->periods;
>>>
>>> it was adding, buffer_size. But buffer_size is not correct when the
>>> periods don't evenly fit into the buffer
>>
>> Could you show real values what you're getting here with your driver?
>
> psc_dma_pcm_pointer pos 0
> hw_ptr_interrupt 22052 new_hw_ptr 0

pos should be >2 here for buffer_size =3D 22050 and period_size =3D 5513..=
=20
Your driver code is broken - the routine must be called when period_size=20
is processed - not before and .pointer callback must return correct value=
=20
at this point..

So pos at interrupt time should be equal or slightly greater than:

5513, 11026, 16540, 22054 % 22050 =3D 4, 5517 etc..

pos is position from  range 0 .. (buffer_size - 1) not from range 0 ..=20
(periods * period_size).

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
--8323584-367885570-1240763115=:25064
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-367885570-1240763115=:25064--
