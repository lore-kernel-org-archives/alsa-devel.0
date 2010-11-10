From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Thu, 11 Nov 2010 00:00:49 +0530
Message-ID: <AANLkTinypyaDPkL-rBU5UsPp1UKbAhNz66nH9kHNnqNS@mail.gmail.com>
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
	<alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D7FF2417D
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 19:31:01 +0100 (CET)
Received: by wwd20 with SMTP id 20so1031547wwd.20
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 10:30:51 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
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

On Wed, Nov 10, 2010 at 11:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Wed, 10 Nov 2010, Manu Abraham wrote:
>
>> On Wed, Nov 10, 2010 at 8:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> On Wed, 10 Nov 2010, Manu Abraham wrote:
>>>>
>>>> =A0 =A0 =A0 =A0/* enable stream */
>>>> =A0 =A0 =A0 =A0/* initializing 8 buffer with "pages" pages each .. */
>>>> =A0 =A0 =A0 =A0stream =3D saa7231_stream_init(saa7231, AUDIO_CAPTURE, =
ADAPTER_INT,
>>>> 0, pages);
>>>> =A0 =A0 =A0 =A0if (!stream) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "ERROR: Regis=
tering stream");
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>>>> =A0 =A0 =A0 =A0}
>>>> =A0 =A0 =A0 =A0audio->stream =3D stream;
>>>> =A0 =A0 =A0 =A0buffer =3D stream->dmabuf;
>>>> =A0 =A0 =A0 =A0saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
>>>> saa7231_audio_evhandler, "AS2D_AVIS");
>>>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d p=
ages
>>>> each",
>>>> XS2D_BUFFERS, pages);
>>>
>>> Unfortunately, I don't understand the role of XS2D_BUFFERS. The ALSA
>>> bufsize
>>> is the whole DMA area (you should use params_buffer_bytes() to get this
>>> value instead of calculating this using periods * period_size).
>>>
>>> It means: Just allocate number of pages required for buffer_bytes. Don't
>>> play with periods (except the interrupts).
>>
>>
>> There are 8 SG buffers for the hardware; the maximum size of each
>> buffer can be 512 pages,
>> the minimum can be a single page.
>
> Could you describe more the whole DMA layout, including IRQ acks?
>
> It seems to me:
>
> SG PAGE 1 points to 1 - 512 data pages (4096 bytes long)
> SG PAGE 2 .....
> =A0 =A0....
> SG PAGE 8 .....


Yes, correct.

My initial thoughts and concepts were thus:
 - A particular buffer size is requested by ALSA
 - this buffer size is set for all the 8 SG buffers
 - A virtual area is created from these 8 SG buffers
 - This virtual area is mmap()'d
 - SG Buffer 0 gets filled
 - Interrupt occurs
 - Driver reads from offset 0 of virtual area
 - SG Buffer 1 gets filled
 - Interrupt occurs
 - Driver reads from offset "buffer size" of virtual area

and so on, the cycle repeats.

Little did I realize at that point of time that buffer size for ALSA
meant the total length of the
buffers.



> How you can program interrupts? Only when the whole page is finished or t=
he
> interrupt does not depend on the DMA buffer position, but a hw clock time=
r?


All 8 SG heads are placed on the MMU. The MMU can be programmed to
generate an IRQ
when "size" buffer is full. Suppose that an SG buffer which is 8 pages
long, but I did program
the MMU to generate an IRQ when eg: 192 bytes of data is filled into
SG buffer. Now, as data
is being digitized and grabbed, I get an interrupt when 192 bytes is
filled in the SG buffer.

When the interrupt occurs, the driver needs to check from hardware
registers, which of the
8 SG buffers has been filled upto say 192 bytes. Now, since I know
that SG buffer 'x' is filled,
I can ask the application to read from the buffer area. This length is
called "stride" by the chip.

Normally, I could say the interrupts would be following a certain
order, SGBUF1, SGBUF2,
but It is indeed necessary to read the buffer index first and then
deduce which SGBUF to read.

Putting it short, even though a whole page is setup for DMA, an
interrupt can be invoked,
depending on setting up the "stride" length, the maximum of which is
the buffer length setup
on the MMU.

There is no hardware clock timer involved in this process. but there
is a hardware feature
where the buffers can be time stamped for reason such as
synchronization with a video stream
for example.


> Could you limit how much data (samples) are fetched from the one data page
> or the hw operates with whole pages only?

You need to setup a whole PAGE on to the MMU, even if you need to
transfer only a byte.

Yes, you can set any number of bytes (stride) to be read from the
whole SG buffer. ie, even
if the SG buffer is 512 pages long, it could contain just contain 4
bytes of data alone
(depending on stride), If I set up the hardware to generate an
interrupt when 4 bytes is filled up.


> Note that the stream processing rate is usually independent from the DMA
> layout in most hw.


Yes. I need to set the number of bytes that will be filled up for a
buffer that causes an interrupt.


Regards,
Manu
