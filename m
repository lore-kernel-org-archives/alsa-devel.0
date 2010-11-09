From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Tue, 9 Nov 2010 19:15:33 +0530
Message-ID: <AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
	<alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AB3B1037EA
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 14:45:35 +0100 (CET)
Received: by wyb33 with SMTP id 33so4895607wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 05:45:35 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 9, 2010 at 6:21 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 9 Nov 2010, Manu Abraham wrote:
>
>> On Tue, Nov 9, 2010 at 5:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> On Tue, 9 Nov 2010, Manu Abraham wrote:
>>>
>>>> testbox ~ # arecord -Dhw:2,0
>>>> Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
>>>
>>>> Any idea, why saa7231_hw_params is not getting invoked ?
>>>
>>> Your hw probably does not support directly 8-bit sample at 8000Hz, one
>>> channel. Use 'plughw:2,0' device instead 'hw:2,0' to let alsa-lib do all
>>> stream format conversions.
>>
>> That didn't make any difference at all.
>
> Check your code. You probably created wrong hw_ops, looking to your code:
>
> =A0 =A0 =A0 =A0.buffer_bytes_max =A0 =A0 =A0 =3D 512 * 4096,
> =A0 =A0 =A0 =A0.period_bytes_min =A0 =A0 =A0 =3D 8192,
> =A0 =A0 =A0 =A0.period_bytes_max =A0 =A0 =A0 =3D 8192,
> =A0 =A0 =A0 =A0.periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 8192,
> =A0 =A0 =A0 =A0.periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 8192,
>
> It's definitely an empty configuration space.
>
> You have buffer_bytes_max 2097152, but restricted number of periods to 81=
92
> and period_bytes to 8192.
>
> 8192 * 8192 =3D 67108864 which is not less than 2097152 (and I'm not coun=
ting
> the bytes for channels and formats). Bingo, the ALSA PCM code does not kn=
ow
> what to configure.
>
> Decrease periods_min and probably also periods_max.
>

oh ! The error message was really a weird one. I can say that the
hardware can do 192 audio frames in an interrupt, whatever the frame
size is. So, what periods and period_bytes should I describe in the
configuration ?

Best Regards,
Manu
