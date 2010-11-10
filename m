From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Wed, 10 Nov 2010 21:56:40 +0530
Message-ID: <AANLkTi=gjN1xfnMZ4R29Sq_=fxYAfJwOQmD_+6beLYSp@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 79B9B24546
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 17:26:41 +0100 (CET)
Received: by fxm14 with SMTP id 14so90269fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 08:26:41 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011101515420.29422@eeebox2.perex-int.cz>
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

On Wed, Nov 10, 2010 at 8:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Wed, 10 Nov 2010, Manu Abraham wrote:
>> =A0 =A0 =A0 =A0/* enable stream */
>> =A0 =A0 =A0 =A0/* initializing 8 buffer with "pages" pages each .. */
>> =A0 =A0 =A0 =A0stream =3D saa7231_stream_init(saa7231, AUDIO_CAPTURE, AD=
APTER_INT,
>> 0, pages);
>> =A0 =A0 =A0 =A0if (!stream) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "ERROR: Registe=
ring stream");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0audio->stream =3D stream;
>> =A0 =A0 =A0 =A0buffer =3D stream->dmabuf;
>> =A0 =A0 =A0 =A0saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
>> saa7231_audio_evhandler, "AS2D_AVIS");
>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d pag=
es each",
>> XS2D_BUFFERS, pages);
>
> Unfortunately, I don't understand the role of XS2D_BUFFERS. The ALSA bufs=
ize
> is the whole DMA area (you should use params_buffer_bytes() to get this
> value instead of calculating this using periods * period_size).
>
> It means: Just allocate number of pages required for buffer_bytes. Don't
> play with periods (except the interrupts).


There are 8 SG buffers for the hardware; the maximum size of each
buffer can be 512 pages,
the minimum can be a single page.

Since each of the 8 buffers, the minimum buffer size of each buffer is
4096 bytes, the total
minimum ALSA buffer size would be 8 * 4096 bytes =3D 32768 bytes,
and a maximum of 8 * 512 * 4096 =3D 16777216 bytes

So, I should calculate the periods and period bytes based on the
buffer size involved ?
ie: it could turn out to be hard to get exact values for each of the
sampling rates involved ?

Regards,
Manu
