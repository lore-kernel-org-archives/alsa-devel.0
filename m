From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Breakage in pcm_lib.c
Date: Sun, 26 Apr 2009 12:45:32 -0400
Message-ID: <9e4733910904260945h432a26f9h31fcfac36f864e8@mail.gmail.com>
References: <9e4733910904251756y6534d2d0x6c201d00cbc728d9@mail.gmail.com>
	<9e4733910904251848q4d64c413ld5af61019edae647@mail.gmail.com>
	<alpine.LNX.2.00.0904261000520.25064@eeebox2.perex-int.cz>
	<9e4733910904260821xd2d8790me58993df9f530c6f@mail.gmail.com>
	<alpine.LNX.2.00.0904261820460.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 6472724356
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 18:45:33 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1540056qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2009 09:45:32 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904261820460.25064@eeebox2.perex-int.cz>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 12:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Sun, 26 Apr 2009, Jon Smirl wrote:
>
>> On Sun, Apr 26, 2009 at 4:12 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> On Sat, 25 Apr 2009, Jon Smirl wrote:
>>>
>>>> This appears to be a bug in this code...
>>>>
>>>> =A0 =A0 =A0 =A0if (delta < 0) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0delta +=3D runtime->period_size * runti=
me->periods;
>>>>
>>>> it was adding, buffer_size. But buffer_size is not correct when the
>>>> periods don't evenly fit into the buffer
>>>
>>> Could you show real values what you're getting here with your driver?
>>
>> psc_dma_pcm_pointer pos 0
>> hw_ptr_interrupt 22052 new_hw_ptr 0
>
> pos should be >2 here for buffer_size =3D 22050 and period_size =3D 5513.=
. Your
> driver code is broken - the routine must be called when period_size is
> processed - not before and .pointer callback must return correct value at
> this point..
>
> So pos at interrupt time should be equal or slightly greater than:
>
> 5513, 11026, 16540, 22054 % 22050 =3D 4, 5517 etc..
>
> pos is position from =A0range 0 .. (buffer_size - 1) not from range 0 ..
> (periods * period_size).

So the DMA hardware needs to be able to wrap that last packet in the
buffer? I will need to turn that into two DMA operations which will
cause two interrupts, is that ok?

This code was originally written with the assumption that an integral
number of periods would fit into the DMA buffer.


>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.



-- =

Jon Smirl
jonsmirl@gmail.com
