From: conn intel <connintel@gmail.com>
Subject: WM8727 & AT91SAM9G45: not enough memory
Date: Tue, 9 Aug 2011 17:43:32 +0530
Message-ID: <CAGSjTd3cto1viVeXcTbrzeXG9MU9iAdiDSsx7WFk2F0goYVGvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F13FA103824
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 14:13:37 +0200 (CEST)
Received: by gwj17 with SMTP id 17so1395919gwj.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2011 05:13:32 -0700 (PDT)
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

I am using WM8727 codec with AT91SAM9G45 processor. I have implemented
machine code as http://pastebin.com/axadqGhd .

After insterting the module I got following output:
# insmod sam9g45_wm8727.ko
atmel-pcm:preallocate_dma_buffer: area=ffadf000, addr=77c40000, size=32768
asoc: WM8727 <-> atmel-ssc0 mapping ok

I am getting following error when I tried to play the wav file using
command "aplay -D default sample_16.wav ":

atmel_ssc_startup: SSC_SR=0x192
Playing WAVE 'sample_16.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
atmel_ssc_hw_params: RCMR=00010721 RFMR=0000008f TCMR=00010702 TFMR=0000008f
atmel_ssc_dai: Starting clock
atmel_ssc_dai,hw_params: SSC initialized
atmel-pcm: hw_params: DMA for SSC0 PCM out initialized
(dma_bytes=32768, period_size=8192)
transmit enabled SSC_SR=0x000104c3
aplayatmel_ssc_shutdown: transmit disabled SSC_SR=0x000000c3
:atmel_ssc_dau: Stopping clock
 set_params:1167: not enough memory


Does anyone throw some light where and how to solve the issue? Kindly
share if one needs further information.

Have a Good Day,
Thank you,
Ankur.
