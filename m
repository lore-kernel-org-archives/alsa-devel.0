From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: mapping externally allocated Scatter Gather DMA
 buffers
Date: Wed, 10 Nov 2010 19:05:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
	<alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
	<AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
	<alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
	<AANLkTimTrFLv911vVm-eH9EqDyXEwg-y4uFkqbUyVB7v@mail.gmail.com>
	<alpine.LNX.2.00.1011100755560.29422@eeebox2.perex-int.cz>
	<AANLkTi=2pO+x=Okt8RXPJe2TqGexEX70oMCFAtBAkm2U@mail.gmail.com>
	<alpine.LNX.2.00.1011101228061.29422@eeebox2.perex-int.cz>
	<AANLkTim=NT4cPQV+c3Y7eZF81Pv6R--vRgT_jGj7xZQJ@mail.gmail.com>
	<alpine.LNX.2.00.1011101515420.29422@eeebox2.perex-int.cz>
	<AANLkTi=gjN1xfnMZ4R29Sq_=fxYAfJwOQmD_+6beLYSp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1153100156-1289412319=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6309224414
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 19:05:20 +0100 (CET)
In-Reply-To: <AANLkTi=gjN1xfnMZ4R29Sq_=fxYAfJwOQmD_+6beLYSp@mail.gmail.com>
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

--8323584-1153100156-1289412319=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Nov 2010, Manu Abraham wrote:

> On Wed, Nov 10, 2010 at 8:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Wed, 10 Nov 2010, Manu Abraham wrote:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* enable stream */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* initializing 8 buffer with "pages" pages =
each .. */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0stream =3D saa7231_stream_init(saa7231, AUDI=
O_CAPTURE, ADAPTER_INT,
>>> 0, pages);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!stream) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dprintk(SAA7231_=
ERROR, 1, "ERROR: Registering stream");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0audio->stream =3D stream;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0buffer =3D stream->dmabuf;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0saa7231_add_irqevent(saa7231, 43, SAA7231_ED=
GE_RISING,
>>> saa7231_audio_evhandler, "AS2D_AVIS");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0dprintk(SAA7231_DEBUG, 1, "Mapping %d buffer=
s with %d pages each",
>>> XS2D_BUFFERS, pages);
>>
>> Unfortunately, I don't understand the role of XS2D_BUFFERS. The ALSA buf=
size
>> is the whole DMA area (you should use params_buffer_bytes() to get this
>> value instead of calculating this using periods * period_size).
>>
>> It means: Just allocate number of pages required for buffer_bytes. Don't
>> play with periods (except the interrupts).
>
>
> There are 8 SG buffers for the hardware; the maximum size of each
> buffer can be 512 pages,
> the minimum can be a single page.

Could you describe more the whole DMA layout, including IRQ acks?

It seems to me:

SG PAGE 1 points to 1 - 512 data pages (4096 bytes long)
SG PAGE 2 .....
     ....
SG PAGE 8 .....

How you can program interrupts? Only when the whole page is finished or=20
the interrupt does not depend on the DMA buffer position, but a hw clock=20
timer?

Could you limit how much data (samples) are fetched from the one data page=
=20
or the hw operates with whole pages only?

Note that the stream processing rate is usually independent from the DMA=20
layout in most hw.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1153100156-1289412319=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1153100156-1289412319=:29422--
