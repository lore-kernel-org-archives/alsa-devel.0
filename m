From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: mapping externally allocated Scatter Gather DMA
 buffers
Date: Thu, 11 Nov 2010 11:30:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011111113030.29422@eeebox2.perex-int.cz>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
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
	<alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
	<AANLkTimXTdWRrdA8+ToQp-gPofKohaSJ_Ss5x4S42uo5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-873732583-1289471444=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BE6E21038E6
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 11:30:44 +0100 (CET)
In-Reply-To: <AANLkTimXTdWRrdA8+ToQp-gPofKohaSJ_Ss5x4S42uo5@mail.gmail.com>
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

--8323584-873732583-1289471444=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Nov 2010, Manu Abraham wrote:

> On Wed, Nov 10, 2010 at 11:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Wed, 10 Nov 2010, Manu Abraham wrote:
>>
>>> On Wed, Nov 10, 2010 at 8:35 PM, Jaroslav Kysela <perex@perex.cz> wrote=
:
>>>>
>>>> On Wed, 10 Nov 2010, Manu Abraham wrote:
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* enable stream */
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* initializing 8 buffer with "pages" page=
s each .. */
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0stream =3D saa7231_stream_init(saa7231, AU=
DIO_CAPTURE, ADAPTER_INT,
>>>>> 0, pages);
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!stream) {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dprintk(SAA723=
1_ERROR, 1, "ERROR: Registering stream");
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM=
;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0audio->stream =3D stream;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0buffer =3D stream->dmabuf;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0saa7231_add_irqevent(saa7231, 43, SAA7231_=
EDGE_RISING,
>>>>> saa7231_audio_evhandler, "AS2D_AVIS");
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0dprintk(SAA7231_DEBUG, 1, "Mapping %d buff=
ers with %d pages
>>>>> each",
>>>>> XS2D_BUFFERS, pages);
>>>>
>>>> Unfortunately, I don't understand the role of XS2D_BUFFERS. The ALSA
>>>> bufsize
>>>> is the whole DMA area (you should use params_buffer_bytes() to get thi=
s
>>>> value instead of calculating this using periods * period_size).
>>>>
>>>> It means: Just allocate number of pages required for buffer_bytes. Don=
't
>>>> play with periods (except the interrupts).
>>>
>>>
>>> There are 8 SG buffers for the hardware; the maximum size of each
>>> buffer can be 512 pages,
>>> the minimum can be a single page.
>>
>> Could you describe more the whole DMA layout, including IRQ acks?
>>
>> It seems to me:
>>
>> SG PAGE 1 points to 1 - 512 data pages (4096 bytes long)
>> SG PAGE 2 .....
>> =C2=A0 =C2=A0....
>> SG PAGE 8 .....
>
>
> I adapted the whole thing to make the buffersize divided amongst the
> XS2D_BUFFERS (8):

Probably yes.

> I hope the mapping of the buffers is okay ? It looks thus, now ..

From=20information you sent me about hw privately, I think that the=20
period_bytes must be 4096 or multiple of this value with minumum count of=
=20
periods 8 (or multiple of 8). Otherwise you get a non-continuous memory=20
area (the hw uses only portion of system memory page, thus there'll be=20
gaps). The problem is that we have MMAP_COMPLEX mode, but no application=20
can handle (does not implement) this mmap mode and I'm not sure, if we=20
can even describe the DMA buffer size layout for this case for your=20
specific hw.

I would use:

         snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_B=
YTES,
 =09=09=09=09  4096);


 =09snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIODS,
 =09=09=09=09   8);

And define periods_min =3D 8 (max to multiple 8 - choose your max limit) an=
d=20
period_bytes_min to 4096 (max to multiple 4096 - choose your max limit).

Note that -EIO means that your driver does not called=20
snd_pcm_period_elapsed() and/or the pointer callback returns wrong=20
position to the audio ring buffer.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-873732583-1289471444=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-873732583-1289471444=:29422--
