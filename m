From: Ankur Patel <connintel@gmail.com>
Subject: Re: WM8727 & AT91SAM9G45: not enough memory
Date: Wed, 17 Aug 2011 12:02:11 +0530
Message-ID: <CAGSjTd0UqZwRNyh2XXT_GwcaftDofsGbfGWxyTCZ_zjxnE8qZQ@mail.gmail.com>
References: <CAGSjTd3cto1viVeXcTbrzeXG9MU9iAdiDSsx7WFk2F0goYVGvQ@mail.gmail.com>
	<CAGSjTd1FrP5cC05ZZovGRgHSrdYCYXVpYpW=xj+MkvfC6EcRHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 94CA21038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 08:32:12 +0200 (CEST)
Received: by ywt32 with SMTP id 32so530002ywt.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2011 23:32:11 -0700 (PDT)
In-Reply-To: <CAGSjTd1FrP5cC05ZZovGRgHSrdYCYXVpYpW=xj+MkvfC6EcRHw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Friends,

Atlast, I found some audio on the speaker and now able to get the
clocks after modification in setting
up the proper clock divisor. Please find the working driver at
http://pastebin.com/i5PrFxC7.

Thank you,
Ankur.

On Wed, Aug 10, 2011 at 11:17 AM, conn intel <connintel@gmail.com> wrote:
> Dear Friends,
>
> While searching further into the mailinglist I came across
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/031209.h=
tml
> having the similar issue.
>
> I have also tried running "cat /dev/urandom > /dev/audio" and found
> following output same as in the link above:
> # cat /dev/urandom > /dev/audio
> atmel_ssc_startup: SSC_SR=3D0x204
> atmel_ssc_hw_params: RCMR=3D00010721 RFMR=3D0000008f TCMR=3D00010702 TFMR=
=3D0000008f
> atmel_ssc_dai: Starting clock
> atmel_ssc_dai,hw_params: SSC initialized
> atmel-pcm: hw_params: DMA for SSC0 PCM out initialized
> (dma_bytes=3D32768, period_size=3D8192)
> transmit enabled SSC_SR=3D0x000104cf
> atmel-pcm:buffer_size =3D 8192,dma_area =3D ffac1000, dma_bytes =3D 32768
> atmel-pcm: trigger: period_ptr=3D77962000, xpr=3D2006319104, xcr=3D4096,
> xnpr=3D2006327296, xncr=3D4096
> sr=3D65731 imr=3D0
> ALSA sound/core/pcm_lib.c:1708: playback write error (DMA or IRQ trouble?)
> ALSA sound/core/pcm_lib.c:1708: playback write error (DMA or IRQ trouble?)
> cat: write error: Input/output error
> ALSA sound/core/pcm_native.c:1482: playback drain error (DMA or IRQ troub=
le?)
> atmel-pcm:buffer_size =3D 8192,dma_area =3D ffac1000, dma_bytes =3D 32768
> atmel_ssc_shutdown: transmit disabled SSC_SR=3D0x000000c0
> atmel_ssc_dau: Stopping clock
>
> Andras: Can you please share if you are able to solve the issue? If
> yes, where should I look into?
>
> Any suggestions/thoughts will be helpful.
>
> Have a Good Day,
> Ankur.
>
> On Tue, Aug 9, 2011 at 5:43 PM, conn intel <connintel@gmail.com> wrote:
>> Dear Friends,
>>
>> I am using WM8727 codec with AT91SAM9G45 processor. I have implemented
>> machine code as http://pastebin.com/axadqGhd .
>>
>> After insterting the module I got following output:
>> # insmod sam9g45_wm8727.ko
>> atmel-pcm:preallocate_dma_buffer: area=3Dffadf000, addr=3D77c40000, size=
=3D32768
>> asoc: WM8727 <-> atmel-ssc0 mapping ok
>>
>> I am getting following error when I tried to play the wav file using
>> command "aplay -D default sample_16.wav ":
>>
>> atmel_ssc_startup: SSC_SR=3D0x192
>> Playing WAVE 'sample_16.wav' : Signed 16 bit Little Endian, Rate 44100
>> Hz, Stereo
>> atmel_ssc_hw_params: RCMR=3D00010721 RFMR=3D0000008f TCMR=3D00010702 TFM=
R=3D0000008f
>> atmel_ssc_dai: Starting clock
>> atmel_ssc_dai,hw_params: SSC initialized
>> atmel-pcm: hw_params: DMA for SSC0 PCM out initialized
>> (dma_bytes=3D32768, period_size=3D8192)
>> transmit enabled SSC_SR=3D0x000104c3
>> aplayatmel_ssc_shutdown: transmit disabled SSC_SR=3D0x000000c3
>> :atmel_ssc_dau: Stopping clock
>> =A0set_params:1167: not enough memory
>>
>>
>> Does anyone throw some light where and how to solve the issue? Kindly
>> share if one needs further information.
>>
>> Have a Good Day,
>> Thank you,
>> Ankur.
>>
>
