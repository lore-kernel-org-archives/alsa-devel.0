From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: mapping externally allocated Scatter Gather DMA
 buffers
Date: Tue, 9 Nov 2010 15:34:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
	<alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
	<AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-857310912-1289313276=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 85E7D1037F9
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 15:34:36 +0100 (CET)
In-Reply-To: <AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-857310912-1289313276=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 9 Nov 2010, Manu Abraham wrote:

> On Tue, Nov 9, 2010 at 6:21 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Tue, 9 Nov 2010, Manu Abraham wrote:
>>
>>> On Tue, Nov 9, 2010 at 5:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>>
>>>> On Tue, 9 Nov 2010, Manu Abraham wrote:
>>>>
>>>>> testbox ~ # arecord -Dhw:2,0
>>>>> Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
>>>>
>>>>> Any idea, why saa7231_hw_params is not getting invoked ?
>>>>
>>>> Your hw probably does not support directly 8-bit sample at 8000Hz, one
>>>> channel. Use 'plughw:2,0' device instead 'hw:2,0' to let alsa-lib do a=
ll
>>>> stream format conversions.
>>>
>>> That didn't make any difference at all.
>>
>> Check your code. You probably created wrong hw_ops, looking to your code=
:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.buffer_bytes_max =C2=A0 =C2=A0 =C2=A0 =3D 51=
2 * 4096,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.period_bytes_min =C2=A0 =C2=A0 =C2=A0 =3D 81=
92,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.period_bytes_max =C2=A0 =C2=A0 =C2=A0 =3D 81=
92,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.periods_min =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 8192,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.periods_max =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 8192,
>>
>> It's definitely an empty configuration space.
>>
>> You have buffer_bytes_max 2097152, but restricted number of periods to 8=
192
>> and period_bytes to 8192.
>>
>> 8192 * 8192 =3D 67108864 which is not less than 2097152 (and I'm not cou=
nting
>> the bytes for channels and formats). Bingo, the ALSA PCM code does not k=
now
>> what to configure.
>>
>> Decrease periods_min and probably also periods_max.
>>
>
> oh ! The error message was really a weird one. I can say that the
> hardware can do 192 audio frames in an interrupt, whatever the frame
> size is. So, what periods and period_bytes should I describe in the
> configuration ?

You cannot describe this using hw_ops. Leave period bytes in good range=20
(192 - 1536?), periods (2-1024?) and add something like this to the open=20
callback:

        err =3D snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PE=
RIOD_SIZE,
                                           192, 192);

Note the difference between SNDRV_PCM_HW_PARAM_PERIOD_SIZE and=20
SNDRV_PCM_HW_PARAM_PERIOD_BYTES.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-857310912-1289313276=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-857310912-1289313276=:29422--
