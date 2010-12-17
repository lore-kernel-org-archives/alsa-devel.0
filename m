From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: callbacks order while capturing from Line-IN
Date: Fri, 17 Dec 2010 07:21:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012170719391.28150@eeebox2.perex-int.cz>
References: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
	<AANLkTik7WwZGnDyE=bfw5_a_PXcERhFF9bPy0qYX=6+v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-896371442-1292566865=:28150"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 96B45103830
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 07:21:07 +0100 (CET)
In-Reply-To: <AANLkTik7WwZGnDyE=bfw5_a_PXcERhFF9bPy0qYX=6+v@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manu Abraham <abraham.manu@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-896371442-1292566865=:28150
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Dec 2010, Manu Abraham wrote:

> On Fri, Dec 17, 2010 at 10:28 AM, Manu Abraham <abraham.manu@gmail.com> w=
rote:
>> Hi,
>>
>> By now I am a bit confused.
>>
>> I am seeing a certain pattern in which the callbacks are invoked:
>>
>> - hw_params()
>> - prepare()
>> - trigger(); // Start DMA
>> - pointer();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--> gets data after interrupt i=
s handled
>> - trigger(); // Stop DMA
>> - prepare();
>> - trigger(); // Start DMA
>> - pointer();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --> gets data after interrupt is hand=
led
>>
>> ..
>> ..
>>
>> and so on.
>>
>> Is this the right behaviour that's expected from a function ALSA
>> capture driver ?
>> I am trying to understand why there is Start DMA, Stop DMA, Start DMA, S=
top DMA
>> in a cyclic fashion for each of the interrupts in my setup.
>
>
> To test my theory that a STOP cmd after an interrupt was giving me the
> same buffer location, I did commented out the STOP cmd, as well,
> allowing the START cmd to run only if the streaming engine has not
> START 'ed.
>
> This allows the interrupt handler to fire correctly with the correct
> buffer indices, as seen in the following logs.
>
> http://pastebin.ca/2021840
>
> The problem is that,
>
> 1. I don't understand why the application issues a CMD to STOP/START,
> after each interrupt.
> 2. The STOP/START cmds reinitializes the Streaming engine to start
> with buffer index:0, therefore always buffer position is at the very
> beginning of the buffer.

I believe that your pointer callback is buggy so the midlevel code things=
=20
that you had and overrun.

http://www.alsa-project.org/main/index.php/XRUN_Debug

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-896371442-1292566865=:28150
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-896371442-1292566865=:28150--
